import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:shimmer/shimmer.dart';

class RecipeCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final VoidCallback? onTap;
  final String? heroTag;

  const RecipeCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    this.buttonText,
    this.onButtonTap,
    this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with Background
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: _buildImage(),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffD2E8B1).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorManager.greyTextColor,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 12.h),
                  DefaultButtonWidget(
                    text: buttonText ?? AppStrings.viewRecipeDetails.tr(),
                    onPressed: onButtonTap,
                    color: ColorManager.primary,
                    textColor: ColorManager.white,
                    radius: 10.r,
                    fontSize: 12.sp,
                    // height: 36.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: 80.h,

      width: double.infinity,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_outlined,
        size: 30.sp,
        color: ColorManager.greyTextColor.withOpacity(0.3),
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: ClipRRect(borderRadius: BorderRadius.circular(12.r), child: image),
      );
    }

    return ClipRRect(borderRadius: BorderRadius.circular(12.r), child: image);
  }
}
