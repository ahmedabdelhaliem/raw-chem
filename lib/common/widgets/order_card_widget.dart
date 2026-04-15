import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class OrderCardWidget extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String amount;
  final String status;
  final Color? statusColor;
  final VoidCallback onTapDetails;

  const OrderCardWidget({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.amount,
    required this.status,
    this.statusColor,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveStatusColor = statusColor ?? ColorManager.primary;

    return GestureDetector(
      onTap: onTapDetails,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 18.h),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Top Section: Icon, ID and Status
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 16.w, 16.h),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(Icons.inventory_2_rounded, color: ColorManager.primary, size: 24.sp),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderNumber,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.blackText,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 12.sp, color: ColorManager.greyTextColor),
                            SizedBox(width: 4.w),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.greyTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(status, effectiveStatusColor),
                ],
              ),
            ),
            
            // Divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: Colors.grey.shade100, height: 1),
            ),

            // Bottom Section: Amount and Details Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.total.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.greyTextColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  
                  // Action Button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.primary.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.orderDetails.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward_ios_rounded, size: 12.sp, color: Colors.white),
                      ],
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

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
