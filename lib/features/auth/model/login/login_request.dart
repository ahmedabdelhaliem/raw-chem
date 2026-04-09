import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const LoginRequest._();

  const factory LoginRequest({
    required String phone,
    required String password,
    String? fcmToken,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'phone': phone,
      'password': password,
      if (fcmToken != null) 'fcm_token': fcmToken,
    });
  }
}
