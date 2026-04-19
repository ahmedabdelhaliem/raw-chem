import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CaptainProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? subTitle;
  final double? rating;
  final int? reviews;
  final String? nametype;
  final bool isNotification = true;
  final bool showChildSelection;
  final VoidCallback? onChildSelectionTap;
  final String? childName; // Add this line

  const CaptainProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.subTitle,
    this.rating,
    this.reviews,
    this.nametype,
    this.showChildSelection = false,
    this.onChildSelectionTap,
    this.childName, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String effectiveImageUrl = imageUrl;
    const String prefix = 'https://app-coachizer.brmjatech.uk/uploads/users/';

    // Clean doubled prefixes or handle absolute URLs in the image string
    while (effectiveImageUrl.startsWith('${prefix}http')) {
      effectiveImageUrl = effectiveImageUrl.replaceFirst(prefix, '');
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 2.r,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: DefaultImageWidget(
              image: effectiveImageUrl,
              width: 56.r,
              height: 56.r,
              isCircle: true,
              isProfile: true,
              radius: 28.r,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  letterSpacing: 0.5,
                ),
              ),
              if (subTitle != null || (nametype != null && nametype!.isNotEmpty)) ...[
                SizedBox(height: 4.h),
                Text(
                  subTitle ?? (nametype == 'parent' ? 'ولي أمر' : nametype ?? ''),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          if (showChildSelection) childSelectionButton(onTap: onChildSelectionTap),
          if (showChildSelection) SizedBox(width: 8.w),
          notificationIcon(onTap: () {
          }),
        ],
      ),
    );
  }

  Widget childSelectionButton({VoidCallback? onTap, String? childName}) {
    final hasChild = childName != null && childName.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: hasChild ? Colors.white.withValues(alpha: 0.15) : const Color(0xFFCCFF00),
          borderRadius: BorderRadius.circular(20.r),
          border: hasChild ? Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1) : null,
          boxShadow: hasChild
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFFCCFF00).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasChild) ...[
              Icon(Icons.face, size: 14.sp, color: Colors.white),
              SizedBox(width: 4.w),
            ],
            Text(
              hasChild ? childName : 'الأبناء',
              style: TextStyle(
                color: hasChild ? Colors.white : ColorManager.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16.sp,
              color: hasChild ? Colors.white : ColorManager.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationIcon({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.notifications,
        size: 28,
        color: ColorManager.white,
      ),
    );
  }
}
