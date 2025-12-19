import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/appbar.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/hamburger_menu.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode 
            ? AppColors.darkBackgroundColor 
            : AppColors.backgroundColor,
          appBar: const CustomAppBar(),
          drawer: const HamburgerMenu(),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }
} 