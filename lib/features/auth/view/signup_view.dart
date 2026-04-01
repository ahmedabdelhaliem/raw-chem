import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/auth/cubit/signup_cubit.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/model/register/register_request.dart';
import 'package:raw_chem/features/auth/model/register/register_response.dart';

import '../widgets/signup_header_widget.dart';
import '../widgets/signup_form_widget.dart';
import '../widgets/signup_footer_widget.dart';

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
  final TextEditingController _birthDateController = TextEditingController();
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
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<SignupCubit>(),
      child: BlocConsumer<SignupCubit, BaseState<RegisterResponse>>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pushReplacement(AppRouters.signupSuccessView);
          } else if (state.isError) {
            context.showErrorMessage(state.errorMessage ?? "Unknown error occurred");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorManager.textColor),
                onPressed: () => GoRouter.of(context).pop(),
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
                      const SignupHeaderWidget(),
                      SignupFormWidget(
                        nameController: _nameController,
                        companyController: _companyController,
                        fieldController: _fieldController,
                        phoneController: _phoneController,
                        emailController: _emailController,
                        birthDateController: _birthDateController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      SizedBox(height: 30.h),
                      // Signup Button
                      state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : DefaultButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().signup(
                                        RegisterRequest(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          phone: _phoneController.text,
                                          birthDate: _birthDateController.text,
                                          password: _passwordController.text,
                                          passwordConfirmation: _confirmPasswordController.text,
                                        ),
                                      );
                                }
                              },
                              text: AppStrings.signup.tr(),
                              color: ColorManager.primary,
                              textColor: ColorManager.white,
                              radius: 12.r,
                            ),
                      SizedBox(height: 20.h),
                      const SignupFooterWidget(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
