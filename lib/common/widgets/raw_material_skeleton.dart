import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/shimmer_container_widget.dart';

class RawMaterialSkeleton extends StatelessWidget {
  final double? width;
  
  const RawMaterialSkeleton({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image skeleton
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: AspectRatio(
              aspectRatio: 1.9,
              child: ShimmerContainerWidget(
                height: double.infinity,
                radios: 15.r,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                // Title
                ShimmerContainerWidget(height: 12.h, width: 100.w, radios: 4.r),
                SizedBox(height: 8.h),
                // Category pill
                ShimmerContainerWidget(height: 16.h, width: 60.w, radios: 6.r),
                SizedBox(height: 8.h),
                // Description lines
                ShimmerContainerWidget(height: 10.h, width: double.infinity, radios: 4.r),
                SizedBox(height: 4.h),
                ShimmerContainerWidget(height: 10.h, width: 80.w, radios: 4.r),
                SizedBox(height: 12.h),
                // Meta row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainerWidget(height: 10.h, width: 40.w, radios: 4.r),
                    ShimmerContainerWidget(height: 10.h, width: 60.w, radios: 4.r),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
