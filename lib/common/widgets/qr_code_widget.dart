import 'package:raw_chem/app/app_functions.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String data;
  final String? title;
  final String? subtitle;
  final bool showCopyButton;
  final bool showData;

  const QrCodeWidget({
    super.key,
    required this.data,
    this.title,
    this.subtitle,
    this.showCopyButton = true,
    this.showData = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.primary.withOpacity(0.1),
            ColorManager.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: ColorManager.primary.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
          ],
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorManager.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
          ],
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: QrImageView(
              data: data,
              version: QrVersions.auto,
              size: 200.w,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: ColorManager.primary,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: ColorManager.primary,
              ),
            ),
          ),
          if (showData) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      data,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (showCopyButton) ...[
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: data));
                        // ignore: use_build_context_synchronously
                        AppFunctions.showsToast(
                          AppStrings.textCopied.tr(),
                          ColorManager.successGreen,
                          context,
                        );
                      },
                      child: Icon(
                        Icons.copy_rounded,
                        color: ColorManager.primary,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
