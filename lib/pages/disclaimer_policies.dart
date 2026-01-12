import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class DisclaimerPolicies extends StatelessWidget {
  const DisclaimerPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 24.sp),
          title: Text(
            'Disclaimer',
            style: AppTextStyles.bold(
              18.sp,
            ).copyWith(color: AppColors.textOnDark),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _boldLine('Service Provider'),
                _paragraph(
                  'Alpha Developer Team is the service provider of the महाGR Alert mobile application ("App"), which operates as a paid subscription-based service. The App collects minimal personal information such as name, email, phone number, payment details through secure third-party gateways, device information, and notification preferences to manage subscriptions and provide personalized features.',
                ),

                _spacer(),
                _boldLine('Public Domain Information'),
                _paragraph(
                  'The App aggregates information from public domain sources and reproduces it accurately in accordance with applicable copyright policies. Proper acknowledgment of sources is provided wherever applicable. The App excludes third-party copyrighted material unless authorized, and users are advised to independently verify critical information.',
                ),

                _spacer(),
                _boldLine('External Links'),
                _paragraph(
                  'The App may contain links to external websites or portals maintained by government, non-government, or private organizations. Once redirected, users are subject to the privacy and security policies of those websites. महाGR Alert does not endorse or take responsibility for external content.',
                ),

                _spacer(),
                _boldLine('Data Protection & User Rights'),
                _paragraph(
                  'Personal data is protected using industry-standard security measures and is stored in India in compliance with the Digital Personal Data Protection Act, 2023. Users have the right to access, correct, delete, or withdraw consent for their personal data. Grievances may be raised with the Grievance Officer at mahaGRalert@gmail.com and will be addressed within 15 days as per applicable law.',
                ),

                _spacer(),
                _boldLine('Legal Jurisdiction'),
                _paragraph(
                  'This policy is governed by Indian law. Any disputes shall be subject to the jurisdiction of courts located at Chhatrapati Sambhajinagar, Maharashtra. Continued use of the App implies acceptance of this policy. For queries, users may contact mahaGRalert@gmail.com.',
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _boldLine(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(text, style: AppTextStyles.bold(14.sp)),
    );
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: AppTextStyles.regular(
        13.sp,
      ).copyWith(height: 1.7, color: Colors.black87),
    );
  }

  Widget _spacer() => SizedBox(height: 18.h);
}
