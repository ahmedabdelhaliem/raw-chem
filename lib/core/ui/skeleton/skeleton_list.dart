import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'skeleton_widget.dart';

class SkeletonList extends StatelessWidget {
  final int itemCount;
  final Widget itemBuilder;
  final bool isLoading;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;

  const SkeletonList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.isLoading = true,
    this.spacing,
    this.padding,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: isLoading,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padding ?? EdgeInsets.symmetric(vertical: 10.h),
        scrollDirection: scrollDirection,
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(
          height: scrollDirection == Axis.vertical ? (spacing ?? 16.h) : 0,
          width: scrollDirection == Axis.horizontal ? (spacing ?? 16.w) : 0,
        ),
        itemBuilder: (context, index) => itemBuilder,
      ),
    );
  }
}
