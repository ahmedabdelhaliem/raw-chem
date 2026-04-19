import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';


class DefaultErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String buttonTitle;
  final void Function()? onPressed;
  final bool applyTopHeight;
  final String? imagePath;
  final bool isLottie;

  const DefaultErrorWidget({
    super.key,
    required this.errorMessage,
    this.onPressed,
    this.buttonTitle = '',
    this.applyTopHeight = false,
    this.imagePath,
    this.isLottie = true,
  });

  @override
  Widget build(BuildContext context) {
    // Detect if this is a "No Internet" error
    final isNoInternet = imagePath == ImageAssets.noInternet;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (applyTopHeight) SizedBox(height: MediaQuery.sizeOf(context).height * .1),

            // Minimalist Icon / Image Section
            Container(
              padding: EdgeInsets.all(isNoInternet ? 24.w : 0),
              decoration: isNoInternet
                  ? BoxDecoration(
                      color: ColorManager.greyBorder.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    )
                  : null,
              child: isNoInternet
                  ? Icon(Icons.wifi_off_rounded, size: 55.sp, color: ColorManager.greyTextColor)
                  : (isLottie
                      ? Lottie.asset(imagePath ?? JsonAssets.error, height: 110.h)
                      : Image.asset(imagePath ?? ImageAssets.logo, height: 110.h)),
            ),
            
            SizedBox(height: 24.h),

            // Clean Typography for Error Message
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 15.sp,
                color: ColorManager.blackText,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Professional Outlined Retry Button
            if (onPressed != null && buttonTitle.isNotEmpty) ...[
              SizedBox(height: 24.h),
              SizedBox(
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,
                    foregroundColor: ColorManager.primary,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(color: ColorManager.primary.withValues(alpha: 0.2), width: 1.5),
                    ),
                  ),
                  icon: Icon(Iconsax.refresh, size: 18.sp),
                  label: Text(
                    buttonTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
              ),
            ]
          ],
        ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95)),
      ),
    );
  }
}


