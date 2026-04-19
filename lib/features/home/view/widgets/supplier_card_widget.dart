import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';

class SupplierCardWidget extends StatelessWidget {
  final String name;
  final String? address;
  final String? desc;
  final String imageUrl;
  final VoidCallback? onTap;
  final double? width;

  const SupplierCardWidget({
    super.key,
    required this.name,
    this.address,
    this.desc,
    required this.imageUrl,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? .53.sw,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F7e9), // Light greenish background as in the image
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorManager.primary.withValues(alpha: 0.1), width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: imageUrl.isEmpty
                  ? Container(
                      width: .18.sw,
                      height: .18.sw,
                      color: ColorManager.primary.withValues(alpha: 0.1),
                      child: Icon(Icons.storefront_rounded, color: ColorManager.primary, size: 24.sp),
                    )
                  : Image.network(
                      imageUrl,
                      width: .18.sw,
                      height: .18.sw,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: .18.sw,
                        height: .18.sw,
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        child: Icon(Icons.storefront_rounded, color: ColorManager.primary, size: 24.sp),
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            // Info Section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Row
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D1B2A), // Dark blueish text
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  // Address Row
                  if (address != null && address!.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorManager.greyTextColor,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            address!,
                            style: TextStyle(fontSize: 12.sp, color: ColorManager.greyTextColor, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 6.h),
                  // Description Text
                  if (desc != null && desc!.isNotEmpty)
                    Text(
                      desc!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: ColorManager.primary, // Green color
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
