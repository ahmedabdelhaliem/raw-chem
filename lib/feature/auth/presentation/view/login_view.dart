import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(ImageAssets.logo, height: 120.h),
                SizedBox(height: 30.h),
                // Heading
                Text(
                  "هيا نسجل الدخول!",
                  style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
                ),
                SizedBox(height: 10.h),
                // Subtitle
                Text(
                  "تسجيل الدخول إلى حسابك لمتابعة شراء منتجاتك.",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                ),
                SizedBox(height: 40.h),
                // Phone Field
                DefaultFormField(
                  controller: _phoneController,
                  hintText: "رقم الهاتف",
                  keyboardType: TextInputType.phone,
                  prefixWidget: const Icon(Icons.phone_outlined, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 20.h),
                // Password Field
                DefaultFormField(
                  controller: _passwordController,
                  hintText: "كلمة المرور",
                  obscureText: true,
                  prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 10.h),
                // Forgot Password link
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      context.push(AppRouters.forgotPasswordView);
                    },
                    child: Text(
                      "هل نسيت كلمة السر؟",
                      style: getMediumStyle(color: ColorManager.primary, fontSize: 13.sp),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                // Login Button
                DefaultButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform login
                    }
                  },
                  text: AppStrings.login.tr(),
                  color: ColorManager.primary,
                  textColor: ColorManager.white,
                  radius: 12.r,
                ),
                SizedBox(height: 20.h),
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ليس لديك حساب ؟",
                      style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(AppRouters.signupView);
                      },
                      child: Text(
                        "إنشاء حساب",
                        style: getBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
