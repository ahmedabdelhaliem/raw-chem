import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/state/base_state.dart';
import '../model/forgot_password/forgot_password_request.dart';
import '../model/forgot_password/forgot_response.dart';
import '../model/forgot_password/verify_otp_forgot_request.dart';
import '../model/forgot_password/reset_password_request.dart';
import '../repo/auth_repo.dart';

// Reuse ResendStatus from verify_otp_cubit
enum ForgotResendStatus { idle, loading, success, error }

class ForgotPwdCubit extends Cubit<BaseState<ForgotResponse>> {
  final AuthRepo _authRepo;

  ForgotResendStatus resendStatus = ForgotResendStatus.idle;
  String? resendError;

  ForgotPwdCubit(this._authRepo) : super(const BaseState<ForgotResponse>());

  Future<void> forgotPassword(String phone) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _authRepo.forgotPassword(ForgotPasswordRequest(phone: phone));
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }

  Future<void> verifyOtpForgot(String phone, String token) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _authRepo.verifyOtpForgot(
      VerifyOtpForgotRequest(phone: phone, token: token),
    );
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }

  Future<void> resendOtpForgot(String phone) async {
    resendStatus = ForgotResendStatus.loading;
    resendError = null;
    emit(state.copyWith()); // trigger rebuild

    final result = await _authRepo.resendOtpForgot(phone);
    result.fold(
      (failure) {
        resendStatus = ForgotResendStatus.error;
        resendError = failure.message;
        emit(state.copyWith());
      },
      (_) {
        resendStatus = ForgotResendStatus.success;
        emit(state.copyWith());
      },
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _authRepo.resetPassword(request);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }

  void reset() {
    emit(const BaseState<ForgotResponse>());
    resendStatus = ForgotResendStatus.idle;
    resendError = null;
  }
}
