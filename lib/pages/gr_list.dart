import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_config.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:http/http.dart' as http;
import '../reusable_or_snipit_widgets/api_list.dart';
import 'img_viewer.dart';
import 'pdf_viewer.dart';

class GrList extends StatefulWidget {
  final int subjectId;
  final int categoryId;
  final int subCategoryId;
  final String subCategoryName;

  const GrList({
    super.key,
    required this.subjectId,
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  @override
  State<GrList> createState() => _GrListState();
}

class _GrListState extends State<GrList> {
  List document = [];
  bool loading = true;

  late String subCategoryName;

  @override
  void initState() {
    super.initState();
    subCategoryName = widget.subCategoryName;
    loadGRs();
  }

  Future<void> loadGRs() async {
    try {
      final res = await http.post(
        Uri.parse(ApiList.FetchGR),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "subject_id": widget.subjectId,
          "category_id": widget.categoryId,
          "sub_category_id": widget.subCategoryId,
          "status": "Active",
        }),
      );

      final data = jsonDecode(res.body);

      if (data["status"] == "success") {
        document = data["gr_list"] ?? [];
      } else {
        document = [];
      }
    } catch (e) {
      document = [];
    }

    setState(() => loading = false);
  }

  bool isPdf(String link) => link.toLowerCase().contains(".pdf");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(subCategoryName, style: AppTextStyles.bold(15.sp)),
              ),
              SizedBox(height: 4.h),

              Expanded(
                child:
                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : document.isEmpty
                        ? const Center(child: Text("No GRs found"))
                        : Column(
                          children: [
                            // FIXED HEADER
                            Table(
                              border: TableBorder.all(
                                color: AppColors.secondaryColor,
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(.5),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(.85),
                                3: FlexColumnWidth(.8),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  ),
                                  children: [
                                    headerCell("Sr"),
                                    headerCell("Title"),
                                    headerCell("Date"),
                                    headerCell("View"),
                                  ],
                                ),
                              ],
                            ),

                            // SCROLLABLE ROWS
                            Expanded(
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(
                                    color: AppColors.secondaryColor,
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(.5),
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(.85),
                                    3: FlexColumnWidth(.8),
                                  },
                                  children: List.generate(document.length, (i) {
                                    final d = document[i];
                                    final link = d["gr_link"] ?? "";

                                    return TableRow(
                                      children: [
                                        cell("${i + 1}"),
                                        cell(d["gr_name"] ?? ""),
                                        cell(d["date"] ?? ""),

                                        Padding(
                                          padding: EdgeInsets.all(4.r),
                                          child: IconButton(
                                            icon: Icon(
                                              isPdf(link)
                                                  ? Icons.picture_as_pdf
                                                  : Icons.image,
                                              color:
                                                  isPdf(link)
                                                      ? AppColors.compulsory
                                                      : AppColors.vibrantgreen,
                                            ),
                                            onPressed: () {
                                              final pdfUrl =
                                                  (d["file_upload_location"]
                                                              ?.toString()
                                                              .trim()
                                                              .isNotEmpty ==
                                                          true)
                                                      ? AppConfig.baseUrl +
                                                          d["file_upload_location"]
                                                      : d["gr_link"];

                                              final title = d["gr_name"] ?? "";

                                              if (isPdf(pdfUrl)) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) => PdfViewer(
                                                          pdfUrl: pdfUrl,
                                                          documentTitle: title,
                                                        ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) => ImageViewer(
                                                          imageUrl: pdfUrl,
                                                          documentTitle: title,
                                                        ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerCell(String text) => Padding(
    padding: EdgeInsets.all(8.r),
    child: Text(
      text,
      style: AppTextStyles.bold(12.sp),
      textAlign: TextAlign.center,
    ),
  );

  Widget cell(String text) => Padding(
    padding: EdgeInsets.all(8.r),
    child: Text(text, style: AppTextStyles.regular(11.sp)),
  );
}
