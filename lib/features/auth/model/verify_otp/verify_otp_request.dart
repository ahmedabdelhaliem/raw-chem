import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_request.freezed.dart';

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const VerifyOtpRequest._();

  const factory VerifyOtpRequest({
    required String phone,
    required String token,
  }) = _VerifyOtpRequest;

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "phone": phone,
      "token": token,
    });
  }
}
