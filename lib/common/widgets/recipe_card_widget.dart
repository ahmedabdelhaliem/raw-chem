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
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF3FAF0),
                  child: AspectRatio(
                    aspectRatio: 1.9,
                    child: Center(
                      child: heroTag != null
                          ? Hero(tag: heroTag!, child: _buildImage())
                          : _buildImage(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1B3D2F),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2F9D1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFF4A7D2C),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFFB4B4CC),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: .75.sw,
        height: .75.sh,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.white, width: .75.sw, height: .75.sh),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.image_not_supported_outlined,
          size: 28.sp,
          color: ColorManager.greyTextColor.withOpacity(0.3),
        ),
      ),
    );
  }
}
