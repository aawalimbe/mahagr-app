import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/app_text.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/colors.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/custom_scaffold.dart';
import 'package:forrest_department_gr_and_updatees_app/reusable_or_snipit_widgets/api_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  String? error;
  String? selectedUserId; // For future use when user authentication is implemented

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final List<Map<String, dynamic>> apiNotifications = 
          await ApiService.getNotifications(userId: selectedUserId);

      setState(() {
        notifications = apiNotifications;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading notifications: $e');
      setState(() {
        error = 'Failed to load notifications: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Notifications', style: AppTextStyles.bold(24.sp)),
                  if (!isLoading && error == null)
                    IconButton(
                      onPressed: loadNotifications,
                      icon: Icon(Icons.refresh, color: AppColors.primaryColor),
                      tooltip: 'Refresh notifications',
                    ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: _buildNotificationsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: AppColors.compulsory,
            ),
            SizedBox(height: 16.h),
            Text(
              error!,
              style: AppTextStyles.medium(16.sp).copyWith(color: AppColors.compulsory),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: loadNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64.sp,
              color: AppColors.border,
            ),
            SizedBox(height: 16.h),
            Text(
              'No notifications found',
              style: AppTextStyles.medium(16.sp).copyWith(color: AppColors.border),
            ),
            SizedBox(height: 8.h),
            Text(
              'You\'re all caught up!',
              style: AppTextStyles.regular(14.sp).copyWith(color: AppColors.border),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final notificationId = notification['notification_id']?.toString() ?? '';
        final title = notification['title'] ?? 'No Title';
        final message = notification['message'] ?? 'No message';
        final scheduledAt = notification['scheduled_at'] ?? '';
        final sentAt = notification['sent_at'] ?? '';
        final status = notification['status'] ?? '';
        final timestamp = notification['timestamp'] ?? '';
        final relatedDocumentId = notification['related_document_id']?.toString();

        return Card(
          margin: EdgeInsets.only(bottom: 12.h),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.bold(16.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: status == 'sent' ? AppColors.vibrantgreen : AppColors.orange,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: AppTextStyles.regular(10.sp).copyWith(
                          color: AppColors.textOnDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  message,
                  style: AppTextStyles.regular(14.sp),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (scheduledAt.isNotEmpty) ...[
                      Icon(Icons.schedule, size: 14.sp, color: AppColors.border),
                      SizedBox(width: 4.w),
                      Text(
                        'Scheduled: $scheduledAt',
                        style: AppTextStyles.regular(12.sp).copyWith(color: AppColors.border),
                      ),
                      SizedBox(width: 16.w),
                    ],
                    if (sentAt.isNotEmpty) ...[
                      Icon(Icons.send, size: 14.sp, color: AppColors.border),
                      SizedBox(width: 4.w),
                      Text(
                        'Sent: $sentAt',
                        style: AppTextStyles.regular(12.sp).copyWith(color: AppColors.border),
                      ),
                    ],
                  ],
                ),
                if (relatedDocumentId != null && relatedDocumentId.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Icons.link, size: 14.sp, color: AppColors.primaryColor),
                      SizedBox(width: 4.w),
                      Text(
                        'Related Document ID: $relatedDocumentId',
                        style: AppTextStyles.regular(12.sp).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: Navigate to document viewer when document viewing is implemented
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Document viewing feature coming soon!'),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          );
                        },
                        child: Text(
                          'View Document',
                          style: AppTextStyles.medium(12.sp).copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
