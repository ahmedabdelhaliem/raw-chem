import '../../../../app/app_prefs.dart';
import '../../../../core/state/base_state.dart';
import '../model/register/register_request.dart';
import '../model/register/register_response.dart';
import '../repo/auth_repo.dart';

class SignupCubit extends Cubit<BaseState<RegisterResponse>> {
  final AuthRepo _authRepo;
  final AppPreferences _appPrefs;

  SignupCubit(this._authRepo, this._appPrefs) : super(const BaseState<RegisterResponse>());

  Future<void> signup(RegisterRequest request) async {
    emit(state.copyWith(status: Status.loading));
    final fcmToken = _appPrefs.getFcmToken();
    final updatedRequest = request.copyWith(fcmToken: fcmToken);
    final result = await _authRepo.register(updatedRequest);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }
}
