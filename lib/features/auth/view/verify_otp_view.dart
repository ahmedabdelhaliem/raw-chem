import 'dart:async';

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
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/cubit/verify_otp_cubit.dart';
import 'package:raw_chem/features/auth/model/verify_otp/verify_otp_request.dart';
import 'package:raw_chem/features/auth/model/verify_otp/verify_otp_response.dart';
import 'package:raw_chem/features/auth/cubit/forgot_pwd_cubit.dart';
import 'package:raw_chem/features/auth/model/forgot_password/forgot_response.dart';

class VerifyOtpView extends StatefulWidget {
  final String phone;
  final bool isForgotPassword;
  final bool autoResend;
  const VerifyOtpView({
    super.key,
    required this.phone,
    this.isForgotPassword = false,
    this.autoResend = false,
  });

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  int _timerSeconds = 59;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    if (widget.autoResend) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.isForgotPassword) {
          context.read<ForgotPwdCubit>().resendOtpForgot(widget.phone);
        } else {
          context.read<VerifyOtpCubit>().resendOtp(widget.phone);
        }
      });
    }
  }

  void _startTimer() {
    setState(() {
      _timerSeconds = 59;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _timerSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isForgotPassword) {
      return BlocConsumer<ForgotPwdCubit, BaseState<ForgotResponse>>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pushReplacement(
              AppRouters.resetPasswordView,
              extra: {
                'phone': widget.phone,
                'token': _controllers.map((c) => c.text).join(),
              },
            );
          } else if (state.isError) {
            context.showErrorMessage(state.errorMessage ?? "Invalid OTP");
          }
          final cubit = context.read<ForgotPwdCubit>();
          if (cubit.resendStatus == ForgotResendStatus.success) {
            _startTimer();
            context.showSuccessMessage("OTP resent successfully!");
          } else if (cubit.resendStatus == ForgotResendStatus.error) {
            context.showErrorMessage(cubit.resendError ?? "Failed to resend OTP");
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgotPwdCubit>();
          return _buildScaffold(context, state.isLoading, cubit.resendStatus == ForgotResendStatus.loading, () {
            String token = _controllers.map((c) => c.text).join();
            if (token.length == 5) {
              context.read<ForgotPwdCubit>().verifyOtpForgot(widget.phone, token);
            } else {
              context.showErrorMessage("Please enter the full 5-digit code");
            }
          }, () {
            context.read<ForgotPwdCubit>().resendOtpForgot(widget.phone);
          });
        },
      );
    }

    return BlocConsumer<VerifyOtpCubit, BaseState<VerifyOtpResponse>>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacement(AppRouters.btmNav);
        } else if (state.isError) {
          context.showErrorMessage(state.errorMessage ?? "Invalid OTP");
        }
        // Check resend status
        final cubit = context.read<VerifyOtpCubit>();
        if (cubit.resendStatus == ResendStatus.success) {
          _startTimer(); // Reset timer on successful resend
          context.showSuccessMessage("OTP resent successfully!");
        } else if (cubit.resendStatus == ResendStatus.error) {
          context.showErrorMessage(cubit.resendError ?? "Failed to resend OTP");
        }
      },
      builder: (context, state) {
        final cubit = context.read<VerifyOtpCubit>();
        return _buildScaffold(context, state.isLoading, cubit.resendStatus == ResendStatus.loading, () {
          String token = _controllers.map((c) => c.text).join();
          if (token.length == 5) {
            context.read<VerifyOtpCubit>().verifyOtp(
                  VerifyOtpRequest(phone: widget.phone, token: token),
                );
          } else {
            context.showErrorMessage("Please enter the full 5-digit code");
          }
        }, () {
          context.read<VerifyOtpCubit>().resendOtp(widget.phone);
        });
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    bool isLoading,
    bool isResending,
    VoidCallback onVerify,
    VoidCallback onResend,
  ) {
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                AppStrings.verifyOTPTitle.tr(),
                style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                AppStrings.verifyOTPSubtitle.tr(),
                textAlign: TextAlign.center,
                style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              // Show phone number
              Text(
                widget.phone,
                style: getBoldStyle(color: ColorManager.primary, fontSize: 16.sp),
              ),
              SizedBox(height: 50.h),
              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: getBoldStyle(color: ColorManager.primary, fontSize: 20.sp),
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: ColorManager.greyBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: ColorManager.primary),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 4) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              // Verify Button
              DefaultButtonWidget(
                isLoading: isLoading,
                onPressed: onVerify,
                text: AppStrings.verify.tr(),
                color: ColorManager.primary,
                textColor: ColorManager.white,
                radius: 12.r,
              ),
              SizedBox(height: 30.h),
              // Resend section
              if (_canResend)
                isResending
                    ? const CircularProgressIndicator(color: ColorManager.primary)
                    : TextButton(
                        onPressed: onResend,
                        child: Text(
                          AppStrings.resendOTP.tr(),
                          style: getBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
                        ),
                      )
              else
                Column(
                  children: [
                    Text(
                      AppStrings.resendOTP.tr(),
                      style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "00:${_timerSeconds.toString().padLeft(2, '0')}",
                      style: getBoldStyle(color: ColorManager.textColor, fontSize: 16.sp),
                    ),
                  ],
                ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
