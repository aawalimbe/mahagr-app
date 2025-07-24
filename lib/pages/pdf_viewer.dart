import 'dart:io';
import 'package:dio/dio.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_sub_departments.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PdfControllerPinch? _pdfController;
  bool _isPortrait = true;
  File? _downloadedFile;
  bool _isloading = true;
  String? _error;

  final String pdfApiUrl = 'our url';
  final String pdfFileName = 'our file name';

  @override
  void initState() {
    super.initState();
    _fetchAndLoadPdf();
  }

  Future<void> _fetchAndLoadPdf() async {
    try {
      // Old API download code commented out for now
      /*
      final response = await Dio().get(
        pdfApiUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final dir = await getApplicationDocumentsDirectory();
      final file = File(' [dir.path}/$pdfFileName');
      await file.writeAsBytes(response.data);

      final document = PdfDocument.openFile(file.path);
      */
      // Load PDF from assets for now
      final bytes = await rootBundle.load('assets/data/Document(100).pdf');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/Document(100).pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List());

      final document = PdfDocument.openFile(file.path);

      setState(() {
        _downloadedFile = file;
        _pdfController = PdfControllerPinch(document: document);
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading PDF: $e';
        _isloading = false;
      });
    }
  }

  void _toggleOrientation() async {
    if (_isPortrait) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    setState(() {
      _isPortrait = !_isPortrait;
    });
  }

  Future<void> _shareFile() async {
    if (_downloadedFile != null) {
      await Share.shareXFiles([
        XFile(_downloadedFile!.path),
      ], text: 'Sharing PDF file');
    } else {
      _showSnack('Please wait for the PDF to load');
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _downloadFile() async {
    if (_downloadedFile != null) {
      _showSnack('File Downloaded to : ${_downloadedFile!.path}');
    } else {
      _showSnack('File not downloaded yet');
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
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
            _isloading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text(_error!))
                : PdfViewPinch(controller: _pdfController!),
        bottomNavigationBar: Container(
          color: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Home',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _shareFile,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.share, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Share',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _downloadFile,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.download, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Download',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _toggleOrientation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.screen_rotation, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Rotate',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubSubDepartments(),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back_outlined, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Back',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
