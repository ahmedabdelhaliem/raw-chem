import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonBar extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const SkeletonBar({
    super.key,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 12.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius ?? 6.r),
      ),
    );
  }
}
