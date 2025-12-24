import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/registration.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_config.dart';

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
  bool _isOtpSend = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (!_isOtpSend) {
      setState(() {
        _isOtpSend = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent to your mobile number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
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
                      'assets/images/original/logo.png',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
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

                          // Must be exactly 10 digits
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                            return "Enter valid 10-digit mobile number";
                          }

                          return null;
                        },
                      ),
                    ),

                    // OTP FIELD
                    if (_isOtpSend) ...[
                      SizedBox(height: 20.h),

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
                            if (!_isOtpSend) return null;
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
                    ],

                    SizedBox(height: 40.h),

                    // LOGIN BUTTON
                    SizedBox(
                      width: 250.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _onButtonPressed,
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
                                  _isOtpSend ? 'Login' : 'Generate OTP',
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
