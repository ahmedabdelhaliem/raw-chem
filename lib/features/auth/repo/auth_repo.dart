import 'package:dio/dio.dart';
import 'package:raw_chem/common/http/api_consumer.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import '../model/register/register_request.dart';
import '../model/register/register_response.dart';
import '../model/verify_otp/verify_otp_request.dart';
import '../model/verify_otp/verify_otp_response.dart';
import '../model/forgot_password/forgot_password_request.dart';
import '../model/forgot_password/verify_otp_forgot_request.dart';
import '../model/forgot_password/reset_password_request.dart';
import '../model/forgot_password/forgot_response.dart';
import '../model/login/login_request.dart';
import '../model/login/login_response.dart';
import '../../profile/model/faq/faq_model.dart';
import '../../profile/model/profile/profile_model.dart';
import '../../profile/model/static_page/static_page_model.dart';
import '../../profile/model/update_profile/update_profile_request.dart';

class AuthRepo {
  final ApiConsumer _apiConsumer;

  AuthRepo(this._apiConsumer);

  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.login,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(LoginResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, RegisterResponse>> register(RegisterRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.register,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(RegisterResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.verifyOtp,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(VerifyOtpResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> resendOtp(String phone) async {
    final response = await _apiConsumer.post(
      EndPoints.resendOtp,
      formData: await FormData.fromMap({'phone': phone}),
    );

    return response.fold(
      (failure) => Left(failure),
      (_) => Right(null),
    );
  }

  Future<Either<Failure, ForgotResponse>> forgotPassword(ForgotPasswordRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.forgotPassword,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ForgotResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, ForgotResponse>> verifyOtpForgot(VerifyOtpForgotRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.forgotVerifyOtp,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ForgotResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> resendOtpForgot(String phone) async {
    final response = await _apiConsumer.post(
      EndPoints.forgotResendOtp,
      formData: await FormData.fromMap({'phone': phone}),
    );

    return response.fold(
      (failure) => Left(failure),
      (_) => Right(null),
    );
  }

  Future<Either<Failure, ForgotResponse>> resetPassword(ResetPasswordRequest request) async {
    final response = await _apiConsumer.post(
      EndPoints.forgotResetPassword,
      formData: await request.toFormData(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ForgotResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, void>> logout() async {
    final response = await _apiConsumer.post(EndPoints.logout);

    return response.fold(
      (failure) => Left(failure),
      (_) => Right(null),
    );
  }

  Future<Either<Failure, ProfileResponse>> getProfile() async {
    final response = await _apiConsumer.get(EndPoints.profile);

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ProfileResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, ProfileResponse>> updateProfile(UpdateProfileRequest request) async {
    final response = await _apiConsumer.put(
      EndPoints.updateProfile,
      data: request.toJson(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ProfileResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, StaticPageResponse>> getTerms() async {
    final response = await _apiConsumer.get(EndPoints.terms);

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(StaticPageResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, StaticPageResponse>> getAboutUs() async {
    final response = await _apiConsumer.get(EndPoints.aboutUs);

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(StaticPageResponse.fromJson(data)),
    );
  }

  Future<Either<Failure, FaqResponse>> getFaqs() async {
    final response = await _apiConsumer.get(EndPoints.faq);

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(FaqResponse.fromJson(data)),
    );
  }
}
