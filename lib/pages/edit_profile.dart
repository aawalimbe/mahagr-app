import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/deptselection_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();

  String? _selectedUserType;
  String? _selectedDistrict;
  String? _selectedDepartment;

  List<String> _districts = [];
  final List<String> _departments = [];

  bool _isLoading = false;

  final List<String> _userTypes = [
    'Govt Officer/Employee',
    'Semi-Govt Officer/Employee',
    'Legal Field',
    "People's Representatives",
    'Social Field/NGO',
    'Citizen',
  ];

  OutlineInputBorder get _outlineBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  OutlineInputBorder get _focusedBorder => _outlineBorder.copyWith(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: AppColors.dprimaryColor, width: 2.5),
  );

  void _showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  @override
  void initState() {
    super.initState();
    _loadDistricts();
  }

  Future<void> _loadDistricts() async {
    try {
      final result = await ApiService.getDistricts();
      setState(() {
        _districts = result.map((d) => d['name'] as String).toList();
      });
    } catch (_) {
      _showError("Failed to load Districts");
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final response = await ApiService.registerUser(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: "", // Password removed from UI
        mobile: _mobileCtrl.text.trim(),
        userType: _selectedUserType!,
        district: _selectedDistrict!,
        department: _selectedDepartment,
      );

      if (response['status'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: AppColors.vibrantgreen,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DepartmentSelectionPage()),
        );
      } else {
        _showError(response['message'] ?? 'Registration failed');
      }
    } catch (e) {
      _showError('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildRequiredField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int? maxLength,
    String? subtitle,
    String? Function(String?)? validator,
    double bottomSpacing = 16,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label),
          if (subtitle != null)
            Padding(
              padding: EdgeInsets.only(top: 2, bottom: 4),
              child: Text(
                subtitle,
                style: AppTextStyles.regular(
                  11.sp,
                ).copyWith(color: AppColors.secondaryText),
              ),
            ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            validator:
                validator ??
                (v) =>
                    (v == null || v.trim().isEmpty)
                        ? "$label is required"
                        : null,
            decoration: InputDecoration(
              border: _outlineBorder,
              enabledBorder: _outlineBorder,
              focusedBorder: _focusedBorder,
              counterText: "",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        Text(text, style: AppTextStyles.medium(14.sp)),
        SizedBox(width: 4.w),
        Container(
          width: 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColors.compulsory,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Department"),
        SizedBox(height: 8.h),
        TextFormField(
          controller: TextEditingController(text: _selectedDepartment),
          onChanged: (v) => _selectedDepartment = v,
          decoration: InputDecoration(
            border: _outlineBorder,
            enabledBorder: _outlineBorder,
            focusedBorder: _focusedBorder,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
          validator: (value) {
            if (_selectedUserType == 'Govt Officer/Employee' ||
                _selectedUserType == 'Semi-Govt Officer/Employee') {
              if (value == null || value.isEmpty) {
                return 'Department is required';
              }
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: AppTextStyles.bold(20.sp).copyWith(
              color: AppColors.textOnDark,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please fill the Information in English only',
                      style: AppTextStyles.bold(
                        12.sp,
                      ).copyWith(color: AppColors.compulsory),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                _buildRequiredField(
                  'Full Name',
                  _nameCtrl,
                  subtitle: "Surname - First Name - Father's/Husband's Name",
                ),

                _buildRequiredField(
                  'Email Id',
                  _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter valid email id';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter valid email id';
                    }
                    return null;
                  },
                ),

                _buildRequiredField(
                  'Mobile No.',
                  _mobileCtrl,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator:
                      (value) =>
                          value != null && value.length == 10
                              ? null
                              : 'Enter 10-digit mobile number',
                ),

                // DISTRICT
                _buildLabel("District"),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: _selectedDistrict,
                  items:
                      _districts
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                  decoration: InputDecoration(
                    border: _outlineBorder,
                    enabledBorder: _outlineBorder,
                    focusedBorder: _focusedBorder,
                  ),
                  validator: (v) => v == null ? 'Select district' : null,
                  onChanged: (v) {
                    setState(() {
                      _selectedUserType = v;
                      _selectedDepartment = null;
                    });
                  },
                ),

                SizedBox(height: 20.h),

                // USER TYPE
                _buildLabel("User Type"),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: _selectedUserType,
                  items:
                      _userTypes
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                  decoration: InputDecoration(
                    border: _outlineBorder,
                    enabledBorder: _outlineBorder,
                    focusedBorder: _focusedBorder,
                  ),
                  validator: (v) => v == null ? 'Select user type' : null,
                  onChanged: (v) {
                    setState(() {
                      _selectedUserType = v;
                      _selectedDepartment = null; // reset dept field
                    });
                  },
                ),

                // Conditional Display of DEPARTMENT FIELD
                if (_selectedUserType == 'Govt Officer/Employee' ||
                    _selectedUserType == 'Semi-Govt Officer/Employee') ...[
                  SizedBox(height: 20.h),
                  _buildDepartmentField(),
                ],
                SizedBox(height: 30.h),

                ElevatedButton(
                  onPressed: _isLoading ? null : _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  child:
                      _isLoading
                          ? CircularProgressIndicator(
                            color: AppColors.textOnDark,
                          )
                          : Text(
                            'Update',
                            style: AppTextStyles.bold(
                              18.sp,
                            ).copyWith(color: AppColors.textOnDark),
                          ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
