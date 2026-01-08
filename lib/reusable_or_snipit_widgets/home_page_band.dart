import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/notification_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePageBand extends StatelessWidget {
  const HomePageBand({super.key});
  Future<File> _getImageFileFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/logo.png');

    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

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
                  iconSize: 27,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () async {
                    final imageFile = await _getImageFileFromAssets(
                      'assets/images/original/logo.png',
                    );

                    await Share.shareXFiles(
                      [XFile(imageFile.path)],
                      text: '''🔔 *महाGR Alert अ‍ॅप लाँच* ! 📱
*शासकीय माहिती आता एका क्लिकवर!*

शासकीय अधिकारी/कर्मचारी, लोकप्रतिनिधी, सामाजिक क्षेत्रात काम करणारे व्यक्ती व नागरीक यांच्यासाठी उपयुक्त *“महाGR Alert अ‍ॅप”* 🚀 लाँच झाले आहे!

*अ‍ॅपची वैशिष्ट्ये*
✅ कायदे, नियम, शासन निर्णय, परिपत्रके 📋
✅ विषय/उपविषयानुसार सुलभ वर्गवारी 🗂️
✅ सर्च 🔍 व फिल्टर
✅ डेली नोटिफिकेशन 🔔
✅ डाऊनलोड सुविधा 📥
✅ डॉक्युमेंट Save सुविधा
✅ अद्ययावत माहिती 📈
✅ युझर फ्रेंडली Interface 😊

📲 Google Play Store 🛒 / App Store 🍎
*“महाGR Alert”* अ‍ॅप डाउनलोड करा!

👉 https://example.com/app-link
''',
                      subject: 'महाGR Alert App',
                    );
                  },
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
