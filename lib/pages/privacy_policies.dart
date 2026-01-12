import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class PrivacyPolicies extends StatelessWidget {
  const PrivacyPolicies({super.key});

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
            'Privacy Policy',
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
                _heading('Service Provider & Information Collection'),
                _paragraph(
                  'Alpha Developer Team is the service provider of the महाGR Alert mobile application ("App"), which operates as a paid subscription-based service. The App collects minimal personal information such as name, email address, phone number, payment details through secure third-party gateways, device information, and notification preferences to manage subscriptions and provide personalized features including search, filters, categorization, and notifications.',
                ),

                _spacer(),
                _heading('Use of Public Domain Information'),
                _paragraph(
                  'The App aggregates material available from public domain sources and reproduces it accurately in accordance with applicable copyright policies. Proper acknowledgment of sources is provided wherever applicable. The App excludes third-party copyrighted material unless authorized, and users are advised to independently verify critical information.',
                ),

                _spacer(),
                _heading('External Website Links'),
                _paragraph(
                  'The App may include links to external websites or portals maintained by government, non-government, or private organizations for user convenience. Once redirected, users are subject to the privacy and security policies of those websites. महाGR Alert does not endorse or assume responsibility for the content, reliability, or views expressed on external platforms.',
                ),

                _spacer(),
                _heading('Data Protection & User Rights'),
                _paragraph(
                  'Personal data is protected using industry-standard security measures, including encryption, and is stored in India in compliance with the Digital Personal Data Protection (DPDP) Act, 2023. Personal information is retained only for as long as necessary or as required by law. The App does not sell user data but may share it with trusted service providers under due process.',
                ),

                _spacer(),
                _paragraph(
                  'Under the DPDP Act, users have the right to access, correct, delete, or port their personal data and withdraw consent at any time. Users may contact the Grievance Officer at mahaGRalert@gmail.com for any privacy-related concerns, which will be addressed within 15 days as per applicable Indian regulations.',
                ),

                _spacer(),
                _heading('Policy Updates & Jurisdiction'),
                _paragraph(
                  'This Privacy Policy is governed by Indian law. Any disputes shall be subject to the jurisdiction of courts located at Chhatrapati Sambhajinagar, Maharashtra. The policy may be updated from time to time, with changes reflected within the App. Continued use of the App implies acceptance of the updated policy.',
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading(String text) {
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
