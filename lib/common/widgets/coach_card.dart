import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoachCard extends StatelessWidget {
  const CoachCard({
    super.key,
    this.image,
    this.name,
    this.sportText,
    this.groupsText,
    this.isActive,
    required this.onTap,
  });

  final String? image;
  final String? name;
  final String? sportText;
  final String? groupsText;
  final bool? isActive;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isActive == null
        ? ColorManager.primary
        : (isActive == true ? const Color(0xFF00B167) : const Color(0xFFFF4848));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative background gradient
            Positioned(
              right: -20.w,
              top: -20.h,
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.03),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                children: [
                  // Profile Image with Status Indicator
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              statusColor.withOpacity(0.4),
                              statusColor.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: DefaultImageWidget(
                          image: image,
                          width: 60.r,
                          height: 60.r,
                          isCircle: true,
                          isProfile: true,
                        ),
                      ),
                      if (isActive != null)
                        Positioned(
                          right: 2.w,
                          bottom: 2.h,
                          child: Container(
                            width: 14.r,
                            height: 14.r,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: statusColor.withOpacity(0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  // Information Header
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.black,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: ColorManager.primary.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  sportText ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.primary.withOpacity(0.7),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (groupsText != null && groupsText!.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(Icons.groups,
                                  size: 14.sp, color: ColorManager.primary.withOpacity(0.5)),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  groupsText!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Go to Details button
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons
                          .keyboard_arrow_left_rounded, // Assuming LTR for now, but usually it's handled by context
                      size: 18.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
