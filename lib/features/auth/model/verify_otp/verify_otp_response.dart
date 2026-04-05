import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raw_chem/features/categories/model/category_model.dart';

part 'verify_otp_response.freezed.dart';
part 'verify_otp_response.g.dart';

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
  const factory VerifyOtpResponse({
    required int code,
    required String message,
    VerifyOtpData? data,
  }) = _VerifyOtpResponse;

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
}

@freezed
class VerifyOtpData with _$VerifyOtpData {
  const factory VerifyOtpData({
    VerifyOtpUser? user,
    String? token,
  }) = _VerifyOtpData;

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);
}

@freezed
class VerifyOtpUser with _$VerifyOtpUser {
  const factory VerifyOtpUser({
    int? id,
    String? name,
    @JsonKey(name: 'company_name') String? companyName,
    String? email,
    String? phone,
    CategoryModel? category,
    int? status,
  }) = _VerifyOtpUser;

  factory VerifyOtpUser.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpUserFromJson(json);
}
