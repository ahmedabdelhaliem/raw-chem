import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool withLeading;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleFontSize;
  final PreferredSizeWidget? bottom;
  final double? height;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions; // ← هنا نضيفها

  const DefaultAppBar({
    super.key,
    required this.text,
    this.withLeading = true,
    this.backgroundColor,
    this.titleColor,
    this.bottom,
    this.height,
    this.titleFontSize,
    this.centerTitle = true,
    this.leading,
    this.actions, // ← وهنا
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(
        color: titleColor ?? ColorManager.lightBlackText,
        size: 20.r,
      ),
      title: Text(
        text,
        style: getMediumStyle(
          fontSize: titleFontSize ?? 18.sp,
          color: titleColor ?? ColorManager.black,
        ),
      ),
      leading: leading ?? (withLeading ? null : const SizedBox.shrink()),
      actions: actions, // ← وهنا بنضيفها
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((height ?? 50.h) + (bottom?.preferredSize.height ?? 0));
}
