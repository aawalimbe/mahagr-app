import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_departments.dart';
import 'dart:convert';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/home_page_band.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
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
                      child: GridView.builder(
                        padding: EdgeInsets.all(14.sp),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 13,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: _departments.length,
                        itemBuilder: (context, index) {
                          var department = _departments[index];

                          final lang =
                              Provider.of<LanguageProvider>(context).language;
                          final name =
                              lang == 'mar'
                                  ? (department['name_mar'] ?? '')
                                  : (department['name_eng'] ?? '');
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SubDepartments(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.r),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2.5.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    department['logo'],
                                    width: 60.w,
                                    height: 60.w,
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.medium(lang=='mar'?16.sp:12.sp),
                                  ),
                                ],
                              ),
                            ),
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
