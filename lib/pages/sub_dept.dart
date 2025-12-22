import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';

import 'package:provider/provider.dart';

class SubDept extends StatefulWidget {
  const SubDept({super.key});

  @override
  State<SubDept> createState() => _SubDeptState();
}

class _SubDeptState extends State<SubDept> {
  List<dynamic> _subDepartments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubDepartments();
  }

  Future<void> _loadSubDepartments() async {
    final data = await rootBundle.loadString('assets/data/data.json');
    final Map<String, dynamic> jsonMap = json.decode(data);

    setState(() {
      _subDepartments =
          jsonMap['subdepartment']
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).language;

    return SafeArea(
      child: CustomScaffold(
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                  padding: EdgeInsets.all(14.sp),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                    childAspectRatio: 0.74,
                  ),
                  itemCount: _subDepartments.length,
                  itemBuilder: (context, index) {
                    final subDept = _subDepartments[index];

                    final fullName =
                        lang == 'mar'
                            ? (subDept['name_mar'] ?? '')
                            : (subDept['name_eng'] ?? '');

                    final words = fullName.split(' ');
                    final name =
                        words.length > 1
                            ? '${words.sublist(0, words.length - 1).join(' ')}\n${words.last}'
                            : fullName;

                    return Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.darkCardColor
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color:
                                    themeProvider.isDarkMode
                                        ? AppColors.darkPrimaryColor
                                        : AppColors.primaryColor,
                                width: 2.5.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      themeProvider.isDarkMode
                                          ? Colors.black.withOpacity(0.3)
                                          : AppColors.border,
                                  blurRadius: 6,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  subDept['logo'],
                                  width: 60.w,
                                  height: 60.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regular(
                                    lang == 'mar' ? 14.sp : 12.sp,
                                  ).copyWith(
                                    color:
                                        themeProvider.isDarkMode
                                            ? AppColors.darkTextPrimaryColor
                                            : AppColors.textOnLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
