import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_request.freezed.dart';

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const VerifyOtpRequest._();

  const factory VerifyOtpRequest({
    required String phone,
    required String token,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _VerifyOtpRequest;

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "phone": phone,
      "token": token,
      if (fcmToken != null) "fcm_token": fcmToken,
    });
  }
}
