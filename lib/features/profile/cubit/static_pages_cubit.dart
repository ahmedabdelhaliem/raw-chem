import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';
import 'package:raw_chem/features/profile/model/static_page/static_page_model.dart';

class StaticPagesCubit extends Cubit<BaseState<StaticPageData>> {
  final AuthRepo _authRepo;

  StaticPagesCubit(this._authRepo) : super(const BaseState());

  Future<void> getTerms() async {
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.getTerms();

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: Status.success,
        data: response.data,
      )),
    );
  }

  Future<void> getAboutUs() async {
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.getAboutUs();

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: Status.success,
        data: response.data,
      )),
    );
  }
}
