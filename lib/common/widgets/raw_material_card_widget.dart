import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:shimmer/shimmer.dart';

class RawMaterialCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final String casNumber;
  final String averagePrice;
  final String supplier;
  final VoidCallback? onAddTap;
  final VoidCallback? onTap;
  final double? width;
  final String? heroTag;

  const RawMaterialCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    required this.casNumber,
    required this.averagePrice,
    required this.supplier,
    this.onAddTap,
    this.onTap,
    this.width,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Image section ──────────────────────────
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF3FAF0),
                  child: AspectRatio(
                    aspectRatio: 1.9, // Maintains consistent shape
                    child: Center(
                      child: heroTag != null
                          ? Hero(tag: heroTag!, child: _buildImage())
                          : _buildImage(),
                    ),
                  ),
                ),
              ),
            ),

            // ── Content section (fills remaining space) ─
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top block: title + category + description
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

                    // Bottom block: meta + add button
                    SizedBox(height: 4.h),
                    _buildMeta(AppStrings.casNumber.tr(), casNumber),
                    SizedBox(height: 4.h),
                    _buildMeta(AppStrings.averagePrice.tr(), averagePrice),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: onAddTap,
                          child: Container(
                            padding: EdgeInsets.all(7.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: const Color(0xFF006B3E),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF006B3E).withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(Icons.add_rounded, color: Colors.white, size: 18.sp),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            supplier,
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: const Color(0xFF4A7D2C),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
          child: Container(color: Colors.white, width: 80.w, height: 72.h),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.image_not_supported_outlined,
          size: 28.sp,
          color: ColorManager.greyTextColor.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildMeta(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3D2F),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            color: const Color(0xFFB4B4CC),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
