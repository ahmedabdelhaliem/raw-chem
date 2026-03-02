import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActionSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final Widget? icon;

  const CustomActionSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.confirmColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          if (icon != null) ...[
            icon!.animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            SizedBox(height: 16.h),
          ],

          Text(
            title,
            textAlign: TextAlign.center,
            style: getBoldStyle(fontSize: 20.sp, color: ColorManager.black),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

          SizedBox(height: 12.h),

          Text(
            message,
            textAlign: TextAlign.center,
            style: getRegularStyle(fontSize: 14.sp, color: Colors.grey[600]!),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

          SizedBox(height: 32.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    cancelText,
                    style: getMediumStyle(fontSize: 15.sp, color: Colors.grey[700]!),
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
              SizedBox(width: 16.w),
              Expanded(
                child: DefaultButtonWidget(
                  text: confirmText,
                  color: confirmColor ?? ColorManager.primary,
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
    Color? confirmColor,
    Widget? icon,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CustomActionSheet(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        confirmColor: confirmColor,
        icon: icon,
      ),
    );
  }
}
