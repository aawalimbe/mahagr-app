import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/saved_documents_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/viewer_bottomNevigator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String pdfUrl;
  final String documentTitle;
  final String? localFilePath;

  const PdfViewer({
    super.key,
    required this.pdfUrl,
    required this.documentTitle,
    this.localFilePath,
  });

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool _isLoading = true;
  String? _error;
  File? _downloadedFile;
  bool _isPortrait = true;
  bool _isDownloading = false;
  bool _isSaving = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    // Lock to portrait initially
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _loadPDF();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final isSaved = await SavedDocumentsService.isDocumentSaved(widget.pdfUrl);
    if (mounted) {
      setState(() {
        _isSaved = isSaved;
      });
    }
  }

  Future<void> _loadPDF() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // If local file path is provided, use it directly
      if (widget.localFilePath != null) {
        final file = File(widget.localFilePath!);
        if (await file.exists()) {
          _downloadedFile = file;
          setState(() => _isLoading = false);
          return;
        }
      }

      // Otherwise, use the default location based on title and URL hash
      // Use URL hash to ensure unique filename even if titles are the same
      final dir = await getApplicationDocumentsDirectory();
      final sanitizedName = widget.documentTitle
          .replaceAll(RegExp(r"[^\w\s-]"), "")
          .replaceAll(RegExp(r"\s+"), "_");
      // Create hash from PDF URL to ensure uniqueness
      final urlHash = widget.pdfUrl.hashCode.toRadixString(36).replaceAll('-', 'a');
      final uniqueFileName = "${sanitizedName}_$urlHash.pdf";
      final file = File("${dir.path}/$uniqueFileName");

      // Delete previous cached PDF if it exists and is different from current
      await _deletePreviousCache(file.path);

      // Always check if this specific PDF URL's file exists
      // If file exists but is from a different PDF (different URL), re-download
      if (!await file.exists()) {
        final bytes = await ApiService.downloadFilefromUrl(widget.pdfUrl);
        await file.writeAsBytes(bytes);
      }
      _downloadedFile = file;

      // Store current cache file path for next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_cached_pdf_path', file.path);

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Error loading PDF: $e";
      });
    }
  }

  Future<void> _deletePreviousCache(String currentFilePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final previousCachePath = prefs.getString('last_cached_pdf_path');
      
      // If there's a previous cache file and it's different from current, delete it
      if (previousCachePath != null && previousCachePath != currentFilePath) {
        final previousFile = File(previousCachePath);
        // Only delete if it exists and is not a saved document
        // Saved documents are in a subdirectory, so we check the path
        if (await previousFile.exists() && !previousCachePath.contains('saved_documents')) {
          await previousFile.delete();
        }
      }
    } catch (e) {
      // Silently fail - cache cleanup is not critical
      print('Error deleting previous cache: $e');
    }
  }

  void _rotate() {
    // Simply toggle rotation state - no device orientation change
    // This will only rotate the PDF viewer widget visually
    setState(() {
      _isPortrait = !_isPortrait;
      // Create new key to force PDF viewer to rebuild with new orientation
      _pdfViewerKey = GlobalKey<SfPdfViewerState>();
    });
  }

  Future<void> _share() async {
    if (_downloadedFile == null) return;

    await Share.shareXFiles([
      XFile(_downloadedFile!.path),
    ], text: "Sharing: ${widget.documentTitle}");
  }

  Future<void> _download() async {
    if (_downloadedFile == null) return;

    setState(() => _isDownloading = true);

    await Future.delayed(const Duration(milliseconds: 500));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved at: ${_downloadedFile!.path}")),
    );

    setState(() => _isDownloading = false);
  }

  Future<void> _saveDocument() async {
    if (_downloadedFile == null || _isSaving) return;

    // Check if already saved
    if (_isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This document is already saved"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final success = await SavedDocumentsService.saveDocument(
        title: widget.documentTitle,
        originalUrl: widget.pdfUrl,
        sourceFile: _downloadedFile!,
      );

      if (mounted) {
        setState(() {
          _isSaving = false;
          if (success) {
            _isSaved = true;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? "Document saved successfully!"
                  : "Document already saved or error occurred",
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error saving document: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Reset orientation to portrait when leaving
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _loadPDF,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
                : _downloadedFile != null
                ? LayoutBuilder(
                  builder: (context, constraints) {
                    // Get available space (after AppBar and bottom nav)
                    final availableWidth = constraints.maxWidth;
                    final availableHeight = constraints.maxHeight;

                    // Get full screen dimensions using MediaQuery
                    final mediaQuery = MediaQuery.of(context);
                    final screenWidth = mediaQuery.size.width;
                    final screenHeight = mediaQuery.size.height;

                    if (_isPortrait) {
                      // Portrait mode - display normally using full available space
                      return SizedBox(
                        width: availableWidth,
                        height: availableHeight,
                        child: SfPdfViewer.file(
                          _downloadedFile!,
                          key: _pdfViewerKey,
                          enableDoubleTapZooming: true,
                          enableTextSelection: true,
                        ),
                      );
                    } else {
                      // Landscape mode - rotate only the PDF viewer widget
                      // Use OverflowBox with full screen dimensions to fill entire width
                      return OverflowBox(
                        maxWidth:
                            screenHeight, // After rotation, this becomes the width
                        maxHeight:
                            screenWidth, // After rotation, this becomes the height
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: math.pi / 2,
                          alignment: Alignment.center,
                          child: SizedBox(
                            // After 90-degree rotation:
                            // - screenHeight becomes the width (fills full screen width)
                            // - screenWidth becomes the height
                            // This ensures the rotated PDF uses full screen width
                            width: screenHeight,
                            height: screenWidth,
                            child: SfPdfViewer.file(
                              _downloadedFile!,
                              key: _pdfViewerKey,
                              enableDoubleTapZooming: true,
                              enableTextSelection: true,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
                : const Center(child: Text("PDF file not available")),
        bottomNavigationBar: ViewerBottomNavigator(
          onShare: _share,
          onSave: _isSaving ? () {} : _saveDocument,
          onDownload: _isDownloading ? () {} : _download,
          onRotate: _rotate,
          isSaved: _isSaved,
        ),
      ),
    );
  }
}
