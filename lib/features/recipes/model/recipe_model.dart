import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/model/pagination_model.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeResponse with _$RecipeResponse {
  const factory RecipeResponse({
    required int code,
    required String message,
    required List<RecipeModel> data,
    PaginationModel? pagination,
  }) = _RecipeResponse;

  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);
}

@freezed
class RecipeDetailsResponse with _$RecipeDetailsResponse {
  const factory RecipeDetailsResponse({
    required int code,
    required String message,
    required RecipeModel data,
  }) = _RecipeDetailsResponse;

  factory RecipeDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsResponseFromJson(json);
}

@freezed
class RecipeModel with _$RecipeModel {
  const factory RecipeModel({
    required int id,
    String? order,
    String? name,
    String? description,
    String? ingredients,
    String? measurements,
    @JsonKey(name: 'preparation_instructions') String? preparationInstructions,
    String? image,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
}
