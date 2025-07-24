import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';

class Section1Page extends StatefulWidget {
  const Section1Page({super.key});

  @override
  State<Section1Page> createState() => _Section1PageState();
}

class _Section1PageState extends State<Section1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Forest GR Updates',
          style: AppTextStyles.boldItalic(30.sp).copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            iconSize: 30.sp,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Filter Icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: AppColors.primaryColor,
                    ),
                    tooltip: 'Filter',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          String? selectedCategory;
                          DateTime? selectedDate;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Filter By',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    // Date Picker
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          selectedDate == null
                                              ? 'Select Date'
                                              : '${selectedDate!.toLocal()}'
                                                  .split(' ')[0],
                                        ),
                                        Spacer(),
                                        TextButton(
                                          child: Text('Pick Date'),
                                          onPressed: () async {
                                            DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );
                                            if (picked != null) {
                                              setState(() {
                                                selectedDate = picked;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    // Category Dropdown
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.category,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedCategory,
                                            hint: Text('Select Category'),
                                            items: [
                                              DropdownMenuItem(
                                                value: 'All',
                                                child: Text('All'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'News',
                                                child: Text('News'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Updates',
                                                child: Text('Updates'),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedCategory = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                        ),
                                        onPressed: () {
                                          // TODO: Apply filter logic
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Apply',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      height: 140.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('GR Name', style: AppTextStyles.bold(24.sp)),
                              Icon(
                                Icons.picture_as_pdf,
                                color: AppColors.primaryColor,
                                size: 27.sp,
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '12 Jun 2025',
                                style: AppTextStyles.regular(
                                  15.sp,
                                ).copyWith(color: AppColors.secondaryColor),
                              ),
                              SizedBox(width: 60.w),
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/img2.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.visibility,
                                  color: AppColors.primaryColor,
                                  size: 18.sp,
                                ),
                                label: Text(
                                  'View',
                                  style: AppTextStyles.medium(
                                    13.sp,
                                  ).copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.share,
                                  color: AppColors.primaryColor,
                                  size: 18.sp,
                                ),
                                label: Text(
                                  'Share',
                                  style: AppTextStyles.medium(
                                    13.sp,
                                  ).copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                            ],
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

      bottomNavigationBar: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8),
            ],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 500),
            gap: 5,
            color: Colors.white,
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: AppColors.primaryColor.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.settings, text: 'Settings'),
              GButton(icon: Icons.notifications, text: 'Notifications'),
            ],
            onTabChange: (index) {
              // Handle tab change here
            },
          ),
        ),
      ),
    );
  }
}
