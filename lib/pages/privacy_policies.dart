import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class PrivacyPolicies extends StatefulWidget {
  const PrivacyPolicies({super.key});

  @override
  State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
}

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,

          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.sp),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Privacy Policy ',
                textAlign: TextAlign.start,
                style: AppTextStyles.bold(
                  16.sp,
                ).copyWith(color: AppColors.textOnDark),
                softWrap: true,
                maxLines: 2,
              ),
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Alpha Developer Team, as the service provider of the महाGR Alert mobile application ("App"), a paid subscription-based service, collects minimal personal information (e.g., name, email, phone number, payment details via secure third-party gateways, device data, and notification preferences) to manage subscriptions and deliver personalized features, including search, filters, categorization, and notifications.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''The App aggregates material from public domain sources, reproduced accurately, in accordance with applicable copyright policies, with due acknowledgment of the source and without use in a derogatory or misleading context; we exclude any third-party copyrighted material unless authorized by the respective copyright holders. We are not liable for errors in public domain data, and users should verify critical information independently.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''The App includes links to external websites/portals created and maintained by government, non-government, or private organizations for user convenience; once navigated to these sites, users are subject to their privacy and security policies, and महाGR Alert is not responsible for their content, reliability, or views expressed, nor does the presence of these links imply endorsement.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''Personal data is protected with industry-standard security (e.g., encryption), stored in India as per the DPDP Act, 2023, and retained only as needed or legally required. We do not sell data but may share it with trusted service providers (e.g., payment processors) under due procedure. Under the DPDP Act, users have rights to access, correct, delete, or port their data, withdraw consent, or contact our Grievance Officer (mahaGRalert@gmail.com) for concerns, resolved within 15 days per Indian regulations. Cookies may enhance functionality, manageable via device settings.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''This policy, governed by Indian law with disputes under Chhatrapati Sambhajinagar, Maharashtra courts, may be updated, with changes posted in the App; continued use implies acceptance. Contact us at mahaGRalert@gmail.com for queries. Review our Terms and Conditions and Disclaimer in the App for details.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
