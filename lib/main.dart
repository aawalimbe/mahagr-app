import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_sub_departments.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/start_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/pdf_viewer.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/gr_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
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
        return MaterialApp(
          title: 'Forest Department GR and Updates App Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            checkboxTheme: CheckboxThemeData(shape: CircleBorder()),
          ),
          home: child,
        );
      },
      child: const StartPage(),
    );
  }
}
