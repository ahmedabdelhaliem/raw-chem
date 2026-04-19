import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/payment/model/payment_method_model.dart';

class PaymentRepo {
  final GenericDataSource _dataSource;

  PaymentRepo(this._dataSource);

  Future<Either<Failure, dynamic>> initFawaterkPayment({
    required int orderId,
    int paymentMethodId = 0,
  }) async {
    return await _dataSource.fetchResult<dynamic>(
      endpoint: "/supplier-materials/purchase-orders/$orderId/fawaterak/init",
      method: 'POST',
      data: {
        'payment_method_id': paymentMethodId,
      },
      fromJson: (json) => json,
    );
  }

}
