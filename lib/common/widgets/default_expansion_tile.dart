// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';

class DefaultExpansionTile extends StatefulWidget {
  final String name;
  final String image;
  final List? options;
  final List<Widget>? optionsWidget;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final double radius;
  final bool initiallyExpanded;
  final TextStyle? titleTextStyle;
  final String leadingSvg;

  const DefaultExpansionTile(
      {super.key,
      required this.name,
      this.image = '',
      this.options,
      this.onTap,
      this.optionsWidget,
      this.backgroundColor,
      this.iconColor,
      this.textColor,
      this.radius = 0,
      this.initiallyExpanded = false,
      this.borderColor,
      this.titleTextStyle,
      this.leadingSvg = ''});

  @override
  State<DefaultExpansionTile> createState() => _DefaultExpansionTileState();
}

class _DefaultExpansionTileState extends State<DefaultExpansionTile> {
  bool isOpen = false;
  int? isSelected;
  String lastChoice = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ExpansionTile(
        initiallyExpanded: widget.initiallyExpanded,
        // tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            side: BorderSide(color: widget.borderColor ?? ColorManager.greyBorder)),
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            side: BorderSide(color: widget.borderColor ?? ColorManager.greyBorder)),
        backgroundColor: widget.backgroundColor ?? ColorManager.primary,
        collapsedBackgroundColor: widget.backgroundColor ?? ColorManager.primary,
        iconColor: widget.iconColor ?? ColorManager.white,
        collapsedIconColor: widget.iconColor ?? ColorManager.white,
        onExpansionChanged: (value) {
          setState(() {
            isOpen = value;
          });
        },
        leading: widget.image.isEmpty ? null : _leading(),
        title: _title(),
        children: widget.optionsWidget ?? options(context),
      ),
    );
  }

  Widget _leading() {
    return Image.network(
      widget.image,
      width: 30.w,
      height: 30.h,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: 30.w,
        height: 30.w,
      ),
    );
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.leadingSvg.isNotEmpty)
          SvgPicture.asset(
            widget.leadingSvg,
            width: 20.w,
            height: 20.h,
            fit: BoxFit.contain,
          ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            widget.name,
            style: widget.titleTextStyle ??
                getBoldStyle(
                  fontSize: 15.sp,
                  color: widget.textColor ?? ColorManager.white,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  trailingIcon() {
    return Image.asset(
      ImageAssets.logoBlack,
      color: ColorManager.primary,
      height: 15.h,
      width: 15.w,
    );
  }

  options(BuildContext context) => List.generate(
        (widget.options ?? []).length,
        (index) {
          return InkWell(
            onTap: () {
              widget.onTap?.call(index);
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.grey.withOpacity(.5)),
              ),
              child: Text(
                (widget.options ?? [])[index],
                style: getBoldStyle(fontSize: 15.sp, color: ColorManager.textColor),
              ),
            ),
          );
        },
      );
}
