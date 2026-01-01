import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/contact_us.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/disclaimer_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/edit_profile.dart';
// Pages
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/privacy_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/refund_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/saved_docs.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/terms_and_conditions.dart';
// Shared
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  Widget _menuItem({
    required IconData icon,
    required String title,
    required Widget page,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title, style: AppTextStyles.medium(14)),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Drawer width:
        /// - Mobile: 80% screen
        /// - Tablet/Web: max 300
        final double drawerWidth =
            constraints.maxWidth < 600 ? constraints.maxWidth * 0.8 : 300;

        return SizedBox(
          width: drawerWidth,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border(
                right: BorderSide(color: AppColors.vibrantgreen, width: 4),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.vibrantgreen.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(6, 0),
                ),
              ],
            ),
            child: Drawer(
              backgroundColor: AppColors.backgroundColor,
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 24),

                    /// Logo Section
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/original/logo.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: drawerWidth * 0.7,
                          height: 2,
                          color: AppColors.textOnLight,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _menuItem(
                      icon: Icons.home,
                      title: 'Home',
                      page: const HomePage(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.manage_accounts,
                      title: 'Edit Profile',
                      page: const EditProfile(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.file_download,
                      title: 'Saved Documents',
                      page: const SavedDocuments(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.shield,
                      title: 'Privacy Policies',
                      page: const PrivacyPolicies(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.currency_rupee,
                      title: 'Refund Policies',
                      page: const RefundPolicies(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.rule,
                      title: 'Terms and Conditions',
                      page: const TermsAndConditions(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.warning_amber,
                      title: 'Disclaimer',
                      page: const DisclaimerPolicies(),
                      context: context,
                    ),
                    _menuItem(
                      icon: Icons.contact_mail,
                      title: 'Contact Us',
                      page: const ContactUs(),
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
