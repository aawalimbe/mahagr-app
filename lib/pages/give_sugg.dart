import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class GiveSuggestions extends StatefulWidget {
  const GiveSuggestions({super.key});

  @override
  State<GiveSuggestions> createState() => _GiveSuggestionsState();
}

class _GiveSuggestionsState extends State<GiveSuggestions> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _suggestionController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _suggestionController.dispose();
    super.dispose();
  }

  Future<void> _submitSuggestion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final response = await ApiService.submitSuggestion(
        message: _suggestionController.text.trim(),
        contact: null,
      );

      if (response['status'] == 'true') {
        setState(() {
          _successMessage =
              response['message'] ?? 'Suggestion submitted successfully!';
        });

        _suggestionController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Suggestion submitted successfully!'),
              backgroundColor: AppColors.vibrantgreen,
            ),
          );
        }

        if (mounted) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          });
        }
      } else {
        setState(() {
          _errorMessage =
              response['message'] ??
              'Failed to submit suggestion. Please try again.';
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response['message'] ?? 'Failed to submit suggestion.',
              ),
              backgroundColor: AppColors.compulsory,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error submitting suggestion: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting suggestion: $e'),
            backgroundColor: AppColors.compulsory,
          ),
        );
      }
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 430.h,
              width: 300.w,
              constraints: BoxConstraints(
                minHeight: 200.h,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.dprimaryColor,
                  width: 10.sp,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 10.r),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.feedback_rounded, size: 35.sp),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            child: Icon(Icons.close, size: 35.sp),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),
                      Text('Suggestions', style: AppTextStyles.bold(27.sp)),
                      SizedBox(height: 7.h),
                      Text(
                        "Your Suggestions help us to improve our app",
                        style: AppTextStyles.regular(14.sp),
                      ),
                      SizedBox(height: 20.h),

                      // FIXED SUGGESTION BOX
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.dprimaryColor),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: AppColors.dprimaryColor,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextFormField(
                                controller: _suggestionController,
                                maxLines: 5,
                                style: AppTextStyles.regular(12.sp),
                                decoration: InputDecoration(
                                  hintText: 'Write your suggestion here...',
                                  hintStyle: AppTextStyles.regular(12.sp),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please leave a suggestions';
                                  }
                                  if (value.trim().length < 10) {
                                    return 'Suggestion must be at least 10 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Error Message Box
                      if (_errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(8.w),
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
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: AppTextStyles.regular(
                                    12.sp,
                                  ).copyWith(color: AppColors.errorDark),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (_errorMessage != null) SizedBox(height: 16.h),

                      // Success Message Box
                      if (_successMessage != null)
                        Container(
                          padding: EdgeInsets.all(8.w),
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
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _successMessage!,
                                  style: AppTextStyles.regular(
                                    12.sp,
                                  ).copyWith(color: AppColors.successDark),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (_successMessage != null) SizedBox(height: 16.h),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitSuggestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dprimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
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
                                    style: AppTextStyles.regular(
                                      18.sp,
                                    ).copyWith(
                                      color: AppColors.textOnDark,
                                      fontWeight: FontWeight.bold,
                                    ),
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
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
// import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

// class GiveSuggestions extends StatefulWidget {
//   const GiveSuggestions({super.key});

//   @override
//   State<GiveSuggestions> createState() => _GiveSuggestionsState();
// }

// class _GiveSuggestionsState extends State<GiveSuggestions> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _suggestionController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//   bool _isSubmitting = false;
//   String? _errorMessage;
//   String? _successMessage;

//   @override
//   void dispose() {
//     _suggestionController.dispose();
//     _contactController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitSuggestion() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isSubmitting = true;
//       _errorMessage = null;
//       _successMessage = null;
//     });

//     try {
//       final response = await ApiService.submitSuggestion(
//         message: _suggestionController.text.trim(),
//         contact: _contactController.text.trim().isNotEmpty ? _contactController.text.trim() : null,
//         // TODO: Add user_id when user authentication is implemented
//         // userId: currentUserId,
//       );

//       if (response['status'] == 'true') {
//         setState(() {
//           _successMessage = response['message'] ?? 'Suggestion submitted successfully!';
//         });

//         // Clear the form
//         _suggestionController.clear();
//         _contactController.clear();

//         // Show success message
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Suggestion submitted successfully!'),
//               backgroundColor: AppColors.vibrantgreen,
//             ),
//           );
//         }

//         // Navigate back to home page after successful submission
//         if (mounted) {
//           Future.delayed(const Duration(seconds: 2), () {
//             if (mounted) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HomePage()),
//               );
//             }
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = response['message'] ?? 'Failed to submit suggestion. Please try again.';
//         });
        
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(response['message'] ?? 'Failed to submit suggestion. Please try again.'),
//               backgroundColor: AppColors.compulsory,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error submitting suggestion: $e';
//       });
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error submitting suggestion: $e'),
//             backgroundColor: AppColors.compulsory,
//           ),
//         );
//       }
//     } finally {
//       setState(() {
//         _isSubmitting = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomScaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               height: 500.h,
//               width: 300.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: AppColors.dprimaryColor,
//                   width: 10.sp,
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: 12.r,
//                   bottom: 8.r,
//                   left: 10.r,
//                   right: 10.r,
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.feedback_rounded, size: 35.sp),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const HomePage(),
//                                 ),
//                               );
//                             },
//                             child: Icon(Icons.close, size: 35.sp),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10.h),
//                       Text(
//                         'Suggestions',
//                         style: AppTextStyles.bold(27.sp).copyWith(),
//                       ),
//                       SizedBox(height: 7.h),
//                       Text(
//                         "Your Suggestions helps us to improve our app",
//                         style: AppTextStyles.regular(16.sp),
//                       ),
//                       SizedBox(height: 20.h),
                      
//                       // Contact Information (Optional)
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.primaryColor),
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: TextFormField(
//                           controller: _contactController,
//                           style: AppTextStyles.regular(16.sp),
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Contact Information (Optional)',
//                             prefixIcon: Icon(Icons.contact_mail),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.h),

//                       // Suggestion Text
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.dprimaryColor),
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: TextFormField(
//                           controller: _suggestionController,
//                           maxLines: 3,
//                           style: AppTextStyles.regular(16.sp),
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Write your suggestion here...',
//                             prefixIcon: Icon(Icons.lightbulb_outline),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please leave a suggestion';
//                             }
//                             if (value.trim().length < 10) {
//                               return 'Suggestion must be at least 10 characters long';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 20.h),

//                       // Error Message
//                       if (_errorMessage != null) ...[
//                         Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.all(8.w),
//                           decoration: BoxDecoration(
//                             color: AppColors.errorLight,
//                                                           border: Border.all(color: AppColors.errorMedium),
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.error_outline, color: AppColors.compulsory, size: 16.sp),
//                               SizedBox(width: 8.w),
//                               Expanded(
//                                 child: Text(
//                                   _errorMessage!,
//                                   style: AppTextStyles.regular(12.sp).copyWith(
//                                     color: AppColors.errorDark,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 16.h),
//                       ],

//                       // Success Message
//                       if (_successMessage != null) ...[
//                         Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.all(8.w),
//                           decoration: BoxDecoration(
//                             color: AppColors.successLight,
//                                                           border: Border.all(color: AppColors.successMedium),
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.check_circle_outline, color: AppColors.vibrantgreen, size: 16.sp),
//                               SizedBox(width: 8.w),
//                               Expanded(
//                                 child: Text(
//                                   _successMessage!,
//                                   style: AppTextStyles.regular(12.sp).copyWith(
//                                     color: AppColors.successDark,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 16.h),
//                       ],

//                       SizedBox(
//                         width: double.infinity,
//                         height: 45.h,
//                         child: ElevatedButton(
//                           onPressed: _isSubmitting ? null : _submitSuggestion,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.dprimaryColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                           ),
//                           child:
//                               _isSubmitting
//                                   ? SizedBox(
//                                     width: 20.w,
//                                     height: 20.w,
//                                                                           child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         AppColors.textOnDark,
//                                       ),
//                                     ),
//                                   )
//                                   : Text(
//                                     'Submit Suggestion',
//                                     style: AppTextStyles.regular(18.sp).copyWith(
//                                       color: AppColors.textOnDark,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
