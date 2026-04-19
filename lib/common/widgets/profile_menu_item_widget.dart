import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raw_chem/common/resources/color_manager.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final String? svgIcon;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? color;
  final bool isLoading;

  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    this.iconData,
    this.svgIcon,
    required this.onTap,
    this.trailing,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isLoading ? 0.6 : 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: iconData != null
                    ? Icon(
                        iconData,
                        size: 24.sp,
                        color: color ?? ColorManager.primary,
                      )
                    : svgIcon != null
                        ? SvgPicture.asset(
                            svgIcon!,
                            width: 24.sp,
                            height: 24.sp,
                            colorFilter: ColorFilter.mode(
                              color ?? ColorManager.primary,
                              BlendMode.srcIn,
                            ),
                          )
                        : const SizedBox(),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: color ?? ColorManager.blackText,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? SizedBox(
                        key: const ValueKey('loading'),
                        width: 16.sp,
                        height: 16.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: color ?? ColorManager.primary,
                        ),
                      )
                    : trailing ??
                        Icon(
                          key: const ValueKey('trailing'),
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: ColorManager.grey,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
