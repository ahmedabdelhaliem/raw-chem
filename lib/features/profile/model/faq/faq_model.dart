import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_model.freezed.dart';
part 'faq_model.g.dart';

@freezed
class FaqResponse with _$FaqResponse {
  const factory FaqResponse({
    required int code,
    required String message,
    required List<FaqModel> data,
    Map<String, dynamic>? pagination,
  }) = _FaqResponse;

  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);
}

@freezed
class FaqModel with _$FaqModel {
  const factory FaqModel({
    required String question,
    required String answer,
  }) = _FaqModel;

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);
}
