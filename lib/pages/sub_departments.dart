import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/sub_sub_departments.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'package:provider/provider.dart';

class SubDepartments extends StatefulWidget {
  const SubDepartments({super.key});

  @override
  State<SubDepartments> createState() => _SubDepartmentsState();
}

class _SubDepartmentsState extends State<SubDepartments> {
  List<dynamic> departments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDepartments().then((data) {
      setState(() {
        departments = data;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: EdgeInsetsGeometry.only(left: 6, right: 6, top: 25),
          child: Column(
            children: [
              TextField(
                style: AppTextStyles.regular(16.sp),
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, size: 30.sp),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(
                      color: AppColors.dprimaryColor,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                          padding: EdgeInsets.all(14.sp),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11,
                                childAspectRatio: 0.79,
                              ),
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            var department = departments[index];
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
                                    builder:
                                        (context) => const SubSubDepartments(),
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
                                      style: AppTextStyles.medium(lang=='mar'?15.sp:12.sp),
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
      ),
    );
  }

  Future<List<dynamic>> loadDepartments() async {
    String data = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> jsonMap = json.decode(data);
    return jsonMap['departments']
        .map((dept) => Map<String, dynamic>.from(dept))
        .toList();
  }
}
