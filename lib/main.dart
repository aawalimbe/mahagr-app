import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_dept.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';
import 'package:forrest_department_gr_and_updatees_app/test_connection.dart';

void main() {
  // Initialize API service
  ApiService.initialize();

  // Test online connection
  testOnlineConnection();

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
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: child,
            );
          },
        );
      },
      child: const SubDept(),
    );
  }
}
