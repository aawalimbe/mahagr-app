import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/deptselection_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class NewRegistration extends StatefulWidget {
  const NewRegistration({super.key});

  @override
  State<NewRegistration> createState() => _NewRegistrationState();
}

class _NewRegistrationState extends State<NewRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();

  String? _selectedUserType;
  String? _selectedDistrict;
  String? _selectedDepartment;

  List<String> _districts = [];
  List<String> _departments = [];

  bool _isLoading = false;

  final List<String> _userTypes = [
    'Govt Officer/Employee',
    'Semi-Govt Officer/Employee',
    'Legal Field',
    'Social Field/NGO',
    "People's Representatives",
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
    List<TextInputFormatter>? inputFormatters,
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
            inputFormatters: inputFormatters,
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
            'Registration',
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

                _buildRequiredField(
                  'Full Name',
                  _nameCtrl,
                  subtitle: "Surname - First Name - Father's/Husband's Name",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
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
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child:
                      _isLoading
                          ? CircularProgressIndicator(
                            color: AppColors.textOnDark,
                          )
                          : Text(
                            'Register',
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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:forrest_department_gr_and_updatees_app/pages/deptselection_page.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_list.dart';

// class NewRegistration extends StatefulWidget {
//   const NewRegistration({super.key});

//   @override
//   State<NewRegistration> createState() => _NewRegistrationState();
// }

// class _NewRegistrationState extends State<NewRegistration> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _mobileCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _confirmPasswordCtrl = TextEditingController();

//   String? _selectedUserType;
//   String? _selectedDepartment;
//   String? _selectedDistrict;

//   List<String> _departments = [];
//   List<String> _districts = [];

//   bool _isLoadingDept = false;
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   final List<String> _userTypes = [
//     'Govt Officer/Employee',
//     'Semi-Govt Officer/Employee',
//     'Legal Field',
//     "People's Representatives",

//     'Social Field/NGO',
//     'Citizen',
//   ];

//   // Reusable border style
//   OutlineInputBorder get _outlineBorder => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8.r),
//     borderSide: BorderSide(color: AppColors.primaryColor),
//   );

//   OutlineInputBorder get _focusedBorder => _outlineBorder.copyWith(
//     borderRadius: BorderRadius.circular(8.r),
//     borderSide: BorderSide(color: AppColors.dprimaryColor, width: 2.5),
//   );

//   void _showError(String msg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
//   }

//   void _onUserTypeChanged(String? value) async {
//     setState(() {
//       _selectedUserType = value;
//       _selectedDepartment = null;
//       _departments = [];
//     });

//     if (value == 'Govt Officer/Employee') {
//       setState(() {
//         _isLoadingDept = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadDistricts();
//   }

//   Future<void> _loadDistricts() async {
//     try {
//       final result = await ApiService.getDistricts();
//       setState(() {
//         _districts = result.map((d) => d['name'] as String).toList();
//       });
//     } catch (_) {
//       _showError("Failed to load Districts from server");
//     }
//   }

//   Future<void> _registerUser() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     try {
//       final isConnected = await ApiService.testConnection();
//       if (!isConnected && !await ApiService.testNetworkConnectivity()) {
//         throw Exception("Cannot connect to server. Check your network.");
//       }

//       final response = await ApiService.registerUser(
//         name: _nameCtrl.text.trim(),
//         email: _emailCtrl.text.trim(),
//         password: _passwordCtrl.text,
//         mobile: _mobileCtrl.text.trim(),
//         userType: _selectedUserType!,
//         district: _selectedDistrict!,
//         department: _selectedDepartment,
//       );

//       if (response['status'] == 'true') {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Registration successful!'),
//               backgroundColor: AppColors.vibrantgreen,
//             ),
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const DepartmentSelectionPage()),
//           );
//         }
//       } else {
//         _showError(response['message'] ?? 'Registration failed');
//       }
//     } catch (e) {
//       _showError('Error: $e');
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   // COMMON FIELD BUILDER
//   Widget _buildRequiredField(
//     String label,
//     TextEditingController controller, {
//     TextInputType? keyboardType,
//     int? maxLines = 1,
//     String? Function(String?)? validator,
//     String? subtitle,
//     int? maxLength,
//     double bottomSpacing = 16,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel(label),
//         if (subtitle != null)
//           Padding(
//             padding: EdgeInsets.only(top: 2, bottom: 4),
//             child: Text(
//               subtitle,
//               style: AppTextStyles.regular(
//                 11.sp,
//               ).copyWith(color: AppColors.secondaryText),
//             ),
//           ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           maxLength: maxLength,
//           validator:
//               validator ??
//               (v) =>
//                   (v == null || v.trim().isEmpty) ? "$label is required" : null,
//           decoration: InputDecoration(
//             border: _outlineBorder,
//             enabledBorder: _outlineBorder,
//             focusedBorder: _focusedBorder,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 12.w,
//               vertical: 12.h,
//             ),
//           ),
//         ),
//         SizedBox(height: bottomSpacing.h),
//       ],
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Row(
//       children: [
//         Text(text, style: AppTextStyles.medium(14.sp)),
//         SizedBox(width: 4.w),
//         Container(
//           width: 6.w,
//           height: 6.h,
//           decoration: BoxDecoration(
//             color: AppColors.compulsory,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField(
//     String label,
//     TextEditingController controller,
//     bool obscureText,
//     String? Function(String?)? validator,
//     VoidCallback onToggleVisibility,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel(label),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           obscureText: obscureText,
//           validator: validator,
//           decoration: InputDecoration(
//             border: _outlineBorder,
//             enabledBorder: _outlineBorder,
//             focusedBorder: _focusedBorder,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 12.w,
//               vertical: 12.h,
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 obscureText ? Icons.visibility : Icons.visibility_off,
//                 color: AppColors.primaryColor,
//               ),
//               onPressed: onToggleVisibility,
//             ),
//           ),
//         ),
//         SizedBox(height: 16.h),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           toolbarHeight: 60.h,
//           backgroundColor: AppColors.primaryColor,
//           centerTitle: true,
//           iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.sp),
//           title: Text(
//             'Registration',
//             style: AppTextStyles.bold(20.sp).copyWith(
//               color: AppColors.textOnDark,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(15.w),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _buildRequiredField(
//                   'Full Name',
//                   _nameCtrl,
//                   subtitle: "Surname - First Name - Father's/Husband's Name",
//                 ),
//                 _buildRequiredField(
//                   'Email Id',
//                   _emailCtrl,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter valid email id';
//                     }
//                     final emailRegex = RegExp(
//                       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                     );
//                     if (!emailRegex.hasMatch(value)) {
//                       return 'Enter valid email id';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildRequiredField(
//                   'Mobile No.',
//                   _mobileCtrl,
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   bottomSpacing: 6,
//                   validator:
//                       (value) =>
//                           value != null && value.length == 10
//                               ? null
//                               : 'Enter 10-digit mobile no.',
//                 ),
//                 _buildPasswordField(
//                   'Password',
//                   _passwordCtrl,
//                   _obscurePassword,
//                   (v) {
//                     if (v == null || v.isEmpty) return 'Password is required';
//                     if (v.length < 6)
//                       return 'Password must be at least 6 chars';
//                     return null;
//                   },
//                   () => setState(() => _obscurePassword = !_obscurePassword),
//                 ),
//                 _buildPasswordField(
//                   'Confirm Password',
//                   _confirmPasswordCtrl,
//                   _obscureConfirmPassword,
//                   (v) {
//                     if (v == null || v.isEmpty) {
//                       return 'Confirm password is required';
//                     }
//                     if (v != _passwordCtrl.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                   () => setState(
//                     () => _obscureConfirmPassword = !_obscureConfirmPassword,
//                   ),
//                 ),

//                 // DISTRICT
//                 _buildLabel("District"),
//                 SizedBox(height: 8.h),
//                 DropdownButtonFormField<String>(
//                   value: _selectedDistrict,
//                   items:
//                       _districts
//                           .map(
//                             (d) => DropdownMenuItem(value: d, child: Text(d)),
//                           )
//                           .toList(),
//                   decoration: InputDecoration(
//                     border: _outlineBorder,
//                     enabledBorder: _outlineBorder,
//                     focusedBorder: _focusedBorder,
//                   ),
//                   validator: (v) => v == null ? 'Select district' : null,
//                   onChanged: (v) => setState(() => _selectedDistrict = v),
//                 ),

//                 SizedBox(height: 20.h),

//                 // USER TYPE
//                 _buildLabel("User Type"),
//                 SizedBox(height: 8.h),
//                 DropdownButtonFormField<String>(
//                   value: _selectedUserType,
//                   items:
//                       _userTypes
//                           .map(
//                             (type) => DropdownMenuItem(
//                               value: type,
//                               child: Text(type),
//                             ),
//                           )
//                           .toList(),
//                   decoration: InputDecoration(
//                     border: _outlineBorder,
//                     enabledBorder: _outlineBorder,
//                     focusedBorder: _focusedBorder,
//                   ),
//                   validator: (v) => v == null ? 'Select user type' : null,
//                   onChanged: _onUserTypeChanged,
//                 ),

//                 // if (_selectedUserType == 'Govt Officer/Employee') ...[
//                 //   SizedBox(height: 20.h),
//                 //   _buildLabel("Department"),
//                 //   SizedBox(height: 8.h),
//                 //   _isLoadingDept
//                 //       ? const CircularProgressIndicator()
//                 //       : DropdownButtonFormField<String>(
//                 //         value: _selectedDepartment,
//                 //         items:
//                 //             _departments
//                 //                 .map(
//                 //                   (d) => DropdownMenuItem(
//                 //                     value: d,
//                 //                     child: Text(d),
//                 //                   ),
//                 //                 )
//                 //                 .toList(),
//                 //         decoration: InputDecoration(
//                 //           border: _outlineBorder,
//                 //           enabledBorder: _outlineBorder,
//                 //           focusedBorder: _focusedBorder,
//                 //         ),
//                 //         validator:
//                 //             (v) => v == null ? 'Select department' : null,
//                 //         onChanged:
//                 //             (v) => setState(() => _selectedDepartment = v),
//                 //       ),
//                 // ],
//                 SizedBox(height: 30.h),

//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _registerUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     minimumSize: Size(double.infinity, 48.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                   ),
//                   child:
//                       _isLoading
//                           ? CircularProgressIndicator(
//                             color: AppColors.textOnDark,
//                           )
//                           : Text(
//                             'Register',
//                             style: AppTextStyles.bold(
//                               16.sp,
//                             ).copyWith(color: AppColors.textOnDark),
//                           ),
//                 ),

//                 SizedBox(height: 40.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
