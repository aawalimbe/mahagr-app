import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/welcome_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  // ---------- CELL ----------
  Widget _cell(String text, {bool isHeader = false, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 12.sp : 11.sp,
          fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // ---------- DATA ROW ----------
  TableRow _dataRow({
    required String feature,
    required String value,
    required String description,
  }) {
    return TableRow(
      children: [
        _cell(feature),
        _cell(value, isBold: true),
        _cell(description),
      ],
    );
  }

  // ---------- TABLE ----------
  Widget _paymentTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(4),
      },
      border: TableBorder(
        top: BorderSide(color: Colors.black),
        bottom: BorderSide(color: Colors.black),
        left: BorderSide(color: Colors.black),
        right: BorderSide(color: Colors.black),
        horizontalInside: BorderSide(color: Colors.black26),
        verticalInside: BorderSide(color: Colors.black26),
      ),
      children: [
        // HEADER
        TableRow(
          decoration: BoxDecoration(color: AppColors.backgroundColor),
          children: [
            _cell('FEATURE', isHeader: true),
            _cell('AMOUNT / VALUE', isHeader: true),
            _cell('DESCRIPTION', isHeader: true),
          ],
        ),

        _dataRow(
          feature: 'Subscription Charges',
          value: '₹99 + GST',
          description:
              'Cost for Pro subscription; total including GST shown on payment page',
        ),

        _dataRow(
          feature: 'Mandate Registration Fee',
          value: '₹1.00',
          description: 'One-time charge for auto-payment setup',
        ),

        _dataRow(
          feature: 'Max Mandate Limit',
          value: '₹199',
          description:
              'Set on approval page for easy future payments. No re-authentication needed – seamless experience',
        ),

        _dataRow(
          feature: 'Trial Period',
          value: '7 Days',
          description:
              'Access all Pro features. No charge during trial. Auto-renews unless cancelled',
        ),

        _dataRow(
          feature: 'Cancel Mandate',
          value: 'Anytime',
          description: 'Cancel via bank app or payment gateway',
        ),
      ],
    );
  }

  // ---------- PAGE ----------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Payment Details", style: AppTextStyles.bold(20.sp)),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,

        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SingleChildScrollView(child: _paymentTable()),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              height: 48.h,
              width: double.infinity,

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  // gradient: LinearGradient(
                  //   colors: [Color(0xFF2D6AFF), Color(0xFFED4E7E)],
                  // ),
                  borderRadius: BorderRadius.circular(25.r),
                ),

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // required
                    shadowColor: Colors.transparent, // required
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                  child: Text(
                    '₹1 START TRIAL',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOnDark,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
