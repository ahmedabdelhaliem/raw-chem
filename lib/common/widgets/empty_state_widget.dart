import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonTitle;
  final void Function()? onButtonPressed;
  final String? imagePath;

  const EmptyStateWidget({
    super.key,
    this.title,
    this.message,
    this.buttonTitle,
    this.onButtonPressed,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath ?? 'assets/images/empty_state.png',
              height: 200.h,
            ),
            SizedBox(height: 30.h),
            Text(
              title ?? AppStrings.noData.tr(),
              style: getBoldStyle(fontSize: 18.sp, color: ColorManager.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              message ?? '',
              style: getRegularStyle(fontSize: 14.sp, color: ColorManager.grey),
              textAlign: TextAlign.center,
            ),
            if (buttonTitle != null && onButtonPressed != null) ...[
              SizedBox(height: 30.h),
              DefaultButtonWidget(
                text: buttonTitle!,
                onPressed: onButtonPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
