import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/splash_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 500.h,
                child: Image.asset(
                  "assets/images/project_image/grid.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Bottom container
            Positioned(
              top: 500.h - 100.h,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 32.h,
                  bottom: 130.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.welcomecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.sp),
                    topRight: Radius.circular(28.sp),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to महाGR Alert",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Text(
                          "Trial Plan",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        "Enjoy unlimited access\nwith trial plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF2D6AFF), Color(0xFFED4E7E)],
                            ),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SplashScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Get started",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 340.sp,
              child: Center(
                child: Container(
                  height: 100.sp,
                  width: 100.sp,

                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/project_image/logo.png',
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.cover,
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
