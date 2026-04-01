import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/resources/color_manager.dart';
import '../../../../common/resources/strings_manager.dart';
import '../../../../common/resources/styles_manager.dart';

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount.tr(),
          style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            AppStrings.login.tr(),
            style: getBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
