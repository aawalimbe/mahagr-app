import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/gr_list.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_list.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class SubDept1 extends StatefulWidget {
  final int subjectId;
  final int categoryId;
  final String departmentNameMar;
  final String departmentNameEng;

  const SubDept1({
    super.key,
    required this.subjectId,
    required this.categoryId,
    required this.departmentNameMar,
    required this.departmentNameEng,
  });

  @override
  State<SubDept1> createState() => _SubDept1State();
}

class _SubDept1State extends State<SubDept1> {
  String searchText = '';
  DateTime? fromDate;
  DateTime? toDate;
  int? expandedIndex;

  bool isLoading = true;
  String? errorMessage;

  List<Map<String, dynamic>> subCategories = [];
  Map<int, List<Map<String, dynamic>>> subSubMap = {};
  Set<int> loading = {};

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }

  // -------------------- API : SUB-CATEGORIES --------------------

  Future<void> fetchSubCategories() async {
    try {
      final res = await ApiService.post(ApiList.FetchSubcategories, {
        "category_id": widget.categoryId,
        "status": "All",
      });

      if (res['status'] == 'success') {
        subCategories = List<Map<String, dynamic>>.from(res['sub_categories']);
      } else {
        errorMessage = "No sub-categories found";
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    setState(() => isLoading = false);
  }

  // -------------------- API : SUB-SUB-CATEGORIES --------------------

  Future<void> fetchSubSubCategories(int subCategoryId) async {
    if (subSubMap.containsKey(subCategoryId)) return;

    loading.add(subCategoryId);
    setState(() {});

    try {
      final res = await ApiService.post(ApiList.FetchSubSubcategories, {
        "sub_category_id": subCategoryId,
        "status": "All",
      });

      if (res['status'] == 'success') {
        subSubMap[subCategoryId] = List<Map<String, dynamic>>.from(
          res['sub_sub_categories'],
        );
      } else {
        subSubMap[subCategoryId] = [];
      }
    } catch (_) {
      subSubMap[subCategoryId] = [];
    }

    loading.remove(subCategoryId);
    setState(() {});
  }

  // -------------------- DATE PICKER --------------------

  Future<void> pickDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        isFrom ? fromDate = picked : toDate = picked;
      });
    }
  }

  Widget dateBox(String label, DateTime? date, VoidCallback onTap) {
    return Container(
      height: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextField(
        readOnly: true,
        onTap: onTap,
        textAlign: TextAlign.center,
        controller: TextEditingController(
          text: date == null ? '' : "${date.day}-${date.month}-${date.year}",
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: AppTextStyles.regular(12.sp),
        ),
      ),
    );
  }

  // -------------------- UI --------------------

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // SEARCH
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: AppColors.primaryColor, width: 1.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Please Enter Important Keyword...",
                    hintStyle: AppTextStyles.regular(12.sp),
                    icon: const Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => searchText = v),
                ),
              ),

              SizedBox(height: 15.h),

              // DATE FILTER
              Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(Icons.calendar_today),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: dateBox("From Date", fromDate, () => pickDate(true)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: dateBox("To Date", toDate, () => pickDate(false)),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              // SUB-CATEGORY LIST
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : ListView.builder(
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            final sc = subCategories[index];
                            final isOpen = expandedIndex == index;

                            final int scId =
                                int.tryParse(
                                  sc['sub_category_id'].toString(),
                                ) ??
                                0;

                            final String name =
                                sc['sub_category_name']?.toString() ?? '';

                            if (searchText.isNotEmpty &&
                                !name.toLowerCase().contains(
                                  searchText.toLowerCase(),
                                )) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isOpen
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: AppTextStyles.bold(
                                            15,
                                          ).copyWith(
                                            color:
                                                isOpen
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (isOpen) {
                                            setState(
                                              () => expandedIndex = null,
                                            );
                                          } else {
                                            setState(
                                              () => expandedIndex = index,
                                            );
                                            await fetchSubSubCategories(scId);
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.black,
                                          child: Icon(
                                            isOpen ? Icons.remove : Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // SUB-SUB-CATEGORIES
                                if (isOpen)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: buildSubSubCategories(scId, name),
                                  ),

                                const Divider(height: 5),
                              ],
                            );
                          },
                        ),
              ),

              // SEARCH BUTTON
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

  // -------------------- SUB-SUB UI + AUTO NAVIGATION --------------------

  Widget buildSubSubCategories(int scId, String scName) {
    if (loading.contains(scId)) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      );
    }

    final list = subSubMap[scId] ?? [];

    // Same auto-navigation logic as SubSubDepartments
    if (list.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => GrList(
                  subjectId: widget.subjectId,
                  categoryId: widget.categoryId,
                  subCategoryId: scId,
                  subSubCategoryId: 0,
                  subCategoryName: scName,
                  departmentNameMar: widget.departmentNameMar,
                  departmentNameEng: widget.departmentNameEng,
                ),
          ),
        );
      });
      return const SizedBox.shrink();
    }

    return Column(
      children:
          list.map((ssc) {
            final int subSubId =
                int.tryParse("${ssc['sub_sub_category_id']}") ?? 0;

            final String subSubName =
                ssc['sub_sub_category_name']?.toString() ?? '';

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: AppColors.celadon,
                borderRadius: BorderRadius.circular(6),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => GrList(
                            subjectId: widget.subjectId,
                            categoryId: widget.categoryId,
                            subCategoryId: scId,
                            subSubCategoryId: subSubId,
                            subCategoryName: subSubName,
                            departmentNameMar: widget.departmentNameMar,
                            departmentNameEng: widget.departmentNameEng,
                          ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Text(subSubName, style: AppTextStyles.regular(14)),
                ),
              ),
            );
          }).toList(),
    );
  }
}
