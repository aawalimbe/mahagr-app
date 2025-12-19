import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/notification_page.dart';
import 'package:provider/provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';

class HomePageBand extends StatelessWidget {
  const HomePageBand({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 72.h),
      //height: 60.h,
      //width: 280.w,
      decoration: BoxDecoration(
        color: Color(0xFFFFF5EE),
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
        //borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5.r, right: 5.r, bottom: 2.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Share
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                  onPressed: () {},
                  iconSize: 27,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Text('Share App', style: AppTextStyles.regular(10)),
              ],
            ),

            // Vertical Separator 1
            Container(
              width: 1,
              height: 50.h,
              color: Theme.of(context).primaryColor,
            ),

            // Theme
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons
                                .brightness_7 // Sun icon for light mode
                            : Icons.brightness_4, // Moon icon for dark mode
                      ),
                      tooltip:
                          themeProvider.isDarkMode
                              ? 'Switch to Light'
                              : 'Switch to Dark',
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      iconSize: 27,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Text(
                      themeProvider.isDarkMode ? 'Light' : 'Dark',
                      style: AppTextStyles.regular(10),
                    ),
                  ],
                );
              },
            ),

            // Vertical Separator 2
            Container(
              width: 1,
              height: 50.h,
              color: Theme.of(context).primaryColor,
            ),

            // Notifications
            Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  tooltip: 'Notifications',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                  iconSize: 27,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Text('Notifications', style: AppTextStyles.regular(10)),
              ],
            ),

            // Vertical Separator 3
            Container(
              width: 1,
              height: 50.h,
              color: Theme.of(context).primaryColor,
            ),

            // Language
            Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.g_translate),
                  tooltip: 'Language',
                  onPressed: () {
                    // Toggle language when icon is pressed
                    Provider.of<LanguageProvider>(
                      context,
                      listen: false,
                    ).toggleLanguage();
                  },
                  iconSize: 27,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Consumer<LanguageProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.language == 'mar' ? 'मराठी' : 'English',
                      style: AppTextStyles.regular(10),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
