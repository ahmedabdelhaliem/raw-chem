import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double width;
  final double? height;
  final double? fontSize;
  final bool withBorder;
  final bool isUnderLine;
  final bool isIcon;
  final bool isText;
  final bool isLoading;
  final bool textFirst;
  final String svgPath;
  final Color? color;
  final Color? underLineColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? radius;
  final BorderRadius? borderRadius; // ✅ الجديد
  final double? iconSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextStyle? textStyle;
  final bool isTextCenter;
  final double? textHeight;
  final Widget? verticalWidget;
  final Widget? child;
  final double? elevation;
  final Widget? iconBuilder;
  final bool isExpanded;
  final Color? overlayColor;
  final Color? loadingColor;

  const DefaultButtonWidget({
    super.key,
    this.onPressed,
    this.text = '',
    this.width = double.infinity,
    this.withBorder = false,
    this.isIcon = false,
    this.svgPath = '',
    this.color,
    this.isText = true,
    this.height,
    this.textColor,
    this.iconColor,
    this.radius,
    this.borderRadius, // ✅ الجديد
    this.horizontalPadding,
    this.verticalPadding,
    this.borderColor,
    this.isUnderLine = false,
    this.fontSize,
    this.underLineColor,
    this.iconSize,
    this.textFirst = false,
    this.textStyle,
    this.isLoading = false,
    this.isTextCenter = true,
    this.textHeight,
    this.verticalWidget,
    this.child,
    this.elevation,
    this.iconBuilder,
    this.isExpanded = true,
    this.overlayColor,
    this.loadingColor,
  });

  const DefaultButtonWidget.arrowIcon({
    super.key,
    this.onPressed,
    this.text = '',
    this.width = double.infinity,
    this.withBorder = false,
    this.svgPath = '',
    this.color,
    this.height,
    this.textColor,
    this.iconColor,
    this.radius,
    this.borderColor,
    this.borderRadius,
    this.isUnderLine = false,
    this.fontSize,
    this.underLineColor,
    this.iconSize,
    this.textStyle,
    this.isLoading = false,
    this.isTextCenter = true,
    this.textHeight,
    this.verticalWidget,
    this.child,
    this.elevation,
    this.isExpanded = true,
    this.overlayColor,
    this.loadingColor,
  })  : iconBuilder = const CircleAvatar(
          radius: 20,
          backgroundColor: ColorManager.white,
          child: Icon(Icons.arrow_forward),
        ),
        isIcon = true,
        isText = true,
        textFirst = true,
        verticalPadding = 5,
        horizontalPadding = 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            isIcon && !isText
                ? const CircleBorder()
                : !isUnderLine
                    ? RoundedRectangleBorder(
                        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10.sp),
                      )
                    : LinearBorder.bottom(
                        side: BorderSide(color: underLineColor ?? ColorManager.grey),
                      ),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: verticalPadding ?? (height != null ? 0 : 12.h),
              horizontal: horizontalPadding ?? 10.w,
            ),
          ),
          overlayColor: WidgetStatePropertyAll(
            overlayColor ??
                (withBorder
                    ? ColorManager.primary.withValues(alpha: .1)
                    : ColorManager.white.withValues(alpha: .3)),
          ),
          backgroundColor: WidgetStateProperty.all(color ?? Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.grey.shade100),
          side: withBorder
              ? WidgetStatePropertyAll(BorderSide(color: borderColor ?? ColorManager.green))
              : null,
          elevation: WidgetStatePropertyAll(isLoading ? 0 : elevation ?? 3),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 20.w,
                  width: 20.w,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: loadingColor ?? textColor ?? ColorManager.white,
                      strokeWidth: 2.0,
                    ),
                  ),
                )
              : child ??
                  Column(
                    key: const ValueKey('content'),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (verticalWidget != null) verticalWidget!,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isIcon && !textFirst) _svgIcon(),
                          if (isIcon && isText) SizedBox(width: 10.w),
                          if (isText)
                            Flexible(
                              fit: isExpanded ? FlexFit.tight : FlexFit.loose,
                              child: Text(
                                text,
                                textAlign: isTextCenter ? TextAlign.center : null,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle ??
                                    getBoldStyle(
                                        fontSize: fontSize ?? 14.sp,
                                        color: textColor ?? ColorManager.primary,
                                        height: textHeight),
                              ),
                            ),
                          if (isIcon && textFirst) SizedBox(width: 10.w),
                          if (isIcon && textFirst) _svgIcon(),
                        ],
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _svgIcon() {
    return iconBuilder ??
        SvgPicture.asset(
          svgPath,
          height: iconSize ?? 22.h,
          width: iconSize ?? 22.w,
          fit: BoxFit.fill,
          color: iconColor,
        );
  }
}
