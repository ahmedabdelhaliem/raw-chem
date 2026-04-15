import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/payment/repo/payment_repo.dart';

class ConfirmPaymentCubit extends Cubit<BaseState<dynamic>> {
  final PaymentRepo _repo;

  ConfirmPaymentCubit(this._repo) : super(const BaseState<dynamic>());

  Future<void> confirmPayment({
    required int orderId,
    required int paymentMethodId,
  }) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _repo.initFawaterkPayment(
      orderId: orderId,
      paymentMethodId: paymentMethodId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: Status.success,
        data: response,
      )),
    );
  }
}
