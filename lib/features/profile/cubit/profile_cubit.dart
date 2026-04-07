import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';

import 'package:raw_chem/features/profile/model/profile/profile_model.dart';
import 'package:raw_chem/features/profile/model/update_profile/update_profile_request.dart';


class ProfileCubit extends Cubit<BaseState<ProfileUser>> {
  final AuthRepo _authRepo;
  final AppPreferences _appPreferences;

  ProfileCubit(this._authRepo, this._appPreferences) : super(const BaseState());

  Future<void> getProfile() async {
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.getProfile();

    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: Status.success, data: response.data)),
    );
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.updateProfile(request);

    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) async {
        // First emit with the partial data if needed, but we'll wait for the full profile
        // logic: update is done, now we need to refresh to get full category object
        final refreshResult = await _authRepo.getProfile();
        
        refreshResult.fold(
          (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
          (profileResponse) => emit(state.copyWith(status: Status.success, data: profileResponse.data)),
        );
      },
    );
  }

  Future<void> logout() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.logout();

    // Clear local data either way to ensure user is logged out on the device
    await _appPreferences.logout();

    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (_) => emit(const BaseState(status: Status.success)),
    );
  }
}
