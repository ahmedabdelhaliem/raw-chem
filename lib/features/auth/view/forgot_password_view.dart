import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/cubit/forgot_pwd_cubit.dart';
import 'package:raw_chem/features/auth/model/forgot_password/forgot_response.dart';

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
    return BlocProvider(
      create: (context) => instance<ForgotPwdCubit>(),
      child: BlocConsumer<ForgotPwdCubit, BaseState<ForgotResponse>>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.push(
              AppRouters.verifyOtpView,
              extra: {
                'phone': _phoneController.text,
                'isForgotPassword': true,
              },
            );
          } else if (state.isError) {
            context.showErrorMessage(state.errorMessage ?? "Error sending OTP");
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
                onPressed: () => Navigator.of(context).pop(),
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
                        isLoading: state.isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgotPwdCubit>().forgotPassword(_phoneController.text);
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
        },
      ),
    );
  }
}
