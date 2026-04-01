import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'verify_otp_forgot_request.freezed.dart';
part 'verify_otp_forgot_request.g.dart';

@freezed
class VerifyOtpForgotRequest with _$VerifyOtpForgotRequest {
  const factory VerifyOtpForgotRequest({
    required String phone,
    required String token,
  }) = _VerifyOtpForgotRequest;

  factory VerifyOtpForgotRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpForgotRequestFromJson(json);
}

extension VerifyOtpForgotRequestExtension on VerifyOtpForgotRequest {
  Future<FormData> toFormData() async {
    return FormData.fromMap(toJson());
  }
}
