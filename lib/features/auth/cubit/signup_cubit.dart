import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/state/base_state.dart';
import '../model/register/register_request.dart';
import '../model/register/register_response.dart';
import '../repo/auth_repo.dart';

class SignupCubit extends Cubit<BaseState<RegisterResponse>> {
  final AuthRepo _authRepo;

  SignupCubit(this._authRepo) : super(const BaseState<RegisterResponse>());

  Future<void> signup(RegisterRequest request) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _authRepo.register(request);
    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response)),
    );
  }
}
