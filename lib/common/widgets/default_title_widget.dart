import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';

class DefaultTitleWidget extends StatefulWidget {
  final String title;
  final double? font;

  const DefaultTitleWidget({super.key, required this.title, this.font});

  @override
  State<DefaultTitleWidget> createState() => _DefaultTitleWidgetState();
}

class _DefaultTitleWidgetState extends State<DefaultTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: getBoldStyle(fontSize: 17.sp, color: ColorManager.black),
        ),
        Container(
          height: 2.h,
          width: 70.w,
          color: ColorManager.primary,
        ),
      ],
    );
  }
}
