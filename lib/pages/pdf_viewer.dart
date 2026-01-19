import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/saved_documents_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/viewer_bottomNevigator.dart';
import 'package:open_filex/open_filex.dart';
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
      setState(() => _isSaved = isSaved);
    }
  }

  Future<void> _loadPDF() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      if (widget.localFilePath != null) {
        final file = File(widget.localFilePath!);
        if (await file.exists()) {
          _downloadedFile = file;
          setState(() => _isLoading = false);
          return;
        }
      }

      final dir = await getApplicationDocumentsDirectory();
      final sanitizedName = widget.documentTitle
          .replaceAll(RegExp(r"[^\w\s-]"), "")
          .replaceAll(RegExp(r"\s+"), "_");

      final urlHash = widget.pdfUrl.hashCode
          .toRadixString(36)
          .replaceAll('-', 'a');

      final uniqueFileName = "${sanitizedName}_$urlHash.pdf";
      final file = File("${dir.path}/$uniqueFileName");

      await _deletePreviousCache(file.path);

      if (!await file.exists()) {
        final bytes = await ApiService.downloadFilefromUrl(widget.pdfUrl);
        await file.writeAsBytes(bytes);
      }

      _downloadedFile = file;

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

      if (previousCachePath != null && previousCachePath != currentFilePath) {
        final previousFile = File(previousCachePath);
        if (await previousFile.exists() &&
            !previousCachePath.contains('saved_documents')) {
          await previousFile.delete();
        }
      }
    } catch (_) {}
  }

  void _rotate() {
    setState(() {
      _isPortrait = !_isPortrait;
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

    if (!mounted) return;

    setState(() => _isDownloading = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "PDF Saved",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("PDF is saved on your local device."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
              },
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close popup
                await OpenFilex.open(_downloadedFile!.path);
              },
              child: const Text("Open PDF"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDocument() async {
    if (_downloadedFile == null || _isSaving) return;

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

    final success = await SavedDocumentsService.saveDocument(
      title: widget.documentTitle,
      originalUrl: widget.pdfUrl,
      sourceFile: _downloadedFile!,
    );

    if (mounted) {
      setState(() {
        _isSaving = false;
        if (success) _isSaved = true;
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
  }

  @override
  void dispose() {
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
                      Text(_error!, style: const TextStyle(color: Colors.red)),
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
                    final availableWidth = constraints.maxWidth;
                    final availableHeight = constraints.maxHeight;

                    if (_isPortrait) {
                      return SizedBox(
                        width: availableWidth,
                        height: availableHeight,
                        child: SfPdfViewer.file(
                          _downloadedFile!,
                          key: _pdfViewerKey,
                        ),
                      );
                    }

                    // ✅ FIXED LANDSCAPE
                    return OverflowBox(
                      maxWidth: availableHeight,
                      maxHeight: availableWidth,
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: SizedBox(
                          width: availableHeight,
                          height: availableWidth,
                          child: SfPdfViewer.file(
                            _downloadedFile!,
                            key: _pdfViewerKey,
                          ),
                        ),
                      ),
                    );
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
