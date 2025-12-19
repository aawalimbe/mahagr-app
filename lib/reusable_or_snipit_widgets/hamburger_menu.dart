import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Pages
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/edit_profile.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/saved_docs.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/privacy_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/refund_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/terms_and_conditions.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/disclaimer_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/contact_us.dart';

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
      leading: Icon(icon, size: 20.sp),
      title: Text(title, style: AppTextStyles.medium(14.sp)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 235.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border(
            right: BorderSide(color: AppColors.vibrantgreen, width: 4.w),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.vibrantgreen.withOpacity(0.4),
              blurRadius: 16.r,
              spreadRadius: 2.r,
              offset: Offset(12.w, 0),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
        ),
        child: Drawer(
          backgroundColor: AppColors.backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 40.h),

              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/project_image/logo.png',
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: 200.w,
                      height: 2.h,
                      color: AppColors.textOnLight,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

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
    );
  }
}
