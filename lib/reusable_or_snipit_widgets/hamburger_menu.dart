import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/disclaimer_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/edit_profile.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/privacy_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/refund_policies.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/terms_and_conditions.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border(
            right: BorderSide(color: AppColors.vibrantgreen, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.vibrantgreen.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: 2,
              offset: Offset(12, 0),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Drawer(
          backgroundColor: AppColors.backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 40), // Space from top
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'assets/images/project_image/logo.png',
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home', style: AppTextStyles.medium(20)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.manage_accounts),
                title: Text('Edit Profile', style: AppTextStyles.medium(20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Saved Documents', style: AppTextStyles.medium(20)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.shield),
                title: Text(
                  'Privacy Policies',
                  style: AppTextStyles.medium(20),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicies(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.currency_rupee),
                title: Text('Refund Policies', style: AppTextStyles.medium(20)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RefundPolicies(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.rule),
                title: Text(
                  'Terms and Conditions',
                  style: AppTextStyles.medium(20),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsAndConditions(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.warning_amber),
                title: Text('Disclaimer', style: AppTextStyles.medium(20)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DisclaimerPolicies(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text('Contact Us', style: AppTextStyles.medium(20)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
