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

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _fieldController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
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
                // Name Field
                DefaultFormField(
                  controller: _nameController,
                  hintText: AppStrings.name.tr(),
                  prefixWidget: const Icon(Icons.person_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 15.h),
                // Company Field
                DefaultFormField(
                  controller: _companyController,
                  hintText: AppStrings.companyName.tr(),
                  prefixWidget: const Icon(
                    Icons.business_outlined,
                    color: ColorManager.greyTextColor,
                  ),
                ),
                SizedBox(height: 15.h),
                // Field/Domain (Represented as a read-only field for simplicity, could be a dropdown)
                DefaultFormField(
                  controller: _fieldController,
                  hintText: AppStrings.field.tr(),
                  readOnly: true,
                  prefixWidget: const Icon(
                    Icons.grid_view_outlined,
                    color: ColorManager.greyTextColor,
                  ),
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorManager.greyTextColor,
                  ),
                  onTap: () {
                    // Logic for selecting domain
                  },
                ),
                SizedBox(height: 15.h),
                // Phone Field
                DefaultFormField(
                  controller: _phoneController,
                  hintText: AppStrings.phoneNumber.tr(),
                  keyboardType: TextInputType.phone,
                  prefixWidget: const Icon(Icons.phone_outlined, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 15.h),
                // Email Field
                DefaultFormField(
                  controller: _emailController,
                  hintText: AppStrings.email.tr(),
                  keyboardType: TextInputType.emailAddress,
                  prefixWidget: const Icon(Icons.email_outlined, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 15.h),
                // Password Field
                DefaultFormField(
                  controller: _passwordController,
                  hintText: AppStrings.password.tr(),
                  obscureText: true,
                  prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 15.h),
                // Confirm Password Field
                DefaultFormField(
                  controller: _confirmPasswordController,
                  hintText: AppStrings.confirmPassword.tr(),
                  obscureText: true,
                  prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
                ),
                SizedBox(height: 30.h),
                // Signup Button
                DefaultButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRouters.signupSuccessView);
                    }
                  },
                  text: AppStrings.signup.tr(),
                  color: ColorManager.primary,
                  textColor: ColorManager.white,
                  radius: 12.r,
                ),
                SizedBox(height: 20.h),
                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount.tr(),
                      style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        AppStrings.login.tr(),
                        style: getBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
