import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';

import '../reusable_or_snipit_widgets/colors.dart';

class ShareDocs extends StatefulWidget {
  const ShareDocs({super.key});

  @override
  State<ShareDocs> createState() => _ShareDocsState();
}

class _ShareDocsState extends State<ShareDocs> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  PlatformFile? _selectedFile;
  String? _selectedFileName;

  bool _isSubmitting = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _selectedFile = result.files.single;
          _selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      _showSnackBar('Error picking file: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            message.contains('success')
                ? AppColors.vibrantgreen
                : AppColors.compulsory,
      ),
    );
  }

  Future<void> _submitForm() async {
    debugPrint('SUBMIT_FORM: triggered');

    if (!_formKey.currentState!.validate()) {
      debugPrint('SUBMIT_FORM: form validation failed');

      return;
    }

    debugPrint('SUBMIT_FORM: form validation passed');

    if (_selectedFile == null) {
      debugPrint('SUBMIT_FORM: no file selected');

      _showSnackBar('Please select an attachment');

      return;
    }

    debugPrint('SUBMIT_FORM: file selected -> ${_selectedFile!.name}');

    debugPrint(
      'SUBMIT_FORM: description -> ${_descriptionController.text.trim()}',
    );

    setState(() {
      _isSubmitting = true;

      _errorMessage = null;

      _successMessage = null;
    });

    debugPrint('SUBMIT_FORM: uploading started');

    try {
      final response = await ApiService.uploadDocument(
        title: _descriptionController.text.trim(),

        description: _descriptionController.text.trim(),

        fileBytes: _selectedFile!.bytes!,

        fileName: _selectedFile!.name,

        uploadedBy: "User",
      );

      debugPrint('SUBMIT_FORM: API response -> $response');

      final status = response['status'];
      final isSuccess =
          status == true || status?.toString().toLowerCase() == "true";

      if (isSuccess) {
        debugPrint('SUBMIT_FORM: upload success');

        setState(() {
          _successMessage =
              response['message'] ?? 'Document uploaded successfully!';
        });

        _showSnackBar('Document uploaded successfully!');

        _descriptionController.clear();

        _selectedFile = null;

        _selectedFileName = null;

        debugPrint('SUBMIT_FORM: form cleared, navigating to HomePage');

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            debugPrint('SUBMIT_FORM: navigation executed');

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            debugPrint('SUBMIT_FORM: widget not mounted, navigation skipped');
          }
        });
      } else {
        debugPrint('SUBMIT_FORM: upload failed -> ${response['message']}');

        setState(() => _errorMessage = response['message'] ?? 'Upload failed.');

        _showSnackBar(
          response['message'] ?? 'Upload failed. Please try again.',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('SUBMIT_FORM: exception occurred');

      debugPrint('ERROR: $e');

      debugPrint('STACKTRACE: $stackTrace');

      setState(() => _errorMessage = 'Error uploading document: $e');

      _showSnackBar('Error uploading document: $e');
    } finally {
      debugPrint('SUBMIT_FORM: upload process finished');

      setState(() => _isSubmitting = false);
    }
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Subject', style: AppTextStyles.medium(12.sp)),
            SizedBox(width: 4.w),
            Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Subject is required';
            }
            if (value.trim().length < 10) {
              return 'Subject must be at least 10 characters long';
            }
            return null;
          },
          decoration: InputDecoration(
            // hintText:
            //     'You can help us Update the app by sending the important Documents through this option.',
            // hintStyle: AppTextStyles.regular(
            //   12.sp,
            // ).copyWith(color: AppColors.secondaryText),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildAttachmentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Document File', style: AppTextStyles.medium(12.sp)),
            SizedBox(width: 4.w),
            Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedFileName ?? 'No file selected',
                  style: AppTextStyles.regular(12.sp),
                ),
              ),
              if (_selectedFileName != null)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedFile = null;
                      _selectedFileName = null;
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.compulsory,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                ),
              TextButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: Text('Choose File', style: TextStyle(fontSize: 12.sp)),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          'Supported format: PDF',
          style: AppTextStyles.regular(
            11.sp,
          ).copyWith(color: AppColors.secondaryText),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65.h,
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.sp),
          title: Text(
            'Upload Documents',
            style: AppTextStyles.bold(
              20.sp,
            ).copyWith(color: AppColors.textOnDark),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You can help us Update the app by sending the important Documents through this option.',
                    style: AppTextStyles.regular(
                      11.sp,
                    ).copyWith(color: AppColors.secondaryText),
                  ),
                  SizedBox(height: 8.h),

                  _buildDescription(),
                  _buildAttachmentField(),

                  if (_errorMessage != null)
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.errorLight,
                        border: Border.all(color: AppColors.errorMedium),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.compulsory,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: AppTextStyles.regular(
                                14.sp,
                              ).copyWith(color: AppColors.errorDark),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (_successMessage != null)
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        border: Border.all(color: AppColors.successMedium),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: AppColors.vibrantgreen,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              _successMessage!,
                              style: AppTextStyles.regular(
                                14.sp,
                              ).copyWith(color: AppColors.successDark),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 16.h),

                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.textOnDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child:
                          _isSubmitting
                              ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.textOnDark,
                                  ),
                                ),
                              )
                              : Text(
                                'Submit',
                                style: AppTextStyles.bold(
                                  17.sp,
                                ).copyWith(color: AppColors.textOnDark),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
