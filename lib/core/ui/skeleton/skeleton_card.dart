import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';

class SkeletonCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const SkeletonCard({
    super.key,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 100.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(radius ?? 12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 12.h,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 150.w,
                  height: 12.h,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 100.w,
                  height: 12.h,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
