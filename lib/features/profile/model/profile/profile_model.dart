import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raw_chem/features/categories/model/category_model.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    required int code,
    required String message,
    ProfileUser? data,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}

@freezed
class ProfileUser with _$ProfileUser {
  const factory ProfileUser({
    int? id,
    String? name,
    String? image,
    @JsonKey(name: 'company_name') String? companyName,
    String? email,
    String? phone,
    CategoryModel? category,
    List<CategoryModel>? categories,
    @JsonKey(name: 'category_id') dynamic categoryId,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    int? status,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ProfileUser;

  factory ProfileUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserFromJson(json);
}
