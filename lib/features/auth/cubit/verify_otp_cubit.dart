import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/app_prefs.dart';
import '../../../../core/state/base_state.dart';
import '../model/verify_otp/verify_otp_request.dart';
import '../model/verify_otp/verify_otp_response.dart';
import '../repo/auth_repo.dart';

// Separate state for resend OTP to track its individual loading/success/error
enum ResendStatus { idle, loading, success, error }

class VerifyOtpCubit extends Cubit<BaseState<VerifyOtpResponse>> {
  final AuthRepo _authRepo;
  final AppPreferences _appPrefs;

  ResendStatus resendStatus = ResendStatus.idle;
  String? resendError;

  VerifyOtpCubit(this._authRepo, this._appPrefs)
      : super(const BaseState<VerifyOtpResponse>());

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(status: Status.loading));
    final fcmToken = _appPrefs.getFcmToken();
    final updatedRequest = request.copyWith(fcmToken: fcmToken);
    final result = await _authRepo.verifyOtp(updatedRequest);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) async {
        // Save token if present
        final token = response.data?.token;
        if (token != null && token.isNotEmpty) {
          await _appPrefs.saveToken(token);
        }
        
        final userId = response.data?.user?.id;
        if (userId != null) {
          await _appPrefs.setUserId(userId.toString());
        }
        
        emit(state.copyWith(status: Status.success, data: response));
      },
    );
  }

  Future<void> resendOtp(String phone) async {
    resendStatus = ResendStatus.loading;
    resendError = null;
    emit(state.copyWith()); // trigger rebuild

    final result = await _authRepo.resendOtp(phone);
    result.fold(
      (failure) {
        resendStatus = ResendStatus.error;
        resendError = failure.message;
        emit(state.copyWith());
      },
      (_) {
        resendStatus = ResendStatus.success;
        emit(state.copyWith());
      },
    );
  }
}
