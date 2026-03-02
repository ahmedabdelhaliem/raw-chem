import 'package:raw_chem/common/resources/language_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String langKey = 'lang_key';
const String prefsKeyOnBoardingScreenViewed = "PREFS_KEY_ON_BOARDING_SCREEN_VIEWED";
const String prefsKeySaveToken = "PREFS_KEY_SAVE_TOKEN";
const String prefsKeySaveFcmToken = "PREFS_KEY_SAVE_FCM_TOKEN";

const String prefsKeySaveUserType = "PREFS_KEY_SAVE_UserType";
const String prefsKeySaveUserName = "PREFS_KEY_SAVE_Name";
const String prefsKeySaveStudentCode = "PREFS_KEY_SAVE_StudentCode";
const String prefsKeySaveUserImage = "PREFS_KEY_SAVE_UserImage";
const String prefsKeyUserMobile = "PREFS_KEY_USER_mobile";
const String prefsKeyUserEmail = "PREFS_KEY_USER_email";
const String prefsKeyUserId = "PREFS_KEY_USER_ID";
const String prefsKeyHasChild = "PREFS_KEY_HAS_CHILD";
const String prefsKeyIsSubscribed = "PREFS_KEY_IS_SUBSCRIBED";
const String prefsKeySelectedChildId = "PREFS_KEY_SELECTED_CHILD_ID";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(langKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ARABIC.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      _sharedPreferences.setString(langKey, LanguageType.ARABIC.getValue());
    } else {
      _sharedPreferences.setString(langKey, LanguageType.ENGLISH.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      return ENGLISH_LOCALE;
    } else {
      return ARABIC_LOCALE;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenViewed, true);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenViewed) ?? false;
  }

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(prefsKeySaveToken, token);
  }

  String getToken() {
    return _sharedPreferences.getString(prefsKeySaveToken) ?? '';
  }

  Future<void> saveUserType(String type) async {
    await _sharedPreferences.setString(prefsKeySaveUserType, type);
  }

  String getUserType() {
    return _sharedPreferences.getString(prefsKeySaveUserType) ?? '';
  }

  Future<void> saveUserName(String name) async {
    await _sharedPreferences.setString(prefsKeySaveUserName, name);
  }

  String getUserName() {
    return _sharedPreferences.getString(prefsKeySaveUserName) ?? '';
  }

  Future<void> saveStudentCode(String name) async {
    await _sharedPreferences.setString(prefsKeySaveStudentCode, name);
  }

  String getStudentCode() {
    return _sharedPreferences.getString(prefsKeySaveStudentCode) ?? '';
  }

  /// Cleans corrupted image URLs where the base path has been duplicated by the backend
  String _cleanImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';

    // Find the last index of 'http' to handle nested/redundant base paths
    final lastHttpIndex = imageUrl.lastIndexOf('http');
    if (lastHttpIndex != -1 && lastHttpIndex != 0) {
      return imageUrl.substring(lastHttpIndex);
    }

    return imageUrl;
  }

  Future<void> saveUserImage(String name) async {
    await _sharedPreferences.setString(prefsKeySaveUserImage, _cleanImageUrl(name));
  }

  String getUserImage() {
    return _cleanImageUrl(_sharedPreferences.getString(prefsKeySaveUserImage));
  }

  Future<void> setMobile(String mobile) async {
    _sharedPreferences.setString(prefsKeyUserMobile, mobile);
  }

  String getMobile() {
    return _sharedPreferences.getString(prefsKeyUserMobile) ?? '';
  }

  Future<void> setEmail(String email) async {
    _sharedPreferences.setString(prefsKeyUserEmail, email);
  }

  String getEmail() {
    return _sharedPreferences.getString(prefsKeyUserEmail) ?? '';
  }

  Future<void> setUserId(String userId) async {
    _sharedPreferences.setString(prefsKeyUserId, userId);
  }

  String getUserId() {
    return _sharedPreferences.getString(prefsKeyUserId) ?? '';
  }

  Future<void> saveHasChild(bool hasChild) async {
    await _sharedPreferences.setBool(prefsKeyHasChild, hasChild);
  }

  bool getHasChild() {
    return _sharedPreferences.getBool(prefsKeyHasChild) ?? false;
  }

  Future<void> saveSubscriptionStatus(bool isSubscribed) async {
    await _sharedPreferences.setBool(prefsKeyIsSubscribed, isSubscribed);
  }

  bool getSubscriptionStatus() {
    return _sharedPreferences.getBool(prefsKeyIsSubscribed) ?? false;
  }

  //===saveFcmToken
  Future<void> saveFcmToken(String token) async {
    await _sharedPreferences.setString(prefsKeySaveFcmToken, token);
  }

  String getFcmToken() {
    return _sharedPreferences.getString(prefsKeySaveFcmToken) ?? '';
  }

  Future<void> saveSelectedChildId(int? childId) async {
    if (childId == null) {
      await _sharedPreferences.remove(prefsKeySelectedChildId);
    } else {
      await _sharedPreferences.setInt(prefsKeySelectedChildId, childId);
    }
  }

  int? getSelectedChildId() {
    return _sharedPreferences.getInt(prefsKeySelectedChildId);
  }

  Future<void> logout() async {
    await Future.wait([
      _sharedPreferences.remove(prefsKeySaveToken),
      _sharedPreferences.remove(prefsKeySaveUserType),
      _sharedPreferences.remove(prefsKeySaveUserName),
      _sharedPreferences.remove(prefsKeySaveStudentCode),
      _sharedPreferences.remove(prefsKeySaveUserImage),
      _sharedPreferences.remove(prefsKeyUserEmail),
      _sharedPreferences.remove(prefsKeyUserMobile),
      _sharedPreferences.remove(prefsKeyUserId),
      _sharedPreferences.remove(prefsKeyHasChild),
      _sharedPreferences.remove(prefsKeyIsSubscribed),
      _sharedPreferences.remove(prefsKeySelectedChildId),
    ]);
  }
}
