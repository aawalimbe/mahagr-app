import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
// import 'dart:convert'; // Commented out - no longer needed for data.json
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class DepartmentSelectionPage extends StatefulWidget {
  const DepartmentSelectionPage({super.key});

  @override
  State<DepartmentSelectionPage> createState() =>
      _DepartmentSelectionPageState();
}

class _DepartmentSelectionPageState extends State<DepartmentSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: DepartmentChecklist(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text(
                'Next',
                style: AppTextStyles.medium(
                  20,
                ).copyWith(color: AppColors.textOnDark),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DepartmentChecklist extends StatefulWidget {
  const DepartmentChecklist({super.key});

  @override
  _DepartmentChecklistState createState() => _DepartmentChecklistState();
}

class _DepartmentChecklistState extends State<DepartmentChecklist> {
  List<Map<String, dynamic>> departments = [];
  Set<int> selectedIds = {};
  bool isLoading = true;
  String? error;

  // Subject Master state
  List<Map<String, dynamic>> subjects = [];
  bool isLoadingSubjects = true;
  String? subjectsError;
  Set<int> selectedSubjectIds = {};

  @override
  void initState() {
    super.initState();
    // We focus on subjects only on this page
    setState(() {
      isLoading = false;
      error = null;
    });
    // loadDepartmentsFromAPI(); // Not needed when showing only subjects
    loadSubjectsFromAPI(); // Load Subject Master
  }

  // Commented out old data.json loading method
  /*
  Future<void> loadDepartments() async {
    try {
      final String data = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/data/data.json');
      final Map<String, dynamic> parsed = jsonDecode(data);
      setState(() {
        departments = parsed['departments'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load departments';
        isLoading = false;
      });
    }
  }
  */

  // New API-based method to load departments
  Future<void> loadDepartmentsFromAPI() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final List<Map<String, dynamic>> apiDepartments =
          await ApiService.getDepartments();

      // Debug logging to see what we're getting
      print('API Response: $apiDepartments');
      print('Departments count: ${apiDepartments.length}');

      setState(() {
        departments = apiDepartments;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading departments: $e');
      setState(() {
        error = 'Failed to load departments: $e';
        isLoading = false;
      });
    }
  }

  // Load subjects from API
  Future<void> loadSubjectsFromAPI() async {
    try {
      setState(() {
        isLoadingSubjects = true;
        subjectsError = null;
      });

      final List<Map<String, dynamic>> apiSubjects =
          await ApiService.getSubjects(status: 'Active');

      // Debug logging
      print('Subjects API Response: $apiSubjects');
      print('Subjects count: ${apiSubjects.length}');

      setState(() {
        subjects = apiSubjects;
        isLoadingSubjects = false;
      });
    } catch (e) {
      print('Error loading subjects: $e');
      setState(() {
        subjectsError = 'Failed to load subjects: $e';
        isLoadingSubjects = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // Subjects Section (names only with multi-select)
          Center(
            child: Text(
              "Get important updates & alerts",
              style: AppTextStyles.bold(
                14.sp,
              ).copyWith(color: AppColors.darkCompulsory),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              "You can change this anytime in manage notifications",
              style: AppTextStyles.regular(
                12,
              ).copyWith(color: AppColors.secondaryText),
            ),
          ),
          SizedBox(height: 8.h),
          if (isLoadingSubjects)
            const Center(child: CircularProgressIndicator())
          else if (subjectsError != null)
            Column(
              children: [
                Text(
                  subjectsError!,
                  style: AppTextStyles.medium(
                    16,
                  ).copyWith(color: AppColors.compulsory),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: loadSubjectsFromAPI,
                  child: const Text('Retry'),
                ),
              ],
            )
          else if (subjects.isEmpty)
            Text('No subjects found', style: AppTextStyles.medium(16))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                final dynamic sidVal = subject['subject_id'] ?? index;
                final int subjectId = sidVal is int ? sidVal : index;
                final String subjectName =
                    (subject['subject_name'] ?? 'Subject ${index + 1}')
                        .toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: selectedSubjectIds.contains(subjectId),
                          shape: const CircleBorder(),
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                selectedSubjectIds.add(subjectId);
                              } else {
                                selectedSubjectIds.remove(subjectId);
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedSubjectIds.contains(subjectId)) {
                                selectedSubjectIds.remove(subjectId);
                              } else {
                                selectedSubjectIds.add(subjectId);
                              }
                            });
                          },
                          child: Text(
                            subjectName,
                            style: AppTextStyles.regular(18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
