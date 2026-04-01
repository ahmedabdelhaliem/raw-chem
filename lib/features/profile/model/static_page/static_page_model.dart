import 'package:freezed_annotation/freezed_annotation.dart';

part 'static_page_model.freezed.dart';
part 'static_page_model.g.dart';

@freezed
class StaticPageResponse with _$StaticPageResponse {
  const factory StaticPageResponse({
    required int code,
    required String message,
    StaticPageData? data,
  }) = _StaticPageResponse;

  factory StaticPageResponse.fromJson(Map<String, dynamic> json) =>
      _$StaticPageResponseFromJson(json);
}

@freezed
class StaticPageData with _$StaticPageData {
  const factory StaticPageData({
    String? banner,
    String? title,
    String? description,
    String? image,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _StaticPageData;

  factory StaticPageData.fromJson(Map<String, dynamic> json) =>
      _$StaticPageDataFromJson(json);
}
