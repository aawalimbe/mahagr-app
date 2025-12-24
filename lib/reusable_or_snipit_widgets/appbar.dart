import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/customs_notifictions.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/give_sugg.dart';
import 'package:forrest_department_gr_and_updatees_app/pages/share_doc.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const CustomAppBar({super.key, this.height = 70});

  @override
  Size get preferredSize => Size.fromHeight(height.h);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return AppBar(
          toolbarHeight: height.h,
          backgroundColor:
              isDark ? AppColors.darkSurfaceColor : AppColors.primaryColor,
          leadingWidth: 44.w,
          leading: Builder(
            builder:
                (context) => Center(
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _MenuLine(),
                          SizedBox(height: 5),
                          _MenuLine(),
                          SizedBox(height: 5),
                          _MenuLine(),
                        ],
                      ),
                    ),
                  ),
                ),
          ),

          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Image.asset(
                  //'assets/images/project_image/logo.png',
                  'assets/images/original/logo.png',
                  width: 50.w,
                  height: 50.h,
                ),
                SizedBox(width: 2.w),
                Baseline(
                  baseline: 34.h,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    "महा",
                    style: AppTextStyles.bold(34.sp).copyWith(
                      color:
                          isDark
                              ? AppColors.darkTextPrimaryColor
                              : AppColors.textOnDark,
                    ),
                  ),
                ),
                Baseline(
                  baseline: 34.h,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    "GR",
                    style: AppTextStyles.bold(34.sp).copyWith(
                      color:
                          isDark
                              ? AppColors.darkTextPrimaryColor
                              : AppColors.textOnDark,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Baseline(
                  baseline: 34.h,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    "Alert",
                    style: AppTextStyles.italic(14.sp).copyWith(
                      color:
                          isDark
                              ? AppColors.darkTextSecondaryColor
                              : AppColors.textOnLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () async {
                    final overlay =
                        Overlay.of(context).context.findRenderObject()
                            as RenderBox;

                    final selected = await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        overlay.size.width - 16.w,
                        kToolbarHeight + MediaQuery.of(context).padding.top,
                        16.w,
                        0,
                      ),
                      items: [
                        PopupMenuItem(
                          value: 'share_app',
                          child: ListTile(
                            leading: Icon(Icons.share, size: 20.sp),
                            title: Text(
                              'Share App',
                              style: AppTextStyles.medium(14.sp),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'customs_notification',
                          child: ListTile(
                            leading: Icon(
                              Icons.notifications_active,
                              size: 20.sp,
                            ),
                            title: Text(
                              'Manage Notification',
                              style: AppTextStyles.medium(14.sp),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'give_suggestions',
                          child: ListTile(
                            leading: Icon(Icons.feedback, size: 20.sp),
                            title: Text(
                              'Give Suggestions',
                              style: AppTextStyles.medium(14.sp),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'share_documents',
                          child: ListTile(
                            leading: Icon(Icons.upload_file, size: 20.sp),
                            title: Text(
                              'Upload Documents',
                              style: AppTextStyles.medium(14.sp),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'logout',
                          child: ListTile(
                            leading: Icon(Icons.logout_outlined, size: 20.sp),
                            title: Text(
                              'Logout',
                              style: AppTextStyles.medium(14.sp),
                            ),
                          ),
                        ),
                      ],
                    );

                    if (selected == null) return;

                    switch (selected) {
                      case 'customs_notification':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CustomsNotifictions(),
                          ),
                        );
                        break;
                      case 'give_suggestions':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GiveSuggestions(),
                          ),
                        );
                        break;
                      case 'share_documents':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ShareDocs()),
                        );
                        break;
                    }
                  },
                  child: Container(
                    width: 30.w,
                    height: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color:
                            isDark
                                ? AppColors.darkTextPrimaryColor
                                : AppColors.textOnDark,
                        width: 2,
                      ),
                    ),
                    child: Transform.translate(
                      offset: const Offset(-2, 0),
                      child: Icon(
                        Icons.more_vert,
                        size: 30.sp,
                        color:
                            isDark
                                ? AppColors.darkTextPrimaryColor
                                : AppColors.textOnDark,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],

          elevation: 0,
        );
      },
    );
  }
}

class _MenuLine extends StatelessWidget {
  const _MenuLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
