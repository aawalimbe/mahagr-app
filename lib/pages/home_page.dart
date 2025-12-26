import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_dept.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_sub_departments.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/home_page_band.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _departments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    String data = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> jsonMap = json.decode(data);
    setState(() {
      _departments =
          jsonMap['departments']
              .map((dept) => Map<String, dynamic>.from(dept))
              .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    const HomePageBand(),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 650;

                          return GridView.builder(
                            padding: EdgeInsets.all(14.sp),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isWide ? 6 : 3,
                                  crossAxisSpacing: 13,
                                  mainAxisSpacing: 13,
                                  childAspectRatio: isWide ? 0.85 : 0.74,
                                ),
                            itemCount: _departments.length,
                            itemBuilder: (context, index) {
                              var department = _departments[index];

                              final lang =
                                  Provider.of<LanguageProvider>(
                                    context,
                                  ).language;

                              final fullName =
                                  lang == 'mar'
                                      ? (department['name_mar'] ?? '')
                                      : (department['name_eng'] ?? '');

                              final words = fullName.split(' ');
                              final name =
                                  words.length > 1
                                      ? '${words.sublist(0, words.length - 1).join(' ')}\n${words.last}'
                                      : fullName;

                              return InkWell(
                                onTap: () {
                                  final subjectId =
                                      int.tryParse(
                                        '${department['subject_id']}',
                                      ) ??
                                      0;

                                  if (subjectId == 14) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SubDept(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => SubSubDepartments(
                                              subjectId: subjectId,
                                              departmentNameMar:
                                                  (department['name_mar'] ?? '')
                                                      .toString(),
                                              departmentNameEng:
                                                  (department['name_eng'] ?? '')
                                                      .toString(),
                                            ),
                                      ),
                                    );
                                  }
                                },
                                child: Consumer<ThemeProvider>(
                                  builder: (context, themeProvider, _) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            themeProvider.isDarkMode
                                                ? AppColors.darkCardColor
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color:
                                              themeProvider.isDarkMode
                                                  ? AppColors.darkPrimaryColor
                                                  : AppColors.primaryColor,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                themeProvider.isDarkMode
                                                    ? Colors.black.withOpacity(
                                                      0.3,
                                                    )
                                                    : AppColors.border,
                                            blurRadius: 6,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            department['logo'],
                                            width: isWide ? 55 : 60,
                                            height: isWide ? 55 : 60,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            name,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.regular(
                                              lang == 'mar'
                                                  ? (isWide ? 13 : 14)
                                                  : (isWide ? 11 : 12),
                                            ).copyWith(
                                              color:
                                                  themeProvider.isDarkMode
                                                      ? AppColors
                                                          .darkTextPrimaryColor
                                                      : AppColors.textOnLight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
