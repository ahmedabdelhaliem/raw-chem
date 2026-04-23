import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';
import 'package:raw_chem/features/profile/model/settings/settings_model.dart';

class SettingsCubit extends Cubit<BaseState<SettingsModel>> {
  final AuthRepo _authRepo;

  SettingsCubit(this._authRepo) : super(const BaseState());

  Future<void> getSettings() async {
    if (state.data != null) return; // Only fetch if not already available
    
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.getSettings();

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
        failure: failure,
      )),
      (response) {
        if (response.data.isNotEmpty) {
          emit(state.copyWith(
            status: Status.success,
            data: response.data.first,
          ));
        } else {
          emit(state.copyWith(
            status: Status.error,
            errorMessage: "No settings found",
          ));
        }
      },
    );
  }
}
