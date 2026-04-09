import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

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
    @JsonKey(name: 'category_ids') required List<int> categoryIds,
    @JsonKey(includeFromJson: false, includeToJson: false) XFile? image,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'company_name': companyName,
      'category_ids[]': categoryIds,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
    });
  }
}
