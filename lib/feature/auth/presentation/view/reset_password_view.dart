import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorManager.textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppStrings.newPassword.tr(),
                  style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppStrings.resetPasswordSubtitle.tr(),
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                ),
                SizedBox(height: 50.h),
                DefaultFormField(
                  controller: _passwordController,
                  hintText: AppStrings.newPassword.tr(),
                  obscureText: true,
                  prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 20.h),
                DefaultFormField(
                  controller: _confirmPasswordController,
                  hintText: AppStrings.confirmPassword.tr(),
                  obscureText: true,
                  prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 16, color: ColorManager.primary),
                    SizedBox(width: 5.w),
                    Text(
                      AppStrings.passwordRequirements.tr(),
                      style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                DefaultButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRouters.successView);
                    }
                  },
                  text: AppStrings.reset.tr(),
                  color: ColorManager.primary,
                  textColor: ColorManager.white,
                  radius: 12.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
