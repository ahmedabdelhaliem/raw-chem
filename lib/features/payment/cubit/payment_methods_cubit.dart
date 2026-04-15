import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/payment/model/payment_method_model.dart';
import 'package:raw_chem/features/payment/repo/payment_repo.dart';

class PaymentMethodsCubit extends Cubit<BaseState<List<PaymentMethodModel>>> {
  final PaymentRepo _repo;

  PaymentMethodsCubit(this._repo) : super(const BaseState<List<PaymentMethodModel>>());

  Future<void> fetchPaymentMethods() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _repo.getPaymentMethods();

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (methods) => emit(state.copyWith(
        status: Status.success,
        data: methods,
      )),
    );
  }
}
