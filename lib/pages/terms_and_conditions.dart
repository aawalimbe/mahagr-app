import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/hamburger_menu.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
                'Terms and Conditions ',
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
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionText(
                  'By downloading, installing, or using the महाGR Alert mobile application ("App"), a paid subscription-based service provided by Alpha Developer Team and you agree to be bound by these Terms and Conditions ("Terms"). If you do not agree, do not use the App. These Terms govern your access to and use of the App, including its features and subscription services.',
                ),
                _buildSectionTitle(
                  '1. App Description and Subscription Services',
                ),
                _buildSectionText(
                  'The App aggregates material from public domain sources to provide informational access through premium features, including search, filters, categorization, and notifications, available via a paid subscription model. Subscriptions are offered in various plans (e.g., monthly, annual), with pricing and details available in the App. Payments are processed securely via a PCI DSS-compliant third-party payment gateway (e.g., Razorpay). We are not liable for payment disputes, gateway-related issues, or service interruptions beyond our control. Subscriptions auto-renew unless canceled by you before the renewal date, and no refunds are provided for partial or unused subscription periods unless required by applicable law (e.g., Consumer Protection Act, 2019).',
                ),
                _buildSectionTitle('2. Use of Public Domain Data'),
                _buildSectionText(
                  'The App reproduces GRs accurately, from public domain sources in accordance with applicable copyright policies, with due acknowledgment of the source and without use in a derogatory or misleading context. Third-party copyrighted material is excluded unless authorized by the respective copyright holders. While we strive to present information with care and diligence, we do not guarantee the accuracy, completeness, timeliness, or reliability of this information. Users must independently verify critical information by contacting the concerned Department/Officer of the Government of Maharashtra for clarifications in case of inconsistency or confusion.',
                ),
                _buildSectionTitle('3. External Links'),
                _buildSectionText(
                  'The App include links to external websites/portals maintained by government, non-government, or private organizations for your convenience. We are not responsible for the content, reliability, or privacy/security policies of these linked sites, and their presence does not imply endorsement. Users access these links at their own risk.',
                ),
                _buildSectionTitle('4. User Responsibilities'),
                _buildSectionText(
                  'You agree to use the App for lawful purposes, provide accurate information during subscription registration, and maintain the confidentiality of your account credentials. Comply with all applicable laws and policies. Independently verify GR information before relying on it for decisions. You are responsible for any consequences arising from your use of the App, including reliance on its content or features. Unauthorized use, such as attempting to access restricted features without a valid subscription, reverse-engineering, or distributing App content, is prohibited and may result in account termination.',
                ),
                _buildSectionTitle('5. Limitation of Liability'),
                _buildSectionText(
                  'The App and its subscription services are provided “as is” and “as available” for informational purposes only, without affiliation, endorsement, or sponsorship by any government entity. To the fullest extent permitted by law, Alpha Developer Team is not liable for any direct, indirect, incidental, consequential, or punitive damages arising from errors, omissions, or inaccuracies in GRs or other public domain data; interruptions, delays, or unavailability of the App or its features (e.g., notifications); payment disputes or issues with third-party payment gateways; user actions or reliance on App content; unauthorized access or use of the App. We do not guarantee the timeliness, completeness, or functionality of the App, including its premium features.',
                ),
                _buildSectionTitle('6. Intellectual Property'),
                _buildSectionText(
                  'The App’s design, interface, logos, and proprietary content (excluding public domain material) are the intellectual property of Alpha Developer Team. Users may not reproduce, modify, or distribute this proprietary content without our express written permission. Public domain GRs may be used in accordance with applicable laws, provided the source is acknowledged and the use is not derogatory or misleading.',
                ),
                _buildSectionTitle('7. Compliance with Laws and Policies'),
                _buildSectionText(
                  'The App complies with the relevant act and policies. User data is handled as outlined in our Privacy Policy, and personal information is not shared with third parties without explicit consent, except as required by law. Subscription-based features are subject to these Terms and applicable consumer protection regulations.',
                ),
                _buildSectionTitle('8. Termination'),
                _buildSectionText(
                  'We reserve the right to suspend or terminate your access to the App, including your subscription, at our discretion, without notice or refund, if you violate these Terms and Conditions, engage in unauthorized or illegal use of the App, or fail to pay subscription fees. Upon termination, your access to premium features will cease, but these Terms’ provisions (e.g., limitation of liability, intellectual property) will survive.',
                ),
                _buildSectionTitle('9. Modifications to Terms'),
                _buildSectionText(
                  'We may update these Terms at our discretion, with changes posted in the App. Continued use of the App after updates constitutes your acceptance of the revised Terms. It is your responsibility to review the Terms periodically.',
                ),
                _buildSectionTitle('10. Governing Law and Dispute Resolution'),
                _buildSectionText(
                  'These Terms are governed by the laws of India. Any disputes arising from your use of the App shall be subject to the exclusive jurisdiction of the courts in Chhatrapati Sambhajinagar, Maharashtra. You agree to resolve disputes amicably through negotiation before pursuing legal action, where possible.',
                ),
                _buildSectionTitle('11. Contact Information'),
                _buildSectionText(
                  'For queries or concerns, contact our support team at Email: mahaGRalert@gmail.com. For data-related concerns, refer to our Privacy Policy for Grievance Officer details.',
                ),
                _buildSectionTitle('12. Miscellaneous'),
                _buildSectionText(
                  'No Affiliation: The App is not affiliated with, endorsed by, or sponsored by any government entity.\n\n'
                  'Severability: If any provision of these Terms is found invalid or unenforceable, the remaining provisions remain in effect.\n\n'
                  'Entire Agreement: These Terms, along with the Privacy Policy and Disclaimer, constitute the entire agreement between you and Alpha Developer Team regarding the App.\n\n'
                  'Risk: You use the App at your own risk, subject to these Terms. Review our Privacy Policy and Disclaimer in the App for additional details.',
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
      child: Text(title, style: AppTextStyles.bold(13.sp)),
    );
  }

  Widget _buildSectionText(String content) {
    return Text(
      content,
      style: AppTextStyles.regular(12.sp),
      textAlign: TextAlign.justify,
    );
  }
}
