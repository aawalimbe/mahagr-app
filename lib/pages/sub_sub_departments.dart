import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/gr_list.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubSubDepartments extends StatefulWidget {
  final int subjectId;
  final String departmentNameMar;
  final String departmentNameEng;

  const SubSubDepartments({
    super.key,
    required this.subjectId,
    required this.departmentNameEng,
    required this.departmentNameMar,
  });

  @override
  State<SubSubDepartments> createState() => _SubSubDepartmentsState();
}

class _SubSubDepartmentsState extends State<SubSubDepartments> {
  String _searchText = '';
  DateTime? _fromDate;
  DateTime? _toDate;

  List<Map<String, dynamic>> departments = [];
  int? expandedIndex;

  Map<int, List<Map<String, dynamic>>> subcatsMap = {};
  Set<int> loading = {};

  bool isLoading = true;
  String? errorMessage;

  final List<int> hideSearchFor = [5, 4, 10, 6];
  final List<int> hideDateFor = [12, 2, 5, 4, 10, 6];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.post(
        Uri.parse(ApiList.FetchCategories),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"subject_id": widget.subjectId, "status": "Active"}),
      );

      final data = jsonDecode(response.body);

      if (data is Map && data["status"] == "success") {
        departments = List<Map<String, dynamic>>.from(data["categories"]);
      } else if (data is List) {
        departments = List<Map<String, dynamic>>.from(data);
      } else {
        errorMessage = "No categories found";
      }
    } catch (e) {
      errorMessage = "Error: $e";
    }

    setState(() => isLoading = false);
  }

  Future<void> fetchSubcats(int categoryId) async {
    if (subcatsMap.containsKey(categoryId)) return;

    loading.add(categoryId);
    setState(() {});

    try {
      final response = await http.post(
        Uri.parse(ApiList.FetchSubcategories),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"category_id": categoryId, "status": "All"}),
      );

      final data = jsonDecode(response.body);

      if (data is Map && data.containsKey("sub_categories")) {
        subcatsMap[categoryId] = List<Map<String, dynamic>>.from(
          data["sub_categories"],
        );
      } else if (data is List) {
        subcatsMap[categoryId] = List<Map<String, dynamic>>.from(data);
      } else {
        subcatsMap[categoryId] = [];
      }
    } catch (e) {
      subcatsMap[categoryId] = [];
    }

    loading.remove(categoryId);
    setState(() {});
  }

  Future<void> _pickDate(BuildContext context, bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  Widget _dateBox({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextField(
        readOnly: true,
        textAlign: TextAlign.center,
        controller: TextEditingController(
          text: date == null ? '' : "${date.day}-${date.month}-${date.year}",
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: AppTextStyles.regular(12.sp),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showSearch = !hideSearchFor.contains(widget.subjectId);
    final bool showDate = !hideDateFor.contains(widget.subjectId);
    final bool showSearchButton = showSearch || showDate;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.departmentNameMar,
            style: AppTextStyles.bold(19.sp),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SEARCH
              if (showSearch) ...[
                Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: AppTextStyles.regular(16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Please Enter Important Keyword...",
                        hintStyle: AppTextStyles.regular(12.sp),
                        icon: Icon(Icons.search, size: 28),
                      ),
                      onChanged: (v) => setState(() => _searchText = v),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
              ],

              // DATE FILTERS
              if (showDate) ...[
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        size: 25,
                        color: AppColors.dprimaryColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _dateBox(
                        label: "From Date",
                        date: _fromDate,
                        onTap: () => _pickDate(context, true),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _dateBox(
                        label: "To Date",
                        date: _toDate,
                        onTap: () => _pickDate(context, false),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
              ],

              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : ListView(
                          children: [
                            Divider(height: 12.h), // TOP DIVIDER

                            ...List.generate(departments.length, (index) {
                              final dep = departments[index];

                              final catId =
                                  int.tryParse(
                                    "${dep['category_id'] ?? dep['id'] ?? 0}",
                                  ) ??
                                  0;

                              final name =
                                  dep["category_name"] ??
                                  dep["name_eng"] ??
                                  dep["name_mar"] ??
                                  "";

                              if (_searchText.isNotEmpty &&
                                  !name.toLowerCase().contains(
                                    _searchText.toLowerCase(),
                                  )) {
                                return const SizedBox.shrink();
                              }

                              final isOpen = expandedIndex == index;

                              return Column(
                                children: [
                                  buildCategoryItem(
                                    dep,
                                    index,
                                    catId,
                                    name,
                                    isOpen,
                                  ),
                                  const Divider(height: 5), // BETWEEN ITEMS
                                ],
                              );
                            }),

                            const Divider(height: 12), // BOTTOM DIVIDER
                          ],
                        ),
              ),

              SizedBox(height: 10.h),

              if (showSearchButton)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Search",
                    style: AppTextStyles.bold(18).copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(dep, index, int catId, String name, bool isOpen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: isOpen ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.bold(
                    15,
                  ).copyWith(color: isOpen ? Colors.white : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (isOpen) {
                    setState(() => expandedIndex = null);
                  } else {
                    setState(() => expandedIndex = index);
                    await fetchSubcats(catId);
                  }
                },
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.textOnLight,
                  child: Icon(
                    isOpen ? Icons.remove : Icons.add,
                    color: AppColors.textOnDark,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (isOpen)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: buildSubCategories(catId, name),
          ),
      ],
    );
  }

  Widget buildSubCategories(int catId, String name) {
    if (loading.contains(catId)) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      );
    }

    final scList = subcatsMap[catId] ?? [];

    if (scList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => GrList(
                  subjectId: widget.subjectId,
                  categoryId: catId,
                  subCategoryId: 0,
                  subCategoryName: name,
                ),
          ),
        );
      });
      return const SizedBox.shrink();
    }

    return Column(
      children:
          scList.map((sc) {
            final scId =
                int.tryParse("${sc['sub_category_id'] ?? sc['id']}") ?? 0;

            final scName = sc["sub_category_name"] ?? sc["name"] ?? "";

            return Container(
              width: 330.w,
              decoration: BoxDecoration(
                color: AppColors.celadon,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => GrList(
                            subjectId: widget.subjectId,
                            categoryId: catId,
                            subCategoryId: scId,
                            subCategoryName: scName,
                          ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Text(scName, style: AppTextStyles.regular(14)),
                ),
              ),
            );
          }).toList(),
    );
  }
}
