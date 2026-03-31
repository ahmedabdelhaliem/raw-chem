import 'package:dio/dio.dart';
import 'package:raw_chem/common/http/either.dart';
import '../error/failure.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Either<Failure, Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
