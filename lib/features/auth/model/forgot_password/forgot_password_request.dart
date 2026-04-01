import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'forgot_password_request.freezed.dart';
part 'forgot_password_request.g.dart';

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({
    required String phone,
  }) = _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

extension ForgotPasswordRequestExtension on ForgotPasswordRequest {
  Future<FormData> toFormData() async {
    return FormData.fromMap(toJson());
  }
}
