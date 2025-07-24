import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/gr_list.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/pdf_viewer.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/language_provider.dart';
import 'dart:io' show rootBundle;
import 'dart:convert';

import 'package:provider/provider.dart';

class SubSubDepartments extends StatefulWidget {
  const SubSubDepartments({super.key});

  @override
  State<SubSubDepartments> createState() => _SubSubDepartmentsState();
}

class _SubSubDepartmentsState extends State<SubSubDepartments> {
  String _searchText = '';
  DateTime? _selectedDate;
  List<Map<String, dynamic>> departments = [];
  Set<int> expandedIndices = {}; // Track expanded rows

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  Future<void> loadDepartments() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/data.json',
    );
    final data = jsonDecode(jsonString);
    final List<Map<String, dynamic>> depts =
        (data['departments'] as List)
            .map((dept) => Map<String, dynamic>.from(dept))
            .toList();
    setState(() {
      departments = depts;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppTextStyles.regular(16.sp),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search, size: 27),
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
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12),
                Focus(
                  child: StatefulBuilder(
                    builder: (context, setInnerState) {
                      bool isFocused = Focus.of(context).hasFocus;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isFocused
                                    ? AppColors.dprimaryColor
                                    : AppColors.primaryColor,
                            width: isFocused ? 3.w : 1.5.w,
                          ),
                          borderRadius: BorderRadius.circular(
                            isFocused ? 10.r : 15.r,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.filter_list, size: 33),
                          tooltip:
                              _selectedDate == null
                                  ? 'Filter by Date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          onPressed: () async {
                            setInnerState(
                              () {},
                            ); // To trigger rebuild for focus effect
                            await _pickDate(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child:
                  departments.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.separated(
                        itemCount: departments.length,
                        separatorBuilder:
                            (context, index) => Divider(height: 16),
                        itemBuilder: (context, index) {
                          final lang =
                              Provider.of<LanguageProvider>(context).language;
                          final department = departments[index];
                          final name =
                              lang == 'mar'
                                  ? (department['name_mar'] ?? '')
                                  : (department['name_eng'] ?? '');
                          final isExpanded = expandedIndices.contains(index);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isExpanded) {
                                          expandedIndices.remove(index);
                                        } else {
                                          expandedIndices.add(index);
                                        }
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        isExpanded ? Icons.remove : Icons.add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (isExpanded)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 24.0,
                                    top: 8.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      departments.length * 2 - 1,
                                      (i) {
                                        if (i.isOdd) {
                                          return SizedBox(height: 8);
                                        }
                                        final deptIndex = i ~/ 2;
                                        final dept = departments[deptIndex];
                                        final deptName =
                                            lang == 'mar'
                                                ? (dept['name_mar'] ?? '')
                                                : (dept['name_eng'] ?? '');
                                        final logoPath = dept['logo'] ?? '';
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const PdfViewer(),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              if (logoPath.isNotEmpty)
                                                Image.asset(
                                                  logoPath,
                                                  width: 30,
                                                  height: 30,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 18,
                                                      ),
                                                )
                                              else
                                                Icon(
                                                  Icons.account_tree,
                                                  size: 18,
                                                ),
                                              SizedBox(width: 10),
                                              Text(
                                                deptName,
                                                style: AppTextStyles.regular(
                                                  16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
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

// Placeholder for DepartmentDetailPage
class DepartmentDetailPage extends StatelessWidget {
  final Map<String, dynamic> department;
  const DepartmentDetailPage({Key? key, required this.department})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang =
        department.containsKey('name_mar') &&
                Localizations.localeOf(context).languageCode == 'mr'
            ? 'mar'
            : 'eng';
    final name =
        lang == 'mar'
            ? (department['name_mar'] ?? '')
            : (department['name_eng'] ?? '');
    final logoPath = department['logo'] ?? '';
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (logoPath.isNotEmpty)
              Image.asset(
                logoPath,
                width: 80,
                height: 80,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Icon(Icons.image_not_supported, size: 40),
              ),
            SizedBox(height: 20),
            Text(name, style: AppTextStyles.bold(24)),
          ],
        ),
      ),
    );
  }
}
