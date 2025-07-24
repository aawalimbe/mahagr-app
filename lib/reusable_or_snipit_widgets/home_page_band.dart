import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';

class HomePageBand extends StatelessWidget {
  const HomePageBand({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 280.w,
      decoration: BoxDecoration(
        color: Color(0xFFFFF5EE),
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
        //borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Share
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                  onPressed: () {},
                  iconSize: 29,
                ),
                const Text('Share', style: TextStyle(fontSize: 11)),
              ],
            ),
            // Theme
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  tooltip: 'Theme',
                  onPressed: () {},
                  iconSize: 29,
                ),
                const Text('Theme', style: TextStyle(fontSize: 11)),
              ],
            ),
            // Accessibility
            /*Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.accessibility),
                  tooltip: 'Accessibility',
                  onPressed: () {},
                  iconSize: 29,
                ),
                const Text('Accessibility', style: TextStyle(fontSize: 11)),
              ],
            ),*/
            // Notifications
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  tooltip: 'Notifications',
                  onPressed: () {},
                  iconSize: 29,
                ),
                const Text('Notifications', style: TextStyle(fontSize: 11)),
              ],
            ),
            // Language
            Column(
              mainAxisSize: MainAxisSize.min,
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
                  iconSize: 29,
                ),
                Consumer<LanguageProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.language == 'mar' ? 'मराठी' : 'English',
                      style: const TextStyle(fontSize: 11),
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
