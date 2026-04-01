import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'reset_password_request.freezed.dart';
part 'reset_password_request.g.dart';

@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  const factory ResetPasswordRequest({
    required String phone,
    required String token,
    required String password,
    @JsonKey(name: 'password_confirmation') required String passwordConfirmation,
  }) = _ResetPasswordRequest;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}

extension ResetPasswordRequestExtension on ResetPasswordRequest {
  Future<FormData> toFormData() async {
    return FormData.fromMap(toJson());
  }
}
