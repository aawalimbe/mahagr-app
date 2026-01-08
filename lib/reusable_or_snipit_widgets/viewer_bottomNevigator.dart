import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class ViewerBottomNavigator extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onSave;
  final VoidCallback onDownload;
  final VoidCallback onRotate;
  final bool isSaved;

  const ViewerBottomNavigator({
    super.key,
    required this.onShare,
    required this.onSave,
    required this.onDownload,
    required this.onRotate,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          color:
              themeProvider.isDarkMode
                  ? AppColors.darkSurfaceColor
                  : AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const _NavItem(icon: Icons.home, label: 'Home'),
              ),
              GestureDetector(
                onTap: onShare,
                child: const _NavItem(icon: Icons.share, label: 'Share'),
              ),
              GestureDetector(
                onTap: onSave,
                child: _NavItem(
                  icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                  label: isSaved ? 'Saved' : 'Save',
                ),
              ),
              GestureDetector(
                onTap: () {
                  onRotate();
                },
                behavior: HitTestBehavior.opaque,
                excludeFromSemantics: true,
                child: const _NavItem(
                  icon: Icons.screen_rotation,
                  label: 'Rotate',
                ),
              ),
              GestureDetector(
                onTap: onDownload,
                child: const _NavItem(icon: Icons.download, label: 'Download'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  themeProvider.isDarkMode
                      ? AppColors.darkTextPrimaryColor
                      : AppColors.textOnDark,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.regular(12).copyWith(
                color:
                    themeProvider.isDarkMode
                        ? AppColors.darkTextPrimaryColor
                        : AppColors.textOnDark,
              ),
            ),
          ],
        );
      },
    );
  }
}
