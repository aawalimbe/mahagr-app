import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/viewer_bottomNevigator.dart';

class PdfViewer extends StatefulWidget {
  final String documentTitle;

  const PdfViewer({super.key, required this.documentTitle});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PdfControllerPinch? _pdfController;

  bool _isLoading = true;
  bool _isPortrait = true;
  bool _isDownloading = false;

  String? _error;
  File? _localPdfFile;

  @override
  void initState() {
    super.initState();
    _loadLocalPdf();
  }

  Future<void> _loadLocalPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/DOC-20251216-WA0020..pdf');

      if (!await file.exists()) {
        final bytes = await rootBundle.load(
          'assets/images/original/DOC-20251216-WA0020..pdf',
        );
        await file.writeAsBytes(bytes.buffer.asUint8List());
      }

      _localPdfFile = file;

      _pdfController ??= PdfControllerPinch(
        document: PdfDocument.openFile(file.path),
      );

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load PDF: $e';
      });
    }
  }

  void _rotate() {
    setState(() {
      _isPortrait = !_isPortrait;
    });
  }

  Future<void> _share() async {
    if (_localPdfFile == null) return;

    await Share.shareXFiles([
      XFile(_localPdfFile!.path),
    ], text: widget.documentTitle);
  }

  Future<void> _download() async {
    if (_localPdfFile == null) return;

    setState(() => _isDownloading = true);

    await Future.delayed(const Duration(milliseconds: 400));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved at: ${_localPdfFile!.path}')),
    );

    setState(() => _isDownloading = false);
  }

  @override
  void dispose() {
    _pdfController?.dispose();
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
                        onPressed: _loadLocalPdf,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
                : Center(
                  child: Transform.rotate(
                    angle: _isPortrait ? 0 : math.pi / 2,
                    child: PdfViewPinch(controller: _pdfController!),
                  ),
                ),
        bottomNavigationBar: ViewerBottomNavigator(
          onShare: _share,
          onDownload: _isDownloading ? () {} : _download,
          onRotate: _rotate,
        ),
      ),
    );
  }
}





// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdfx/pdfx.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/viewer_bottomNevigator.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

// class PdfViewer extends StatefulWidget {
//   final String pdfUrl;
//   final String documentTitle;

//   const PdfViewer({
//     super.key,
//     required this.pdfUrl,
//     required this.documentTitle,
//   });

//   @override
//   State<PdfViewer> createState() => _PdfViewerState();
// }

// class _PdfViewerState extends State<PdfViewer> {
//   PdfControllerPinch? _pdfController;
//   bool _isLoading = true;
//   String? _error;
//   File? _downloadedFile;

//   bool _isPortrait = true;
//   bool _isDownloading = false;
//   bool _isRotating = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPDF();
//   }

//   Future<void> _loadPDF() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _error = null;
//       });

//       final dir = await getApplicationDocumentsDirectory();
//       final sanitizedName = widget.documentTitle.replaceAll(
//         RegExp(r"[^\w\s-]"),
//         "",
//       );
//       final file = File("${dir.path}/$sanitizedName.pdf");

//       // Check if file already exists, if not download it
//       if (!await file.exists()) {
//         final bytes = await ApiService.downloadFilefromUrl(widget.pdfUrl);
//         await file.writeAsBytes(bytes);
//       }
//       _downloadedFile = file;

//       // Only create controller if it doesn't exist
//       if (_pdfController == null) {
//         _pdfController = PdfControllerPinch(
//           document: PdfDocument.openFile(file.path),
//         );
//       }

//       setState(() => _isLoading = false);
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _error = "Error loading PDF: $e";
//       });
//     }
//   }

//   Future<void> _share() async {
//     if (_downloadedFile != null) {
//       await Share.shareXFiles([
//         XFile(_downloadedFile!.path),
//       ], text: "Sharing: ${widget.documentTitle}");
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("File not ready")));
//     }
//   }

//   Future<void> _download() async {
//     if (_downloadedFile == null) return;

//     setState(() => _isDownloading = true);

//     await Future.delayed(const Duration(milliseconds: 500));

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("PDF saved at: ${_downloadedFile!.path}")),
//     );

//     setState(() => _isDownloading = false);
//   }

//   void _rotate() async {
//     if (_isRotating || !mounted) return;
    
//     setState(() {
//       _isRotating = true;
//     });
    
//     try {
//       if (_isPortrait) {
//         await SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight,
//         ]);
//       } else {
//         await SystemChrome.setPreferredOrientations([
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//       }

//       if (mounted) {
//         setState(() {
//           _isPortrait = !_isPortrait;
//         });
        
//         // Wait for widget tree and PDF to rebuild after orientation change
//         // Add longer delay to ensure PDF has finished reloading before allowing navigation
//         await Future.delayed(const Duration(milliseconds: 800));
        
//         // Wait for one more frame to ensure everything is stable
//         await Future.delayed(const Duration(milliseconds: 100));
        
//         if (mounted) {
//           setState(() {
//             _isRotating = false;
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _isRotating = false;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _pdfController?.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: !_isRotating && !_isLoading,
//       child: SafeArea(
//         child: CustomScaffold(
//           body:
//               _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : _error != null
//                   ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(_error!, style: const TextStyle(color: Colors.red)),
//                         const SizedBox(height: 12),
//                         ElevatedButton(
//                           onPressed: _loadPDF,
//                           child: const Text("Retry"),
//                         ),
//                       ],
//                     ),
//                   )
//                   : PdfViewPinch(controller: _pdfController!),

//           bottomNavigationBar: ViewerBottomNavigator(
//             onShare: _share,
//             onDownload: _isDownloading ? () {} : _download,
//             onRotate: _rotate,
//           ),
//         ),
//       ),
//     );
//   }
// }
