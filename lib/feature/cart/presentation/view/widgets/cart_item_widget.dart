import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String company;
  final String category;
  final String price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.category,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delete Icon
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: Color(0xFFFFEBEB),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: ColorManager.red, size: 14.sp),
            ),
          ),
          SizedBox(width: 12.w),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 60.w, height: 60.h, color: Colors.white),
              ),
              errorWidget: (context, url, error) => Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey.shade100,
                child: Icon(Icons.image_not_supported, size: 20.sp, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Main Content (Texts and Quantity)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Texts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: TextStyle(fontSize: 10.sp, color: ColorManager.greyTextColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.blackText,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Bottom Row: Quantity Controls and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity
                    Row(
                      children: [
                        _buildQuantityButton(Icons.add, onAdd),
                        SizedBox(width: 15.w),
                        Text(
                          '$quantity',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15.w),
                        _buildQuantityButton(Icons.remove, onRemove),
                      ],
                    ),
                    // Price
                    Row(
                      children: [
                        Text(
                          'جنية',
                          style: TextStyle(fontSize: 10.sp, color: ColorManager.primary),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Icon(icon, size: 16.sp, color: ColorManager.black),
      ),
    );
  }
}
