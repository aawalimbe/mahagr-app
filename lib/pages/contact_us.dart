import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedFile;
  String? _selectedFileName;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      _showSnackBar('Error picking file: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _showSnackBar('Form submitted successfully!');

      // Clear all form fields
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _descriptionController.clear();

      // Clear file attachment
      setState(() {
        _selectedFile = null;
        _selectedFileName = null;
      });
    } catch (e) {
      _showSnackBar('Error submitting form: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Widget _buildRequiredField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int? maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: AppTextStyles.medium(14.sp)),
            SizedBox(width: 4.w),
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: AppColors.compulsory,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator:
              validator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              },
          decoration: InputDecoration(
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
        Text('Attachment', style: AppTextStyles.medium(16.sp)),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedFileName ?? 'No file selected',
                      style: AppTextStyles.regular(12.sp),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(
                      'Choose File',
                      style: AppTextStyles.regular(12.sp),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              if (_selectedFileName != null) ...[
                SizedBox(height: 8.h),
                Text(
                  'Supported formats: PDF, JPG, JPEG, PNG',
                  style: AppTextStyles.regular(
                    12.sp,
                  ).copyWith(color: AppColors.secondaryText),
                ),
              ],
            ],
          ),
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
          toolbarHeight: 60.h,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.w),

          title: Text(
            'Contact Us',
            style: AppTextStyles.bold(
              18.sp,
            ).copyWith(color: AppColors.textOnDark),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title in body
                Text(
                  'Please fill in all required fields marked with red dots',
                  style: AppTextStyles.regular(
                    12.sp,
                  ).copyWith(color: AppColors.secondaryText),
                ),
                SizedBox(height: 24.h),

                _buildRequiredField('Name', _nameController),

                _buildRequiredField(
                  'Email',
                  _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                _buildRequiredField('Subject', _subjectController),

                _buildRequiredField(
                  'Description',
                  _descriptionController,
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters long';
                    }
                    return null;
                  },
                ),

                _buildAttachmentField(),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
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
                                16.sp,
                              ).copyWith(color: AppColors.textOnDark),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
