import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/login_Page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_list.dart';
import 'dart:async';
import 'dart:math';

class ForgotPassword extends StatefulWidget {
  final String userEmail; // Email passed from previous screen

  const ForgotPassword({super.key, required this.userEmail});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isSendingOTP = false; // Separate state for Send OTP button
  bool _isSubmittingOTP = false; // Separate state for Submit button
  String? _maskedEmail;
  bool _canResendOTP = true;
  int _countdownSeconds = 0;
  Timer? _countdownTimer;
  bool _otpSent = false; // Track if OTP has been sent
  
  // Dummy OTP system
  String? _generatedOTP;
  DateTime? _otpExpiryTime;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.userEmail;
    _maskedEmail = _maskEmail(widget.userEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // Function to mask email address
  String _maskEmail(String email) {
    if (email.isEmpty) return '';

    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    // Mask username (keep first and last character)
    String maskedUsername = '';
    if (username.length <= 2) {
      maskedUsername = username;
    } else {
      maskedUsername =
          '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}';
    }

    // Mask domain (keep first and last character)
    String maskedDomain = '';
    if (domain.length <= 2) {
      maskedDomain = domain;
    } else {
      maskedDomain =
          '${domain[0]}${'*' * (domain.length - 2)}${domain[domain.length - 1]}';
    }

    return '$maskedUsername@$maskedDomain';
  }

  // Generate dummy OTP
  String _generateDummyOTP() {
    // Generate a 6-digit random number
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Validate dummy OTP
  bool _validateDummyOTP(String inputOTP) {
    if (_generatedOTP == null || _otpExpiryTime == null) {
      return false;
    }
    
    // Check if OTP is expired (10 minutes)
    if (DateTime.now().isAfter(_otpExpiryTime!)) {
      return false;
    }
    
    // Check if OTP matches
    return inputOTP == _generatedOTP;
  }

  void _startCountdown() {
    setState(() {
      _canResendOTP = false;  
      _countdownSeconds = 40;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _canResendOTP = true;
          timer.cancel();
        }
      });
    });
  }

  // Validate only email field for Send OTP
  bool _validateEmailOnly() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackBar('Mail Id is required', isError: true);
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackBar('Please enter a valid email address', isError: true);
      return false;
    }
    return true;
  }

  Future<void> _submitPasswordReset() async {
    if (!_validateEmailOnly()) {
      return;
    }

    setState(() {
      _isSendingOTP = true;
    });

    try {
      // Generate dummy OTP
      _generatedOTP = _generateDummyOTP();
      _otpExpiryTime = DateTime.now().add(const Duration(minutes: 10));
      
      print('Generated dummy OTP: $_generatedOTP');
      print('OTP expires at: $_otpExpiryTime');
      
      // Show success message with dummy OTP (for testing purposes)
      _showSnackBar('Password reset OTP sent to your email: $_generatedOTP', isError: false);
      setState(() {
        _otpSent = true; // Show OTP field after successful send
      });
      _startCountdown(); // Start countdown after successful OTP send
      
    } catch (e) {
      _showSnackBar('Network error: $e', isError: true);
    } finally {
      setState(() {
        _isSendingOTP = false;
      });
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.compulsory : AppColors.vibrantgreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _submitOTP() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      _showSnackBar('OTP is required', isError: true);
      return;
    }
    if (otp.length != 6) {
      _showSnackBar('OTP must be 6 digits', isError: true);
      return;
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(otp)) {
      _showSnackBar('OTP must contain only numbers', isError: true);
      return;
    }

    setState(() {
      _isSubmittingOTP = true;
    });

    try {
      // Validate dummy OTP
      if (_validateDummyOTP(otp)) {
        _showSnackBar('OTP verified successfully!', isError: false);
        
        // Clear the OTP field
        _otpController.clear();
        
        // Show password update dialog
        _showPasswordUpdateDialog(otp);
      } else {
        if (_generatedOTP == null || _otpExpiryTime == null) {
          _showSnackBar('Please request OTP first', isError: true);
        } else if (DateTime.now().isAfter(_otpExpiryTime!)) {
          _showSnackBar('OTP has expired. Please request a new OTP', isError: true);
        } else {
          _showSnackBar('Invalid OTP. Please check and try again', isError: true);
        }
      }
      
    } catch (e) {
      _showSnackBar('Error verifying OTP: $e', isError: true);
    } finally {
      setState(() {
        _isSubmittingOTP = false;
      });
    }
  }

  void _showPasswordUpdateDialog(String otp) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isUpdatingPassword = false;
    bool isNewPasswordVisible = false;
    bool isConfirmPasswordVisible = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
                side: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.w,
                ),
              ),
              title: Text(
                'Update Password',
                style: AppTextStyles.bold(18.sp),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 300.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // New Password Field
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: !isNewPasswordVisible,
                      keyboardType: TextInputType.text,
                      style: AppTextStyles.regular(16.sp),
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'Enter new password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.w,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setDialogState(() {
                              isNewPasswordVisible = !isNewPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isNewPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'New password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    
                    // Confirm Password Field
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: !isConfirmPasswordVisible,
                      keyboardType: TextInputType.text,
                      style: AppTextStyles.regular(16.sp),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm new password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.w,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setDialogState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                // Cancel Button
                TextButton(
                  onPressed: isUpdatingPassword ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.medium(16.sp).copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                
                // Update Button
                ElevatedButton(
                  onPressed: isUpdatingPassword ? null : () async {
                    // Validate form
                    if (newPasswordController.text.trim().isEmpty ||
                        confirmPasswordController.text.trim().isEmpty) {
                      _showSnackBar('Please fill all fields', isError: true);
                      return;
                    }
                    
                    if (newPasswordController.text != confirmPasswordController.text) {
                      _showSnackBar('Passwords do not match', isError: true);
                      return;
                    }
                    
                    if (newPasswordController.text.length < 6) {
                      _showSnackBar('Password must be at least 6 characters', isError: true);
                      return;
                    }

                    setDialogState(() {
                      isUpdatingPassword = true;
                    });

                    try {
                      // Call the password update API with dummy OTP
                      print('Calling updatePassword API with:');
                      print('Email: ${_emailController.text.trim()}');
                      print('OTP: $otp (dummy)');
                      print('New Password: ${newPasswordController.text.trim()}');
                      
                      Map<String, dynamic> response;
                      
                      // Use the post method directly with dummy OTP
                      response = await ApiService.post(ApiList.passwordUpdate, {
                        'email': _emailController.text.trim(),
                        'otp': otp, // This will be ignored by the API since we're using dummy OTP
                        'newPassword': newPasswordController.text.trim(),
                      });
                      
                      print('API Response: $response');
                      print('Response type: ${response.runtimeType}');
                      print('Response keys: ${response.keys.toList()}');
                      
                      final status = response["status"];
                      final message = (response["message"] ?? "").toString();
                      
                      print('Status: $status (type: ${status.runtimeType})');
                      print('Message: $message');

                      if (status == true || status?.toString().toLowerCase() == "true") {
                        _showSnackBar('Password updated successfully!', isError: false);
                        
                        // Close the dialog
                        Navigator.of(context).pop();
                        
                        // Navigate back to login page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      } else {
                        _showSnackBar(message, isError: true);
                      }
                    } catch (e) {
                      _showSnackBar('Error updating password: $e', isError: true);
                    } finally {
                      setDialogState(() {
                        isUpdatingPassword = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textOnDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: isUpdatingPassword
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
                          'Update Password',
                          style: AppTextStyles.bold(16.sp).copyWith(
                            color: AppColors.textOnDark,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/images/project_image/logo.png',
                        height: 150.h,
                        width: 150.h,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Confirmation Text with Email
                    Text(
                      'Confirm your mail Id ${_maskedEmail ?? ''}',
                      style: AppTextStyles.medium(
                        18.sp,
                      ).copyWith(color: AppColors.secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),

                                         // Mail ID Input Field and Send OTP Button
                     Row(
                       children: [
                         // Mail ID Text Field
                         Expanded(
                           flex: 2,
                           child: TextFormField(
                             controller: _emailController,
                             keyboardType: TextInputType.emailAddress,
                             style: AppTextStyles.regular(16.sp),
                             decoration: InputDecoration(
                               labelText: 'Mail Id',
                               hintText: 'Enter your email address',
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8.r),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8.r),
                                 borderSide: BorderSide(
                                   color: AppColors.primaryColor,
                                   width: 2.w,
                                 ),
                               ),
                               contentPadding: EdgeInsets.symmetric(
                                 horizontal: 12.w,
                                 vertical: 12.h,
                               ),
                             ),
                             validator: (value) {
                               if (value == null || value.trim().isEmpty) {
                                 return 'Mail Id is required';
                               }
                               if (!RegExp(
                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                               ).hasMatch(value)) {
                                 return 'Please enter a valid email address';
                               }
                               return null;
                             },
                           ),
                         ),
                         SizedBox(width: 12.w),
                         // Send OTP Button
                         Expanded(
                           flex: 1,
                           child: SizedBox(
                             height: 50.h,
                             child: ElevatedButton(
                               onPressed:
                                   (_isSendingOTP || !_canResendOTP)
                                       ? null
                                       : _submitPasswordReset,
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: AppColors.primaryColor,
                                 foregroundColor: AppColors.textOnDark,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8.r),
                                 ),
                                 elevation: 3,
                               ),
                               child:
                                   _isSendingOTP
                                       ? SizedBox(
                                           width: 20.w,
                                           height: 20.w,
                                           child: CircularProgressIndicator(
                                             strokeWidth: 2,
                                             valueColor:
                                                 AlwaysStoppedAnimation<Color>(
                                                   AppColors.textOnDark,
                                                 ),
                                           ),
                                         )
                                       : _canResendOTP
                                       ? Text(
                                           'Send OTP',
                                           textAlign: TextAlign.center,
                                           style: AppTextStyles.bold(
                                             14.sp,
                                           ).copyWith(color: AppColors.textOnDark),
                                         )
                                       : Text(
                                           '${_countdownSeconds}s',
                                           textAlign: TextAlign.center,
                                           style: AppTextStyles.bold(
                                             14.sp,
                                           ).copyWith(color: AppColors.textOnDark),
                                         ),
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 20.h),

                     // OTP Input Field
                     if (_otpSent) ...[
                       TextFormField(
                         controller: _otpController,
                         keyboardType: TextInputType.number,
                         maxLength: 6,
                         style: AppTextStyles.regular(16.sp),
                         decoration: InputDecoration(
                           labelText: 'OTP',
                           hintText: 'Enter 6-digit OTP',
                           counterText: '',
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8.r),
                             borderSide: BorderSide(
                               color: AppColors.primaryColor,
                               width: 2.w,
                             ),
                           ),
                           contentPadding: EdgeInsets.symmetric(
                             horizontal: 12.w,
                             vertical: 12.h,
                           ),
                         ),
                         
                       ),
                       SizedBox(height: 20.h),

                       // Submit Button
                       SizedBox(
                         width: double.infinity,
                         height: 50.h,
                         child: ElevatedButton(
                           onPressed: _isSubmittingOTP ? null : _submitOTP,
                           style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.primaryColor,
                             foregroundColor: AppColors.textOnDark,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8.r),
                             ),
                             elevation: 3,
                           ),
                           child: _isSubmittingOTP
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
                                   textAlign: TextAlign.center,
                                   style: AppTextStyles.bold(16.sp).copyWith(
                                     color: AppColors.textOnDark,
                                   ),
                                 ),
                         ),
                       ),
                    ] else ...[
                    ],
                    SizedBox(height: 20.h),

                                        // Information Text
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.vibrantgreen.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.vibrantgreen,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'A password reset OTP will be generated and displayed. This is a dummy system for testing. In production, OTP will be sent via email.',
                              style: AppTextStyles.regular(
                                14.sp,
                              ).copyWith(color: AppColors.secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                   ],
                 ),
               ),
             ),

             // Back Button - Top Left Corner (placed last to be on top)
             Positioned(
               top: 20.h,
               left: 20.w,
               child: Container(
                 width: 50.w,
                 height: 50.h,
                 decoration: BoxDecoration(
                                        color: AppColors.textOnDark,
                   borderRadius: BorderRadius.circular(12.r),
                   boxShadow: [
                     BoxShadow(
                       color: AppColors.border.withOpacity(0.3),
                       blurRadius: 8,
                       offset: const Offset(0, 2),
                     ),
                   ],
                 ),
                 child: Material(
                                        color: AppColors.transparent,
                   child: InkWell(
                     borderRadius: BorderRadius.circular(12.r),
                     onTap: () {
                       // Try to pop first, if no previous page exists, navigate to login
                       if (Navigator.canPop(context)) {
                         Navigator.pop(context);
                       } else {
                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const LoginPage(),
                           ),
                         );
                       }
                     },
                     child: Icon(
                       Icons.arrow_back,
                       color: AppColors.primaryColor,
                       size: 24.sp,
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
      ),
    );
  }
}
