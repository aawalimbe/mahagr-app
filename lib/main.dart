import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/start_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/welcome_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/splash_screen.dart';
import 'package:forrest_department_gr_and_updatees_app/test_connection.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //initializes Flutter's engine and platform bindings before
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (optional - uncomment if Firebase is configured)
  // if (!kIsWeb) {
  //   try {
  //     await Firebase.initializeApp();
  //   } catch (e) {
  //     debugPrint('Firebase initialization failed: $e');
  //   }
  // }

  // Initialize API service
  ApiService.initialize();

  // Test online connection
  await testOnlineConnection();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              title: 'Forest Department GR and Updates App Demo',
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(
                      1.0,
                    ), // This will stop app font use the device font size.
                  ),
                  child: child!,
                );
              },
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: child,
            );
          },
        );
      },
      child: const StartPage(),
    );
  }
}
