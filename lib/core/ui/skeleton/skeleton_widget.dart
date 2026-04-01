import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:raw_chem/common/resources/color_manager.dart';

class SkeletonWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const SkeletonWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading
          ? Shimmer.fromColors(
              key: const ValueKey('loading'),
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: child,
            )
          : SizedBox(
              key: const ValueKey('loaded'),
              child: child,
            ),
    );
  }
}
