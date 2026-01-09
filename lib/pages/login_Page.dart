import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/registration.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _generatedOtp = 0;

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  int _generateOtp() {
    return 100000 + DateTime.now().millisecondsSinceEpoch % 900000;
  }

  Future<void> _autoFillOtp(int otp) async {
    _otpController.clear();
    final otpStr = otp.toString();

    for (int i = 0; i < otpStr.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _otpController.text += otpStr[i];
    }

    await Future.delayed(const Duration(milliseconds: 300));
    _onButtonPressed();
  }

  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void _onButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (!_isOtpSend) {
      _generatedOtp = _generateOtp();
      setState(() => _isOtpSend = true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP $_generatedOtp auto detected')),
      );

      Future.delayed(const Duration(milliseconds: 600), () {
        _autoFillOtp(_generatedOtp);
      });
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () async {
      setState(() => _isLoading = false);
      await _saveLoginStatus();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWebOrTablet = width > 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// LOGO
                        Image.asset(
                          'assets/images/original/logo.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 24),

                        /// MOBILE NUMBER
                        TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: _decoration('Mobile Number'),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter mobile number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                              return 'Enter valid 10-digit number';
                            }
                            return null;
                          },
                        ),

                        if (_isOtpSend) ...[
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: _decoration(
                              'OTP',
                            ).copyWith(counterText: ''),
                            validator: (v) {
                              if (v == null || v.length != 6) {
                                return 'Enter valid OTP';
                              }
                              return null;
                            },
                          ),
                        ],

                        const SizedBox(height: 24),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _onButtonPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child:
                                _isLoading
                                    ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : Text(
                                      _isOtpSend ? 'Login' : 'Generate OTP',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// REGISTRATION
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewRegistration(),
                              ),
                            );
                          },
                          child: const Text(
                            'New Registration',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
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
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );
  }
}
