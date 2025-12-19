import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/hamburger_menu.dart';

class RefundPolicies extends StatefulWidget {
  const RefundPolicies({super.key});

  @override
  State<RefundPolicies> createState() => _RefundPoliciesState();
}

class _RefundPoliciesState extends State<RefundPolicies> {
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
                'Refund Policy ',
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
                  '''Alpha Developer Team, as the service provider of the महाGR Alert mobile application ("App"), a paid subscription-based service offering premium features such as search, filters, categorization, and notifications, processes subscription payments securely via a PCI DSS-compliant third-party payment gateway (e.g., Razorpay). All subscription plans (e.g., monthly, annual), as detailed in the App are non-refundable for partial or unused periods, including cancellations, downgrades, or non-use of features, unless required by applicable law.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''Refunds may be considered within 7 days of initial subscription purchase only in cases of demonstrable technical failure (e.g., App inaccessibility due to server issues) not attributable to user error, third-party payment gateway issues, or force majeure events (e.g., natural disasters);''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''Requests must be submitted to mahaGRalert@gmail.com with supporting evidence, and approved refunds will be processed within 15 days via the original payment method. We are not liable for payment disputes, gateway-related issues, or delays beyond our control, and users are responsible for ensuring accurate payment information. Subscription auto-renewals may be cancelled before the renewal date to avoid charges, but no prorated refunds are provided.''',
                  style: AppTextStyles.regular(12),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '''The App complies with the relevant act and policies, with user data handled per our Privacy Policy. This Refund Policy, governed by Indian law with disputes under Chhatrapati Sambhajinagar, Maharashtra courts, may be updated, with changes posted in the App; continued use implies acceptance. For queries, contact us at mahaGRalert@gmail.com. Review our Privacy Policy, Terms and Conditions, and Disclaimer in the App for details.''',
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
