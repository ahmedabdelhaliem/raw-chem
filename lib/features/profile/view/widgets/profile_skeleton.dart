import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_bar.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Header Skeleton
          SkeletonWidget(
            isLoading: true,
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 16.h),
                const SkeletonBar(width: 150),
                SizedBox(height: 8.h),
                const SkeletonBar(width: 200),
              ],
            ),
          ),
          SizedBox(height: 48.h),
          
          // Menu Items Skeleton
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) => SkeletonWidget(
              isLoading: true,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const SkeletonBar(width: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
