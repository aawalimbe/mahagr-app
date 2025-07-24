import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';

// UserProfile model for serialization/deserialization
/*
class UserProfile {
  final String name;
  final String email;
  final String mobile;
  final String district;
  final String userType;
  final String? department;

  UserProfile({
    required this.name,
    required this.email,
    required this.mobile,
    required this.district,
    required this.userType,
    this.department,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      district: json['district'] ?? '',
      userType: json['userType'] ?? '',
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobile': mobile,
        'district': district,
        'userType': userType,
        'department': department,
      };
}
*/
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();

  String? _selectedUserType;
  String? _selectedDepartment;
  String? _selectedDistrict;
  List<String> _departments = [];
  List<String> _districts = [];
  bool _isLoadingDept = false;
  bool _isLoadingProfile = false;
  String? _errorMsg;

  final List<String> _userTypes = [
    'Govt Officer/Employee',
    'NGO',
    'Advocate/Lawyer',
    "People's Representatives",
    'Citizen',
    'Other',
  ];

  InputDecoration buildDecoration(String label) {
    return InputDecoration(
      labelStyle: AppTextStyles.regular(16.sp),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: AppColors.dprimaryColor, width: 3.w),
      ),
    );
  }

  Future<List<String>> fetchDepartments() async {
    // TODO: Replace with real backend call
    await Future.delayed(const Duration(seconds: 1));
    return ['Forest', 'Revenue', 'Police', 'Education', 'Health'];
  }

  void _onUserTypeChanged(String? value) async {
    setState(() {
      _selectedUserType = value;
      _selectedDepartment = null;
      _selectedDistrict = null;
      _departments = [];
    });
    if (value == 'Govt Officer/Employee') {
      setState(() {
        _isLoadingDept = true;
      });
      final depts = await fetchDepartments();
      setState(() {
        _departments = depts;
        _isLoadingDept = false;
      });
    }
  }

  // Fetch user profile from backend (replace URL with real endpoint)
  /*
  Future<void> fetchUserProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _errorMsg = null;
    });
    try {
      // TODO: Replace with your real API endpoint
      final response = await http.get(Uri.parse('https://example.com/api/profile'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final profile = UserProfile.fromJson(data);
        setState(() {
          _nameCtrl.text = profile.name;
          _emailCtrl.text = profile.email;
          _mobileCtrl.text = profile.mobile;
          _selectedDistrict = profile.district;
          _selectedUserType = profile.userType;
          _selectedDepartment = profile.department;
        });
        if (profile.userType == 'Govt Officer/Employee') {
          final depts = await fetchDepartments();
          setState(() {
            _departments = depts;
          });
        }
      } else {
        setState(() {
          _errorMsg = 'Failed to load profile.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMsg = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoadingProfile = false;
      });
    }
  }
  */

  // Update user profile to backend (replace URL with real endpoint)
  /*
  Future<void> updateUserProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _errorMsg = null;
    });
    final profile = UserProfile(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      mobile: _mobileCtrl.text,
      district: _selectedDistrict ?? '',
      userType: _selectedUserType ?? '',
      department: _selectedUserType == 'Govt Officer/Employee' ? _selectedDepartment : null,
    );
    try {
      // TODO: Replace with your real API endpoint
      final response = await http.put(
        Uri.parse('https://example.com/api/profile/update'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profile.toJson()),
      );
      if (response.statusCode == 200) {
        // Success: Optionally show a message or navigate
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        // Navigate to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _errorMsg = 'Failed to update profile.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMsg = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoadingProfile = false;
      });
    }
  }
  */

  @override
  void initState() {
    super.initState();
    _loadDistricts();
    // fetchUserProfile();
  }

  Future<void> _loadDistricts() async {
    final String response = await rootBundle.loadString(
      'assets/data/data.json',
    );
    final data = await json.decode(response);
    setState(() {
      _districts = List<String>.from(data['districts'].map((d) => d['name']));
    });
  }

  Widget compulsoryLabel(String label, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: AppTextStyles.bold(18.sp)),
            const SizedBox(width: 4),
            const Text('*', style: TextStyle(color: Colors.red, fontSize: 18)),
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
            child: Text(
              subtitle,
              style: AppTextStyles.regular(
                14.sp,
              ).copyWith(color: Colors.grey[700]),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 70.h,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: AppTextStyles.bold(
              26.sp,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: compulsoryLabel(
                        'Full Name',
                        subtitle:
                            "Surname - First Name - Father's/Husband's Name",
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: buildDecoration('Full Name'),
                      validator:
                          (value) => value!.isEmpty ? 'Enter full name' : null,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: compulsoryLabel('Email Id'),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: buildDecoration('Email Id'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter valid email id';
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value))
                          return 'Enter valid email id';
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: compulsoryLabel('Mobile No.'),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: _mobileCtrl,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: buildDecoration('Mobile No.'),
                      validator:
                          (value) =>
                              value == null || value.length != 10
                                  ? 'Enter 10-digit mobile no.'
                                  : null,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: compulsoryLabel('District'),
                    ),
                    SizedBox(height: 4.h),
                    DropdownButtonFormField<String>(
                      value: _selectedDistrict,
                      decoration: buildDecoration('District'),
                      items:
                          _districts
                              .map(
                                (dist) => DropdownMenuItem(
                                  value: dist,
                                  child: Text(dist),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (val) => setState(() => _selectedDistrict = val),
                      validator:
                          (value) => value == null ? 'Select district' : null,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: compulsoryLabel('User Type'),
                    ),
                    SizedBox(height: 4.h),
                    DropdownButtonFormField<String>(
                      value: _selectedUserType,
                      decoration: buildDecoration('User Type'),
                      items:
                          _userTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                      onChanged: _onUserTypeChanged,
                      validator:
                          (value) => value == null ? 'Select user type' : null,
                    ),
                    if (_selectedUserType == 'Govt Officer/Employee') ...[
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: compulsoryLabel('Department'),
                      ),
                      SizedBox(height: 4.h),
                      _isLoadingDept
                          ? const CircularProgressIndicator()
                          : DropdownButtonFormField<String>(
                            value: _selectedDepartment,
                            decoration: buildDecoration('Department'),
                            items:
                                _departments
                                    .map(
                                      (dept) => DropdownMenuItem(
                                        value: dept,
                                        child: Text(dept),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (val) =>
                                    setState(() => _selectedDepartment = val),
                            validator:
                                (value) =>
                                    value == null ? 'Select department' : null,
                          ),
                    ],
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        'Update Profile',
                        style: AppTextStyles.bold(
                          20.sp,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
