import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const RegisterRequest._();

  const factory RegisterRequest({
    required String name,
    required String email,
    required String phone,
    required String birthDate,
    required String password,
    required String passwordConfirmation,
    required int categoryId,
    MultipartFile? image,
  }) = _RegisterRequest;

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "birth_date": birthDate,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "category_id": categoryId,
      if (image != null) "image": image,
    });
  }
}
