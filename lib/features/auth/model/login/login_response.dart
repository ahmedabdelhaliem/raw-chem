import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raw_chem/features/auth/model/verify_otp/verify_otp_response.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required int code,
    required String message,
    VerifyOtpData? data,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
