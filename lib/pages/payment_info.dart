import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  Widget _tableHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      child: Row(
        children: [
          _headerCell('FEATURE', 3),
          _headerCell('AMOUNT / VALUE', 2),
          _headerCell('DESCRIPTION', 4),
        ],
      ),
    );
  }

  Widget _headerCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _row({
    required String feature,
    required String value,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              description,
              style: TextStyle(fontSize: 12.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'PAYMENT METHODS – KEY INFORMATION',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _tableHeader(),

                _row(
                  feature: 'Subscription Charges',
                  value: '₹99 + GST',
                  description:
                      'Cost for Pro subscription; total including GST shown on payment page',
                ),

                _row(
                  feature: 'Mandate Registration Fee',
                  value: '₹1.00',
                  description: 'One-time charge for auto-payment setup',
                ),

                _row(
                  feature: 'Max Mandate Limit',
                  value: '₹199',
                  description: 'Maximum debit amount allowed per cycle',
                ),

                _row(
                  feature: 'Trial Period',
                  value: '7 Days',
                  description:
                      'Access all Pro features; no charge during trial',
                ),

                _row(
                  feature: 'Cancel Mandate',
                  value: 'Anytime',
                  description: 'Cancel via bank app or payment gateway',
                ),

                const Spacer(),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black)),
                  ),
                  child: Text(
                    'Seamless & Secure Payments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
