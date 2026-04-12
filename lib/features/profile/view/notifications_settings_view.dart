import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class NotificationsSettingsView extends StatefulWidget {
  const NotificationsSettingsView({super.key});

  @override
  State<NotificationsSettingsView> createState() => _NotificationsSettingsViewState();
}

class DummyNotification {
  final String title;
  final String body;
  final String time;
  final bool isRead;

  DummyNotification({
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
  });
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  final List<DummyNotification> _notifications = [
    DummyNotification(
      title: "New Offer Available!",
      body: "Up to 30% discount on raw materials has been added.",
      time: "2 hours ago",
      isRead: false,
    ),
    DummyNotification(
      title: "Order Update #12345",
      body: "Your order has been shipped successfully.",
      time: "5 hours ago",
      isRead: true,
    ),
    DummyNotification(
      title: "Price Alert",
      body: "There are price changes in tracked products.",
      time: "2 days ago",
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.notifications.tr(),
          style: TextStyle(
            color: ColorManager.blackText,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.blackText),
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Text(
                AppStrings.noItemsToDisplay.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorManager.greyTextColor,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
    );
  }

  Widget _buildNotificationCard(DummyNotification notification) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: notification.isRead ? ColorManager.white : const Color(0xFFF0F9F5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: notification.isRead ? Colors.transparent : ColorManager.primary.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: notification.isRead ? ColorManager.bg : ColorManager.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: notification.isRead ? ColorManager.primary : ColorManager.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.blackText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: ColorManager.greyTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  notification.body,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorManager.greyTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
