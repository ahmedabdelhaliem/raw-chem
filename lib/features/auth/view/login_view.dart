import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';
import 'package:raw_chem/features/auth/model/login/login_request.dart';
import 'package:raw_chem/features/auth/model/login/login_response.dart';

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
    return BlocProvider(
      create: (context) => instance<LoginCubit>(),
      child: BlocConsumer<LoginCubit, BaseState<LoginResponse>>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pushReplacement(AppRouters.btmNav);
          } else if (state.isUnverifiedAccount) {
            context.push(AppRouters.verifyOtpView, extra: {
              'phone': _phoneController.text,
              'isForgotPassword': false,
              'autoResend': true,
            });
          } else if (state.isError) {
            context.showErrorMessage(state.errorMessage ?? "Login failed");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Premium Background (Consistent with Splash/Onboarding)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          ColorManager.lightGreen.withValues(alpha: 0.2),
                          ColorManager.lightGreen.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),

                // Animated Orbs
                _buildAnimatedOrb(
                  top: -60.h,
                  left: -60.w,
                  color: ColorManager.primary.withValues(alpha: 0.05),
                  size: 200.w,
                ),
                _buildAnimatedOrb(
                  bottom: -100.h,
                  right: -100.w,
                  color: ColorManager.secondry.withValues(alpha: 0.1),
                  size: 280.w,
                ),

                // Content
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Back Button (Optional, but often useful or just a placeholder for premium spacing)
                          SizedBox(height: 20.h),

                          // Logo Housing
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.primary.withValues(alpha: 0.08),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(ImageAssets.logo, height: 105.h),
                            )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
                          ),

                          SizedBox(height: 40.h),

                          // Heading Section
                          Text(
                            AppStrings.loginTitle.tr(),
                            style: getBoldStyle(color: ColorManager.primary, fontSize: 28.sp),
                          ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),

                          SizedBox(height: 8.h),

                          Text(
                            AppStrings.loginSubtitle.tr(),
                            style: getMediumStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                          ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),

                          SizedBox(height: 40.h),

                          // Form Card (Glassmorphism feel or just clean white)
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Phone Field
                                DefaultFormField(
                                  controller: _phoneController,
                                  hintText: AppStrings.phoneNumber.tr(),
                                  keyboardType: TextInputType.phone,
                                  prefixWidget: Icon(Icons.phone_iphone_rounded, color: ColorManager.primary.withValues(alpha: 0.6), size: 20.sp),
                                ),
                                SizedBox(height: 20.h),
                                // Password Field
                                DefaultFormField(
                                  controller: _passwordController,
                                  hintText: AppStrings.password.tr(),
                                  obscureText: true,
                                  prefixWidget: Icon(Icons.lock_person_rounded, color: ColorManager.primary.withValues(alpha: 0.6), size: 20.sp),
                                ),
                                SizedBox(height: 12.h),
                                // Forgot Password link
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: TextButton(
                                    onPressed: () => context.push(AppRouters.forgotPasswordView),
                                    style: TextButton.styleFrom(
                                      foregroundColor: ColorManager.primary,
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      AppStrings.forgotPassword.tr(),
                                      style: getBoldStyle(color: ColorManager.primary, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 35.h),
                                // Login Button
                                DefaultButtonWidget(
                                  isLoading: state.isLoading,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().login(
                                            LoginRequest(
                                              phone: _phoneController.text,
                                              password: _passwordController.text,
                                            ),
                                          );
                                    }
                                  },
                                  text: AppStrings.login.tr(),
                                  color: ColorManager.primary,
                                  textColor: ColorManager.white,
                                  radius: 16.r,
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideY(begin: 0.1, end: 0),

                          SizedBox(height: 40.h),

                          // Sign up section
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccount.tr(),
                                  style: getMediumStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                                ),
                                TextButton(
                                  onPressed: () => context.push(AppRouters.signupView),
                                  child: Text(
                                    AppStrings.signup.tr(),
                                    style: getBoldStyle(color: ColorManager.primary, fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedOrb({double? top, double? bottom, double? left, double? right, required Color color, required double size}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 6.seconds, curve: Curves.easeInOut)
          .blur(begin: const Offset(40, 40), end: const Offset(60, 60)),
    );
  }
}
