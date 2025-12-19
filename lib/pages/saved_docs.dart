import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/home_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/hamburger_menu.dart';

class SavedDocuments extends StatefulWidget {
  const SavedDocuments({super.key});

  @override
  State<SavedDocuments> createState() => _SavedDocumentsState();
}

class _SavedDocumentsState extends State<SavedDocuments> {
  Widget _headerCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.bold(12.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textOnDark, size: 30.sp),
          title: Text(
            'Saved Documents',
            style: AppTextStyles.bold(
              16.sp,
            ).copyWith(color: AppColors.textOnDark),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 545,
                //MediaQuery.of(context).size.width,
              ),

              child: Table(
                border: TableBorder.all(color: AppColors.border, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(40), // Sr. No.
                  1: FlexColumnWidth(200), // Particulars
                  2: FlexColumnWidth(70), // Date
                  3: FlexColumnWidth(70), // View
                  4: FlexColumnWidth(95), // Download
                  5: FlexColumnWidth(70), // Delete
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                    children: [
                      _headerCell('Sr.'),
                      _headerCell('Title'),
                      _headerCell('Date'),
                      _headerCell('View'),
                      _headerCell('Download'),
                      _headerCell('Delete'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
