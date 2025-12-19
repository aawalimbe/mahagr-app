import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/registration.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();

  bool _isLoading = false;
  final bool _obscureOTP = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      print("=== LOGIN ATTEMPT ===");
      print("Mobile: ${_mobileController.text.trim()}");
      print("OTP: ${_otpController.text.trim()}");
      print("API Base URL: ${AppConfig.baseUrl}");
      print("=====================");

      // Temporarily pass mobile as email and otp as password
      final response = await ApiService.loginUser(
        email: _mobileController.text.trim(),
        password: _otpController.text.trim(),
      );

      final status = response["status"];
      final message = (response["message"] ?? "").toString();

      final isSuccess =
          status == true || status?.toString().toLowerCase() == "true";

      if (isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        _showError(message.isNotEmpty ? message : "Login failed.");
      }
    } catch (e) {
      _showError("Network error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/project_image/logo.png',
                      height: 150.h,
                      width: 150.h,
                    ),
                    SizedBox(height: 20.h),

                    // MOBILE NUMBER FIELD
                    SizedBox(
                      height: 80.h,
                      child: TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.regular(16.sp),
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.dprimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter mobile number";
                          }

                          final v = value.trim();

                          // Must be exactly 10 digits
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                            return "Enter valid 10-digit mobile number";
                          }

                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // OTP FIELD
                    SizedBox(
                      height: 80.h,
                      child: TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        maxLength: 6,
                        style: AppTextStyles.regular(16.sp),
                        decoration: InputDecoration(
                          counterText: "",
                          labelText: 'OTP (6 digits)',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.dprimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter OTP";
                          }
                          if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                            return "Enter valid 6-digit OTP";
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // LOGIN BUTTON
                    SizedBox(
                      width: 250.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.textOnDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child:
                            _isLoading
                                ? CircularProgressIndicator(
                                  color: AppColors.textOnDark,
                                )
                                : Text(
                                  'Generate OTP',
                                  style: AppTextStyles.medium(16.sp),
                                ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // REGISTRATION
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NewRegistration()),
                        );
                      },
                      child: Text(
                        'New Registration',
                        style: AppTextStyles.medium(16.sp).copyWith(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:forrest_department_gr_and_updatees_app/pages/forgot_password.dart';
// import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
// import 'package:forrest_department_gr_and_updatees_app/pages/registration.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_config.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _passwordController = TextEditingController();
//   final _emailController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);

//     try {
//       print('=== LOGIN ATTEMPT ===');
//       print('Email: ${_emailController.text.trim()}');
//       print('Password: ${_passwordController.text.trim()}');
//       print('API Base URL: ${AppConfig.baseUrl}');
//       print('Is Development: ${AppConfig.isDevelopment}');
//       print('=====================');

//       final response = await ApiService.loginUser(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       // Debug print to see exactly what server sends
//       print("Login API Raw Response: $response");

//       final status = response["status"];
//       final message = (response["message"] ?? "").toString();

//       // Check both boolean and string 'true'
//       final isSuccess =
//           status == true || status?.toString().toLowerCase() == "true";

//       print("Status: $status, isSuccess: $isSuccess, Message: $message");

//       if (isSuccess) {
//         // Store user data if needed
//         print("Login successful, navigating to home page");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//       } else {
//         print("Login failed: $message");
//         if (message.toLowerCase().contains("email")) {
//           _showError("Email not matched");
//         } else if (message.toLowerCase().contains("password")) {
//           _showError("Password not matched");
//         } else if (message.toLowerCase().contains("inactive")) {
//           _showError("Account is inactive");
//         } else {
//           _showError(
//             message.isNotEmpty ? message : "Login failed. Please try again.",
//           );
//         }
//       }
//     } catch (e) {
//       print("Login error: $e");
//       _showError("Network error: $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
//           child: SingleChildScrollView(
//             child: Center(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       'assets/images/project_image/logo.png',
//                       height: 150.h,
//                       width: 150.h,
//                       //fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       height: 80.h,
//                       child: TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: AppTextStyles.regular(20.sp),
//                         decoration: InputDecoration(
//                           labelText: 'Email ID',
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                             borderSide: BorderSide(
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                             borderSide: BorderSide(
//                               color: AppColors.dprimaryColor,
//                               width: 2.5,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!value.contains('@')) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       height: 80.h,
//                       child: TextFormField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         keyboardType: TextInputType.text,
//                         style: AppTextStyles.regular(20.sp),
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                             borderSide: BorderSide(
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                             borderSide: BorderSide(
//                               color: AppColors.dprimaryColor,
//                               width: 2.5,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Please enter a valid Password. cannot be below 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 40.h),
//                     SizedBox(
//                       width: 250.w,
//                       height: 50.h,
//                       child: ElevatedButton(
//                         onPressed: _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           foregroundColor: AppColors.textOnDark,
//                           minimumSize: Size(double.infinity, 48.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                         ),
//                         child:
//                             _isLoading
//                                 ? CircularProgressIndicator(
//                                   color: AppColors.textOnDark,
//                                 )
//                                 : Text(
//                                   'Login',
//                                   style: AppTextStyles.medium(20.sp),
//                                 ),
//                       ),
//                     ),
//                     SizedBox(height: 40.h),
//                     InkWell(
//                       onTap: () {
//                         if (_emailController.text.trim().isEmpty) {
//                           _showError("Please enter your email first");
//                           return;
//                         }
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => ForgotPassword(
//                                   userEmail: _emailController.text.trim(),
//                                 ),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Forgot Password?',
//                         style: AppTextStyles.medium(16.sp).copyWith(
//                           color: AppColors.primaryColor,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 40.h),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NewRegistration(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'New Registration',
//                         style: AppTextStyles.medium(16.sp).copyWith(
//                           color: AppColors.primaryColor,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
