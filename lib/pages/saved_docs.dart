import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/pdf_viewer.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/saved_documents_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SavedDocuments extends StatefulWidget {
  const SavedDocuments({super.key});

  @override
  State<SavedDocuments> createState() => _SavedDocumentsState();
}

class _SavedDocumentsState extends State<SavedDocuments> {
  List<SavedDocument> _savedDocuments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedDocuments();
  }

  Future<void> _loadSavedDocuments() async {
    setState(() => _isLoading = true);
    final documents = await SavedDocumentsService.getSavedDocuments();
    if (mounted) {
      setState(() {
        _savedDocuments = documents;
        _isLoading = false;
      });
    }
  }

  Future<void> _viewDocument(SavedDocument document) async {
    final file = File(document.filePath);
    if (!await file.exists()) {
      _showErrorSnackBar('Document file not found');
      await _loadSavedDocuments(); // Refresh list
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewer(
          pdfUrl: document.originalUrl,
          documentTitle: document.title,
          localFilePath: document.filePath,
        ),
      ),
    );
  }

  Future<void> _downloadDocument(SavedDocument document) async {
    try {
      final file = File(document.filePath);
      if (!await file.exists()) {
        _showErrorSnackBar('Document file not found');
        return;
      }

      // Get Downloads directory or external storage directory
      Directory? downloadDir;
      try {
        if (Platform.isAndroid) {
          // For Android, try to get external storage downloads directory
          final externalDir = await getExternalStorageDirectory();
          if (externalDir != null) {
            // Navigate to Downloads folder if it exists
            downloadDir = Directory('${externalDir.path}/../Download');
            if (!await downloadDir.exists()) {
              downloadDir = Directory('${externalDir.path}/../Downloads');
            }
          }
        } else if (Platform.isIOS) {
          // For iOS, use app documents directory (files can be shared)
          downloadDir = await getApplicationDocumentsDirectory();
        } else {
          // For other platforms, use documents directory
          downloadDir = await getApplicationDocumentsDirectory();
        }

        if (downloadDir == null) {
          downloadDir = await getApplicationDocumentsDirectory();
        }

        // Ensure directory exists
        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        // Copy file to download directory
        final sanitizedName = document.title
            .replaceAll(RegExp(r"[^\w\s-]"), "")
            .replaceAll(RegExp(r"\s+"), "_");
        final downloadPath = '${downloadDir.path}/$sanitizedName.pdf';
        await file.copy(downloadPath);

        _showSuccessSnackBar(
          Platform.isAndroid
              ? 'File saved to Downloads: $sanitizedName.pdf'
              : 'File saved: $downloadPath',
        );
      } catch (e) {
        // Fallback: Use Share to let user save manually
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Download: ${document.title}',
        );
      }
    } catch (e) {
      _showErrorSnackBar('Error downloading document: $e');
    }
  }

  Future<void> _deleteDocument(SavedDocument document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: Text('Are you sure you want to delete "${document.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await SavedDocumentsService.deleteDocument(document.id);
      if (success) {
        _showSuccessSnackBar('Document deleted successfully');
        await _loadSavedDocuments();
      } else {
        _showErrorSnackBar('Error deleting document');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.compulsory,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.vibrantgreen,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.bold(12.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _dataCell(Widget child) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Center(child: child),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: Icon(icon, size: 20.sp, color: color ?? AppColors.primaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.sp),
          title: Text(
            'Saved Documents',
            style: AppTextStyles.bold(
              16.sp,
            ).copyWith(color: AppColors.textOnDark),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _savedDocuments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64.sp,
                          color: AppColors.secondaryText,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No saved documents',
                          style: AppTextStyles.medium(16.sp).copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Save documents from the PDF viewer',
                          style: AppTextStyles.regular(12.sp).copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: SingleChildScrollView(
                          child: Table(
                            border: TableBorder.all(
                              color: AppColors.border,
                              width: 1,
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(50), // Sr. No.
                              1: FlexColumnWidth(200), // Title
                              2: FlexColumnWidth(100), // Date
                              3: FlexColumnWidth(70), // View
                              4: FlexColumnWidth(95), // Download
                              5: FlexColumnWidth(70), // Delete
                            },
                            children: [
                              // Header row
                              TableRow(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFEFEF),
                                ),
                                children: [
                                  _headerCell('Sr.'),
                                  _headerCell('Title'),
                                  _headerCell('Date'),
                                  _headerCell('View'),
                                  _headerCell('Download'),
                                  _headerCell('Delete'),
                                ],
                              ),
                              // Data rows
                              ...List.generate(
                                _savedDocuments.length,
                                (index) {
                                  final document = _savedDocuments[index];
                                  return TableRow(
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Colors.white
                                          : AppColors.backgroundColor,
                                    ),
                                    children: [
                                      _dataCell(
                                        Text(
                                          '${index + 1}',
                                          style: AppTextStyles.regular(12.sp),
                                        ),
                                      ),
                                      _dataCell(
                                        Tooltip(
                                          message: document.title,
                                          child: Text(
                                            document.title,
                                            style: AppTextStyles.regular(12.sp),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      _dataCell(
                                        Text(
                                          _formatDate(document.savedDate),
                                          style: AppTextStyles.regular(11.sp),
                                        ),
                                      ),
                                      _dataCell(
                                        _actionButton(
                                          icon: Icons.visibility,
                                          onTap: () => _viewDocument(document),
                                        ),
                                      ),
                                      _dataCell(
                                        _actionButton(
                                          icon: Icons.download,
                                          onTap: () => _downloadDocument(document),
                                          color: AppColors.vibrantgreen,
                                        ),
                                      ),
                                      _dataCell(
                                        _actionButton(
                                          icon: Icons.delete,
                                          onTap: () => _deleteDocument(document),
                                          color: AppColors.compulsory,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
