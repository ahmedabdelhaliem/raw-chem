import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_response.freezed.dart';
part 'forgot_response.g.dart';

/// Generic response for all forgot password endpoints
@freezed
class ForgotResponse with _$ForgotResponse {
  const factory ForgotResponse({
    required int code,
    required String message,
    dynamic data,
  }) = _ForgotResponse;

  factory ForgotResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotResponseFromJson(json);
}
