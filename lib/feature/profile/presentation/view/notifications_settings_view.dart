import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class NotificationsSettingsView extends StatefulWidget {
  const NotificationsSettingsView({super.key});

  @override
  State<NotificationsSettingsView> createState() => _NotificationsSettingsViewState();
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  bool _soundEnabled = true;
  bool _generalNotificationsEnabled = true;
  bool _appUpdatesEnabled = true;

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              _buildSwitchRow(
                title: AppStrings.sound.tr(),
                value: _soundEnabled,
                onChanged: (val) => setState(() => _soundEnabled = val),
              ),
              Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
              _buildSwitchRow(
                title: AppStrings.generalNotifications.tr(),
                value: _generalNotificationsEnabled,
                onChanged: (val) => setState(() => _generalNotificationsEnabled = val),
              ),
              Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
              _buildSwitchRow(
                title: AppStrings.appUpdates.tr(),
                value: _appUpdatesEnabled,
                onChanged: (val) => setState(() => _appUpdatesEnabled = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.blackText,
              fontWeight: FontWeight.w500,
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeColor: ColorManager.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
