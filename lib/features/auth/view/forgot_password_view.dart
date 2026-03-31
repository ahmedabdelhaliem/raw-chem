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

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
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
                // Heading
                Text(
                  AppStrings.forgotPasswordTitle.tr(),
                  style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                // Subtitle
                Text(
                  AppStrings.forgotPasswordSubtitle.tr(),
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                ),
                SizedBox(height: 50.h),
                // Phone Field
                DefaultFormField(
                  controller: _phoneController,
                  hintText: AppStrings.phoneNumber.tr(),
                  keyboardType: TextInputType.phone,
                  prefixWidget: const Icon(Icons.phone_outlined, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 40.h),
                // Send Button
                DefaultButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRouters.verifyOtpView);
                    }
                  },
                  text: AppStrings.sendOTP.tr(),
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
