import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/payment_info.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/welcome_page.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textOnLight,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.r,
                    horizontal: 60.r,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/original/logo.png',
                            height: 90.h,
                            width: 90.h, // adjust size as needed
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow.shade700,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 16,
                        ),
                        child: const Center(
                          child: Text(
                            'SUBSCRIBE NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  'UNLOCK ALL DOCUMENTS',
                  style: TextStyle(
                    color: Colors.yellow.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Try 7 days for',
                  style: TextStyle(
                    color: Colors.yellow.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  '₹1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Then ₹99/month',
                  style: TextStyle(color: Colors.white, fontSize: 14.4),
                ),
                const SizedBox(height: 2),

                const Text(
                  'Cancel Anytime',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                /// ✅ Table with 15 rows
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 1.5,
                      ),
                      outside: BorderSide(
                        color: Colors.yellow.shade700,
                        width: 1.5,
                      ),
                    ),
                    children: [
                      _buildRow('1. Act/Rules', '2. GR/Circulars'),
                      _buildRow('3. Maha. Gazette', '4. Cabinet Decisions'),
                      _buildRow('5. Govt. Policies', '6. Govt. Schemes'),
                      _buildRow(
                        '7. Citizen Charter',
                        '8. Right to Information',
                      ),
                      _buildRow('9. Right to Services', '10. Treasury Forms'),
                      _buildRow('11. Annual Reports', '12. Govt. Calendar'),
                      _buildRow('13. Important Webs', '14. Govt. Mobile Apps'),
                      _buildRow('15. E-Books', 'And much more'),
                      //_buildRow('Important Contact Numbers', ''),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  //height: 50.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1976D2), Color(0xFFED4E7E)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentMethodsPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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

  TableRow _buildRow(String left, String right) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          alignment: Alignment.centerLeft,
          child: FeatureText(left),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.yellow,
                width: 0,
              ), // prevent double borders
            ),
          ),
          child: FeatureText(right),
        ),
      ],
    );
  }
}

class FeatureText extends StatelessWidget {
  final String text;
  const FeatureText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
