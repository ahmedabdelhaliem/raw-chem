import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/resources/assets_manager.dart';
import '../../../../common/resources/color_manager.dart';
import '../../../../common/resources/strings_manager.dart';
import '../../../../common/resources/styles_manager.dart';

class SignupHeaderWidget extends StatelessWidget {
  const SignupHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        Image.asset(ImageAssets.logo, height: 100.h),
        SizedBox(height: 20.h),
        // Heading
        Text(
          AppStrings.signupTitle.tr(),
          style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
        ),
        SizedBox(height: 5.h),
        // Subtitle
        Text(
          AppStrings.signupSubtitle.tr(),
          style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
