import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/customs_notifictions.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/give_sugg.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/login_Page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/share_doc.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const CustomAppBar({super.key, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.isDarkMode;

        return AppBar(
          backgroundColor:
              isDark ? AppColors.darkSurfaceColor : AppColors.primaryColor,
          elevation: 0,
          toolbarHeight: height,
          leadingWidth: 56,

          leading: Builder(
            builder:
                (context) => Center(
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _MenuLine(),
                          SizedBox(height: 5),
                          _MenuLine(),
                          SizedBox(height: 5),
                          _MenuLine(),
                        ],
                      ),
                    ),
                  ),
                ),
          ),

          /// 🏷️ Title (WEB SAFE)
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/original/logo.png',
                height: 40,
                width: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 6),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(
                      "महा",
                      style: AppTextStyles.bold(26).copyWith(
                        color:
                            isDark
                                ? AppColors.darkTextPrimaryColor
                                : AppColors.textOnDark,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "GR",
                      style: AppTextStyles.bold(26).copyWith(
                        color:
                            isDark
                                ? AppColors.darkTextPrimaryColor
                                : AppColors.textOnDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Alert",
                      style: AppTextStyles.italic(14).copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            isDark
                                ? AppColors.darkTextSecondaryColor
                                : AppColors.textOnLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: PopupMenuButton<String>(
                icon: Container(
                  width: 30,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          isDark
                              ? AppColors.darkTextPrimaryColor
                              : AppColors.textOnDark,
                      width: 2,
                    ),
                  ),
                  child: Transform.translate(
                    offset: const Offset(-1.7, 0),
                    child: const Icon(Icons.more_vert, size: 30),
                  ),
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'customs_notification':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomsNotifictions(),
                        ),
                      );
                      break;
                    case 'give_suggestions':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GiveSuggestions(),
                        ),
                      );
                      break;
                    case 'share_documents':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ShareDocs()),
                      );
                      break;
                    case 'logout':
                      logout(context);
                      break;
                  }
                },
                itemBuilder:
                    (_) => [
                      _menuItem('share_app', Icons.share, 'Share App'),
                      _menuItem(
                        'customs_notification',
                        Icons.notifications_active,
                        'Manage Notification',
                      ),
                      _menuItem(
                        'give_suggestions',
                        Icons.feedback,
                        'Give Suggestions',
                      ),
                      _menuItem(
                        'share_documents',
                        Icons.upload_file,
                        'Upload Documents',
                      ),
                      _menuItem('logout', Icons.logout_outlined, 'Logout'),
                    ],
              ),
            ),
          ],
        );
      },
    );
  }

  PopupMenuItem<String> _menuItem(String value, IconData icon, String text) {
    return PopupMenuItem(
      value: value,
      child: Builder(
        builder: (context) {
          final isDark = context.watch<ThemeProvider>().isDarkMode;

          return Row(
            children: [
              Icon(
                icon,
                size: 20,
                color:
                    isDark
                        ? AppColors.darkTextPrimaryColor
                        : AppColors.textOnLight,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: AppTextStyles.medium(14).copyWith(
                  color:
                      isDark
                          ? AppColors.darkTextPrimaryColor
                          : AppColors.textOnLight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuLine extends StatelessWidget {
  const _MenuLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (route) => false,
  );
}
