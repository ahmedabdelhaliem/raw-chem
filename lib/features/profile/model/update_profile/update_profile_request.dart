import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const UpdateProfileRequest._();

  const factory UpdateProfileRequest({
    required String name,
    required String email,
    required String phone,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'category_id') required int categoryId,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'company_name': companyName,
      'category_id': categoryId,
    });
  }
}
