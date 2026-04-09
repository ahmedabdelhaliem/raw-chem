import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/app_prefs.dart';
import '../../../../core/state/base_state.dart';
import '../model/login/login_request.dart';
import '../model/login/login_response.dart';
import '../repo/auth_repo.dart';
import '../../../../common/http/failure.dart';

class LoginCubit extends Cubit<BaseState<LoginResponse>> {
  final AuthRepo _authRepo;
  final AppPreferences _appPrefs;

  LoginCubit(this._authRepo, this._appPrefs)
      : super(const BaseState<LoginResponse>());

  Future<void> login(LoginRequest request) async {
    emit(state.copyWith(status: Status.loading));
    final fcmToken = _appPrefs.getFcmToken();
    final updatedRequest = request.copyWith(fcmToken: fcmToken);
    final result = await _authRepo.login(updatedRequest);
    result.fold(
      (failure) {
        if (failure is ActiveAccountFailure) {
          emit(state.copyWith(
            status: Status.unverifiedAccount,
            errorMessage: failure.message,
          ));
        } else if (failure.message.contains("تم تسجيل الدخول بالفعل")) {
          // If already logged in, treat as success
          emit(state.copyWith(status: Status.success));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: failure.message));
        }
      },
      (response) async {
        // Save token if present
        final token = response.data?.token;
        if (token != null && token.isNotEmpty) {
          await _appPrefs.saveToken(token);
        }
        emit(state.copyWith(status: Status.success, data: response));
      },
    );
  }
}
