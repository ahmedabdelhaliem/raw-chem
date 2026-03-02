import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isCircle;

  final Color? baseColor;
  final Color? highlightColor;

  const CustomShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.isCircle = false,
    this.baseColor,
    this.highlightColor,
  });

  /// دائرة جاهزة (مثلاً للأفاتار)
  const CustomShimmerWidget.circular({
    super.key,
    this.width,
    this.height,
    this.baseColor,
    this.highlightColor,
  })  : borderRadius = 0,
        isCircle = true;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 20,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
