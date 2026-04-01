import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/auth/repo/auth_repo.dart';
import 'package:raw_chem/features/profile/model/faq/faq_model.dart';

class FaqCubit extends Cubit<BaseState<List<FaqModel>>> {
  final AuthRepo _authRepo;

  FaqCubit(this._authRepo) : super(const BaseState<List<FaqModel>>());

  Future<void> getFaqs() async {
    emit(state.copyWith(status: Status.loading));

    final result = await _authRepo.getFaqs();

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
