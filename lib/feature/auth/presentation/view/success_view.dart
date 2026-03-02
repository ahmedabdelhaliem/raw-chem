import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Checkmark Circle
              Container(
                width: 100.w,
                height: 100.w,
                decoration: const BoxDecoration(
                  color: ColorManager.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: ColorManager.white, size: 60),
              ),
              SizedBox(height: 40.h),
              Text(
                "تم تغيير كلمة المرور!",
                style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 16.sp),
                ),
              ),
              const Spacer(),
              DefaultButtonWidget(
                onPressed: () {
                  context.go(AppRouters.loginView);
                },
                text: "العودة لتسجيل الدخول",
                color: ColorManager.primary,
                textColor: ColorManager.white,
                radius: 12.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
