import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightWidget extends StatelessWidget {
  /// Whether to show the copyright text below the logo.
  final bool showCopyrightText;

  /// Optional tint color for the Brmja logo.
  final Color? logoColor;

  /// Font size for the "Designed & Developed by" text.
  final double? designedByFontSize;

  /// Font size for the copyright text.
  final double? copyrightFontSize;

  /// Height of the Brmja logo image.
  final double? logoHeight;

  /// Width of the Brmja logo image (only applied when [logoHeight] is not set or both are provided).
  final double? logoWidth;

  const CopyrightWidget({
    super.key,
    this.showCopyrightText = true,
    this.logoColor,
    this.designedByFontSize,
    this.copyrightFontSize,
    this.logoHeight,
    this.logoWidth,
  });

  Future<void> _launchBrmjaWebsite() async {
    final Uri url = Uri.parse('https://brmja.tech/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchBrmjaWebsite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // "Designed & Developed by" label
          Text(
            AppStrings.DesignedAndDevelopedBy.tr(),
            style: TextStyle(
              fontSize: designedByFontSize ?? 12.sp,
              color: ColorManager.greyTextColor.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 8.h),

          // Brmja Logo
          SizedBox(
            height: logoHeight ?? 30.h,
            width: logoWidth ?? 150.w,
            child: Image.asset(
              ImageAssets.brmjaLogo,
              color: logoColor,
            ),
          ),

          // Copyright text (optional)
          if (showCopyrightText) ...[
            Text(
              AppStrings.copyright.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: copyrightFontSize ?? 12.sp,
                color: ColorManager.greyTextColor.withValues(alpha: 0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
