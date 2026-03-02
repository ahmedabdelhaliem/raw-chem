// import 'package:raw_chem/feature/profile/models/share_app_model.dart';
// import 'package:share_plus/share_plus.dart' as share_plus;

// class AppShareHelper {
//   static const String defaultAndroidLink =
//       'https://play.google.com/store/apps/details?id=tech-oriented.coachizer';
//   static const String defaultIosLink = 'https://apps.apple.com/eg/app/calorie7/id6754528063';

//   static void shareApp(ShareAppData? shareData) {
//     final message = buildFullShareMessage(shareData);
//     share_plus.Share.share(
//       message,
//       subject: shareData?.appName ?? 'Coachizer',
//     );
//   }

//   /// Builds the full formatted share message:
//   /// [Share message from Admin]
//   /// Then optionally appends Code and Links if they aren't already included.
//   static String buildFullShareMessage(ShareAppData? shareData) {
//     String? arText = shareData?.shareMessage;
//     String? enText = shareData?.shareText;

//     // Use fallbacks ONLY if BOTH admin messages are missing
//     if ((arText == null || arText.isEmpty) && (enText == null || enText.isEmpty)) {
//       arText =
//           "حمّل تطبيق كوتشايزر Coachizer لتنظيم تمارينك الرياضية، استخدم الرمز الخاص بي عند التسجيل";
//       enText =
//           "Download the Coachizer app to organize your training, and use my code when registering";
//     }

//     final code = shareData?.code ?? '';
//     final iosLink = _resolveIosLink(shareData);
//     final androidLink = _resolveAndroidLink(shareData);

//     StringBuffer buffer = StringBuffer();
//     if (arText != null && arText.isNotEmpty) buffer.writeln(arText);
//     if (enText != null && enText.isNotEmpty) buffer.writeln(enText);

//     final String currentText = buffer.toString();

//     // Only add code if not already present in the messages
//     if (code.isNotEmpty && !currentText.contains(code)) {
//       buffer.writeln("Code: $code");
//     }

//     // Only add links if not already present in the messages
//     if (!currentText.contains(iosLink)) {
//       buffer.writeln("For iOS devices: $iosLink");
//     }
//     if (!currentText.contains(androidLink)) {
//       buffer.write("For Android devices: $androidLink");
//     }

//     return buffer.toString().trim();
//   }

//   /// Generic coachizer redirect domains that should be replaced with actual store links
//   static const List<String> _genericDomains = [
//     'https://coachizer.com',
//     'https://coachizer.com/',
//     'https://ios.coachizer.com',
//     'https://ios.coachizer.com/',
//     'https://android.coachizer.com',
//     'https://android.coachizer.com/',
//   ];

//   static bool _isGenericLink(String link) {
//     return _genericDomains.contains(link);
//   }

//   static String _resolveIosLink(ShareAppData? shareData) {
//     if (shareData?.shareLinkIos != null &&
//         shareData!.shareLinkIos!.isNotEmpty &&
//         !_isGenericLink(shareData.shareLinkIos!)) {
//       return shareData.shareLinkIos!;
//     }
//     if (shareData?.iosAppUrl != null &&
//         shareData!.iosAppUrl!.isNotEmpty &&
//         !_isGenericLink(shareData.iosAppUrl!)) {
//       return shareData.iosAppUrl!;
//     }
//     return defaultIosLink;
//   }

//   static String _resolveAndroidLink(ShareAppData? shareData) {
//     if (shareData?.shareLinkAndroid != null &&
//         shareData!.shareLinkAndroid!.isNotEmpty &&
//         !_isGenericLink(shareData.shareLinkAndroid!)) {
//       return shareData.shareLinkAndroid!;
//     }
//     if (shareData?.androidAppUrl != null &&
//         shareData!.androidAppUrl!.isNotEmpty &&
//         !_isGenericLink(shareData.androidAppUrl!)) {
//       return shareData.androidAppUrl!;
//     }
//     return defaultAndroidLink;
//   }
// }
