import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsResponse with _$SettingsResponse {
  const factory SettingsResponse({
    required int code,
    required String message,
    required List<SettingsModel> data,
  }) = _SettingsResponse;

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingsResponseFromJson(json);
}

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    String? name,
    String? title,
    String? desc,
    String? address,
    String? metaKey,
    String? metaDesc,
    String? phone,
    String? whatsapp,
    String? email,
    String? support,
    String? facebook,
    String? xUrl,
    String? youtube,
    String? instagram,
    String? tiktok,
    String? linkedin,
    String? logo,
    String? favicon,
    String? copyright,
    String? promotion,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
