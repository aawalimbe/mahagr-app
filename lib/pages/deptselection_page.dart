import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'dart:convert';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';

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
                  MaterialPageRoute(builder: (context)=> const HomePage(),),
                );
              },
              child: Text(
                'Next',
                style: AppTextStyles.medium(20).copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DepartmentChecklist extends StatefulWidget {
  @override
  _DepartmentChecklistState createState() => _DepartmentChecklistState();
}

class _DepartmentChecklistState extends State<DepartmentChecklist> {
  List<dynamic> departments = [];
  Set<int> selectedIds = {};
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text(error!));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final dept = departments[index];
          final id = dept['id'] as int;
          final name = dept['name_mar'] as String;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.8, // ⬅️ Checkbox size
                  child: Checkbox(
                    value: selectedIds.contains(id),
                    shape: const CircleBorder(),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          selectedIds.add(id);
                        } else {
                          selectedIds.remove(id);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIds.contains(id)) {
                          selectedIds.remove(id);
                        } else {
                          selectedIds.add(id);
                        }
                      });
                    },
                    child: Text(name, style: AppTextStyles.medium(25)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
