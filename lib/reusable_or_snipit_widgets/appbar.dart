import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/deptselection_page.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/help_us.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const CustomAppBar({Key? key, this.height = 70}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height.h,
      backgroundColor: AppColors.primaryColor,
      leadingWidth: 35,
      leading: Builder(
        builder:
            (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, size: 40, color: Colors.white),
            ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Image.asset(
            'assets/images/project_image/logo.png',
            width: 50.w,
            height: 50.h,
          ),
          SizedBox(width: 2),
          Baseline(
            baseline: 34,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "महा",
              style: AppTextStyles.bold(34).copyWith(
                color: Colors.white,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          Baseline(
            baseline: 34,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "GR",
              style: AppTextStyles.bold(34).copyWith(
                color: Colors.white,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          SizedBox(width: 6),
          Baseline(
            baseline: 34,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "Alert",
              style: AppTextStyles.italic(14).copyWith(
                color: Colors.black, //AppColors.dprimaryColor,
                fontWeight: FontWeight.w600,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, size: 32, color: Colors.white),
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          padding: EdgeInsets.zero,
          onPressed: () async {
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final double right = 16.0;
            final double top =
                kToolbarHeight + MediaQuery.of(context).padding.top;
            final selected = await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                overlay.size.width - right,
                top,
                right,
                overlay.size.height - top,
              ),
              items: [
                PopupMenuItem(
                  value: 'share_app',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share App', style: AppTextStyles.medium(20)),
                  ),
                ),
                PopupMenuItem(
                  value: 'customs_notification',
                  child: ListTile(
                    leading: Icon(Icons.notifications_active),
                    title: Text(
                      'Customs Notification',
                      style: AppTextStyles.medium(20),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'give_suggestions',
                  child: ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text(
                      'Give Suggestions',
                      style: AppTextStyles.medium(20),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'share_documents',
                  child: ListTile(
                    leading: Icon(Icons.upload_file),
                    title: Text(
                      'Share Documents',
                      style: AppTextStyles.medium(20),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'help_us',
                  child: ListTile(
                    leading: Icon(Icons.volunteer_activism),
                    title: Text('Help', style: AppTextStyles.medium(20)),
                  ),
                ),
                PopupMenuItem(
                  value: 'rate_us',
                  child: ListTile(
                    leading: Icon(Icons.star_rate),
                    title: Text('Rate Us', style: AppTextStyles.medium(20)),
                  ),
                ),
              ],
            );
            if (selected != null) {
              // TODO: Handle menu selection
              if (selected == 'share_app') {
                // Handle Customs Notification
              } else if (selected == 'customs_notification') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DepartmentSelectionPage(),
                  ),
                );
              } else if (selected == 'give_suggestions') {
                // Handle Give Suggestions
              } else if (selected == 'share_documents') {
                // Handle Rate Us
              } else if (selected == 'help_us') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpUsPage()),
                );
              } else if (selected == 'rate_us') {
                //Handle share app
              }
            }
          },
        ),
      ],
      //backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    );
  }
}
