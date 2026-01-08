import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/viewer_bottomNevigator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageViewer extends StatefulWidget {
  final String imageUrl;
  final String documentTitle;

  const ImageViewer({
    super.key,
    required this.imageUrl,
    required this.documentTitle,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  File? _imageFile;
  bool _isLoading = true;
  String? _error;
  bool _isPortrait = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fname =
          "${widget.documentTitle.replaceAll(RegExp(r'[^\w\s-]'), '')}.jpg";

      final file = File("${dir.path}/$fname");

      final bytes = await ApiService.downloadFilefromUrl(widget.imageUrl);
      await file.writeAsBytes(bytes);

      setState(() {
        _imageFile = file;
        _isLoading = false;
      });
    } catch (e) {
      _error = "Error loading image: $e";
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text(_error!))
                : InteractiveViewer(
                  child: Center(child: Image.file(_imageFile!)),
                ),

        bottomNavigationBar: ViewerBottomNavigator(
          onShare: _share,
          onDownload: () {},
          onRotate: _rotate,
          onSave: () {},
        ),
      ),
    );
  }

  Future<void> _share() async {
    if (_imageFile != null) {
      Share.shareXFiles([XFile(_imageFile!.path)]);
    }
  }

  void _rotate() async {
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
    _isPortrait = !_isPortrait;
    setState(() {});
  }
}
