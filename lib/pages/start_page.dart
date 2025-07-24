import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/welcome_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
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
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow.shade700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'महा',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              const TextSpan(
                                text: 'GR',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const TextSpan(
                                text: 'Alert',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                            height: 1.5,
                            leading: 0.5,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.yellow.shade700,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          child: const Center(
                            child: Text(
                              'SUBSCRIBE NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'UNLOCK ALL DOCUMENTS',
                    style: TextStyle(
                      color: Colors.yellow.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Try 7 days for',
                    style: TextStyle(
                      color: Colors.yellow.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const Text(
                    '₹1',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Then ₹30/month',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Cancel Anytime',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// ✅ Table with 15 rows
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.yellow.shade700, width: 1.5),
                      outside: BorderSide(color: Colors.yellow.shade700, width: 1.5),
                    ),
                    children: [
                      _buildRow('1. Act/Rules', '2. GR/Circulars'),
                      _buildRow('3. E-Books', '4. Govt Policies'),
                      _buildRow('5. Govt. Schemes', '6. Annual Reports'),
                      _buildRow('7. Treasury Forms', '8. Citizen Charter'),
                      _buildRow('9. Right to Information', '10. Right to Services'),
                      _buildRow('11. Cabinet Decisions', '12. Government Calendar'),
                      _buildRow('13. Important Webs', '14. Govt. Mobile Apps'),
                      _buildRow('15. Important Contact Numbers',' And much More' ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
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
                            builder: (context) => const WelcomePage(),
                          ),
                        );
                      },
                      child: const Text(
                        '₹1 START TRIAL',
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
              left: BorderSide(color: Colors.yellow, width: 0), // prevent double borders
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
  const FeatureText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}


