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
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/auth/model/register/register_request.dart';
import 'package:raw_chem/features/auth/model/register/register_response.dart';

import '../widgets/signup_footer_widget.dart';
import '../widgets/signup_form_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<int> _selectedCategoryIds = [];

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<SignupCubit>()),
        BlocProvider(create: (context) => instance<CategoriesCubit>()..fetchCategories()),
      ],
      child: BlocConsumer<SignupCubit, BaseState<RegisterResponse>>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pushReplacement(
              AppRouters.verifyOtpView,
              extra: {'phone': _phoneController.text},
            );
          } else if (state.isError) {
            if (state.failure is NetworkFailure) {
              context.showToast(
                text: AppStrings.noInternetError.tr(), 
                color: Colors.red
              );
            } else {
              context.showErrorMessage(state.errorMessage ?? "Unknown error occurred");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Premium Background (Consistent with Splash/Login)
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
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Navigation Row (Back Button + Centered Title + Small Logo)
                          Row(
                            children: [
                              // Circular Back Button
                              IconButton(
                                onPressed: () => GoRouter.of(context).pop(),
                                icon: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: ColorManager.primary,
                                    size: 18.sp,
                                  ),
                                ),
                              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),

                              const Spacer(),

                              // Centered Title (AppBar style)
                              Text(
                                AppStrings.signupTitle.tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.primary,
                                  letterSpacing: 1.1,
                                ),
                              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),

                              const Spacer(),

                              // Small Branded Logo (Top Right)
                              Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.primary.withValues(alpha: 0.05),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Image.asset(ImageAssets.logo, height: 40.h),
                              ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),
                            ],
                          ),

                          SizedBox(height: 25.h),

                          // Form Card (Elevated white card)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                                    SignupFormWidget(
                                      nameController: _nameController,
                                      companyController: _companyController,
                                      phoneController: _phoneController,
                                      emailController: _emailController,
                                      birthDateController: _birthDateController,
                                      passwordController: _passwordController,
                                      confirmPasswordController: _confirmPasswordController,
                                      selectedCategoryIds: _selectedCategoryIds,
                                      onCategoryChanged: (ids) {
                                        setState(() {
                                          _selectedCategoryIds = ids;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 15.h),
                                    // Signup Button
                                    DefaultButtonWidget(
                                      isLoading: state.isLoading,
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            if (_selectedCategoryIds.isEmpty) {
                                              context.showToast(
                                                text: AppStrings.pleaseSelectOneCategory.tr(),
                                                color: Colors.orange
                                              );
                                              return;
                                            }
                                            context.read<SignupCubit>().signup(
                                              RegisterRequest(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phone: _phoneController.text,
                                                birthDate: _birthDateController.text,
                                                password: _passwordController.text,
                                                passwordConfirmation: _confirmPasswordController.text,
                                                categoryIds: _selectedCategoryIds,
                                              ),
                                            );
                                          }
                                        },
                                      text: AppStrings.signup.tr(),
                                      color: ColorManager.primary,
                                      textColor: ColorManager.white,
                                      radius: 16.r,
                                    ),
                                  ],
                                ),
                              )
                              .animate()
                              .fadeIn(delay: 600.ms, duration: 800.ms)
                              .slideY(begin: 0.1, end: 0),

                          SizedBox(height: 15.h),

                          const SignupFooterWidget().animate().fadeIn(
                            delay: 1000.ms,
                            duration: 600.ms,
                          ),

                          SizedBox(height: 10.h),
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

  Widget _buildAnimatedOrb({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child:
          Container(
                width: size,
                height: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 6.seconds,
                curve: Curves.easeInOut,
              )
              .blur(begin: const Offset(40, 40), end: const Offset(60, 60)),
    );
  }
}
