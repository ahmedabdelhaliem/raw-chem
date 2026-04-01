import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import '../model/register/register_request.dart';
import '../model/register/register_response.dart';

class AuthRepo {
  final ApiConsumer _apiConsumer;

  AuthRepo(this._apiConsumer);

  Future<Either<Failure, RegisterResponse>> register(RegisterRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.register,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(RegisterResponse.fromJson(data)),
    );
  }
}
