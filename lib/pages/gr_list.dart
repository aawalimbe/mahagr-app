import 'package:flutter/material.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';

class GrList extends StatefulWidget {
  const GrList({super.key});

  @override
  State<GrList> createState() => _GrListState();
}

class _GrListState extends State<GrList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Department Name',
                style: AppTextStyles.bold(
                  23,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 16),
              /*Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Sr. No.')),
                      DataColumn(label: Text('Particulars')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Files')),
                    ],
                    rows: List.generate(5, generator),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
