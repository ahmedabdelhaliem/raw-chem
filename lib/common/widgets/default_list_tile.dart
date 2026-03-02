import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultListTile extends StatefulWidget {
  final String? iconPath;
  final IconData? icon;
  final Widget? iconWidget;
  final String text;
  final String actionButtonText;
  final void Function()? actionButtonOnPressed;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final double? actionIconSize;
  final double? iconSize;
  final bool withUnderLine;
  final bool withTrailing;
  final Color? tileColor;
  final Color? itemsColor;
  final bool fromNetwork;
  final bool isLoading;

  /// 👈 المتغيّر الجديد للتحكم في الارتفاع
  final double? tileHeight;

  /// 🎨 المتغيّر الجديد للتحكم في لون الأيقونة
  final Color? iconColor;

  const DefaultListTile({
    super.key,
    this.iconPath,
    this.icon,
    this.iconWidget,
    required this.text,
    this.actionButtonText = '',
    this.actionButtonOnPressed,
    this.textStyle,
    this.onTap,
    this.actionIconSize,
    this.iconSize,
    this.withUnderLine = false,
    this.withTrailing = true,
    this.tileColor,
    this.fromNetwork = false,
    this.itemsColor,
    this.isLoading = false,
    this.tileHeight,
    this.iconColor, // 👈 إضافة المتغير هنا
  });

  @override
  State<DefaultListTile> createState() => _DefaultListTileState();
}

class _DefaultListTileState extends State<DefaultListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.tileHeight ?? 55.h,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side: BorderSide(color: ColorManager.greyBorder, width: 1.w),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        onTap: widget.onTap,
        tileColor: widget.tileColor,
        leading: _buildIcon(),
        minLeadingWidth: 20.w,
        title: Text(
          widget.text,
          style: widget.textStyle ??
              getRegularStyle(
                fontSize: 12.sp,
                color: widget.itemsColor ?? ColorManager.black.withOpacity(.7),
              ),
        ),
        trailing: _getTrailingWidget(),
      ),
    );
  }

  /// ✔ أيقونة ديناميكية (SVG أو Network)
  Widget _buildIcon() {
    if (widget.iconWidget != null) return widget.iconWidget!;

    if (widget.icon != null) {
      return Icon(
        widget.icon,
        size: widget.iconSize ?? 22.sp,
        color: widget.iconColor ?? widget.itemsColor ?? ColorManager.black.withOpacity(.7),
      );
    }

    if (widget.fromNetwork) {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          widget.iconColor ?? Colors.transparent,
          BlendMode.srcIn,
        ),
        child: Image.network(
          widget.iconPath ?? '',
          height: widget.iconSize ?? 25.h,
          width: widget.iconSize ?? 24.w,
          errorBuilder: (context, error, stackTrace) => CircleAvatar(
            backgroundColor: ColorManager.green.withOpacity(.3),
            radius: 15.sp,
          ),
        ),
      );
    } else {
      return SvgPicture.asset(
        widget.iconPath ?? '',
        height: widget.iconSize ?? 25.w,
        width: widget.iconSize ?? 25.w,
        color: widget.iconColor ?? widget.itemsColor ?? ColorManager.black.withOpacity(.7),
      );
    }
  }

  Widget? _getTrailingWidget() {
    if (widget.isLoading) {
      return SizedBox(
        height: 20.w,
        width: 20.w,
        child: Center(
          child: CircularProgressIndicator(
            color: widget.itemsColor ?? ColorManager.primary,
          ),
        ),
      );
    }

    if (!widget.withTrailing) return null;

    if (widget.actionButtonText.isNotEmpty) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
          minimumSize: const Size(0, 0),
        ),
        onPressed: widget.actionButtonOnPressed,
        child: Text(
          widget.actionButtonText,
          style: getBoldStyle(fontSize: 15.sp, color: ColorManager.primary),
        ),
      );
    }

    return Icon(
      Icons.arrow_forward_ios_outlined,
      color: widget.itemsColor ?? ColorManager.textColor,
      size: widget.actionIconSize ?? 15.r,
    );
  }
}
