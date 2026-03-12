import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';

class SupplierCardWidget extends StatelessWidget {
  final String name;
  final String rating;
  final String location;
  final String products;
  final String imageUrl;
  final VoidCallback? onTap;

  const SupplierCardWidget({
    super.key,
    required this.name,
    required this.rating,
    required this.location,
    required this.products,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: .53.sw,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.primary.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                width: .15.sw,
                height: .18.sw,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(ImageAssets.logo2),
              ),
            ),
            SizedBox(width: 8.w),
            // Info Section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name
                      Flexible(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      // Rating
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            rating,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blackText,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.star, color: ColorManager.yellow, size: 16.sp),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorManager.greyTextColor,
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        location,
                        style: TextStyle(fontSize: 10.sp, color: ColorManager.greyTextColor),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  // Products Text
                  Text(
                    products,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: ColorManager.primary.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
