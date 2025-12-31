import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'login_Page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned(
              child: Image.asset(
                "assets/images/original/grid1.jpeg",
                fit: BoxFit.contain,
              ),
            ),

            // Bottom container WITH logo inside it
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Bottom container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      20.w,
                      60.h, // space for logo overlap
                      20.w,
                      40.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.welcomecolor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.sp),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to महाGR Alert",
                          style: AppTextStyles.bold(
                            22.sp,
                          ).copyWith(color: AppColors.textOnDark),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 14.h),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            "Trial Plan",
                            style: AppTextStyles.bold(
                              16.sp,
                            ).copyWith(color: AppColors.textOnLight),
                          ),
                        ),

                        SizedBox(height: 14.h),

                        Text(
                          "Enjoy unlimited access\nwith trial plan",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regular(
                            16.sp,
                          ).copyWith(color: AppColors.textOnDark),
                        ),

                        SizedBox(height: 24.h),

                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2D6AFF), Color(0xFFED4E7E)],
                              ),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Get started",
                                style: AppTextStyles.bold(18.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Logo (STUCK to container)
                  Positioned(
                    top: -50.sp,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/original/logo.png',
                          width: 100.sp,
                          height: 100.sp,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

// import 'login_Page.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // Background image
//             Positioned(
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 500.h,
//                 child: Image.asset(
//                   "assets/images/original/grid1.jpeg",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),

//             // Bottom container
//             Positioned(
//               top: 500.h - 100.h,
//               left: 0,
//               right: 0,
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   left: 20.w,
//                   right: 20.w,
//                   top: 32.h,
//                   bottom: 130.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.welcomecolor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(28.sp),
//                     topRight: Radius.circular(28.sp),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 50),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Welcome to महाGR Alert",
//                         style: AppTextStyles.bold(
//                           22.sp,
//                         ).copyWith(color: AppColors.textOnDark),
//                       ),
//                       SizedBox(height: 14.h),

//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 18.w,
//                           vertical: 6.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.yellow,
//                           borderRadius: BorderRadius.circular(8.sp),
//                         ),
//                         child: Text(
//                           "Trial Plan",
//                           style: AppTextStyles.bold(
//                             16.sp,
//                           ).copyWith(color: AppColors.textOnLight),
//                         ),
//                       ),

//                       SizedBox(height: 14.h),

//                       Text(
//                         "Enjoy unlimited access\nwith trial plan",
//                         textAlign: TextAlign.center,
//                         style: AppTextStyles.regular(
//                           16.sp,
//                         ).copyWith(color: AppColors.textOnDark),
//                       ),

//                       SizedBox(height: 24.h),

//                       SizedBox(
//                         width: double.infinity,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Color(0xFF2D6AFF), Color(0xFFED4E7E)],
//                             ),
//                             borderRadius: BorderRadius.circular(8.sp),
//                           ),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(vertical: 14.h),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.sp),
//                               ),
//                               backgroundColor: AppColors.transparent,
//                               shadowColor: AppColors.transparent,
//                               elevation: 0,
//                               foregroundColor: AppColors.textOnDark,
//                             ),
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const LoginPage(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               "Get started",
//                               style: AppTextStyles.bold(18.sp),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Logo
//             Positioned(
//               left: 0,
//               right: 0,
//               top: 340.sp,
//               child: Center(
//                 child: Container(
//                   height: 100.sp,
//                   width: 100.sp,
//                   alignment: Alignment.center,
//                   child: ClipOval(
//                     child: Image.asset(
//                       'assets/images/original/logo.png',
//                       width: 100.sp,
//                       height: 100.sp,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
