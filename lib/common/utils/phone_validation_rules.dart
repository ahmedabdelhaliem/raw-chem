import 'package:easy_localization/easy_localization.dart';

import '../resources/strings_manager.dart';

class PhoneValidationRules {
  static const Map<String, int> _lengths = {
    '+20': 10, // Egypt - without leading 0
    '+966': 9, // KSA
  };

  /// Normalizes phone number by removing leading zero if present
  /// This ensures E.164 format compliance
  static String normalizePhone(String phone, String countryCode) {
    final cleanPhone = phone.trim();

    // Remove leading zero for E.164 compliance (standard for most countries)
    if (cleanPhone.startsWith('0')) {
      return cleanPhone.substring(1);
    }

    return cleanPhone;
  }

  static String getFullPhoneNumber(String phone, String countryCode) {
    return countryCode + normalizePhone(phone, countryCode);
  }

  static int getPhoneLength(String countryCode) {
    return _lengths[countryCode] ?? 15; // Default to 15 if not specified
  }

  static String? validate(String? value, String countryCode) {
    if (value == null || value.isEmpty) {
      return AppStrings.textFieldError.tr();
    }

    String cleanPhone = value.trim();
    
    // For validation purposes, if it starts with 0, we treat it as if the 0 is removed 
    // to check the actual significant digits length.
    if (cleanPhone.startsWith('0')) {
      cleanPhone = cleanPhone.substring(1);
    }

    final expectedLength = _lengths[countryCode];

    if (expectedLength != null) {
      if (cleanPhone.length != expectedLength) {
        return AppStrings.invalidPhoneNumberLength.tr();
      }
    } else {
      if (cleanPhone.length < 7) {
        return AppStrings.invalidPhoneNumberLength.tr();
      }
    }

    return null;
  }
}
