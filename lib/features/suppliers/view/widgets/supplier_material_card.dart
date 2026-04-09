import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/features/price_tracker/model/price_tracker_model.dart';

class SupplierMaterialCard extends StatelessWidget {
  final PriceTrackerModel model;
  final VoidCallback? onTap;

  const SupplierMaterialCard({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FDF5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE2F9D1), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1B3D2F).withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.name ?? "Material Name",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B3D2F),
                    ),
                  ),
                ),
                if (model.averagePrice != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "${model.averagePrice} ${AppStrings.egp.tr()}",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w900,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            if (model.family != null)
              Row(
                children: [
                  Icon(Iconsax.category, size: 14.sp, color: ColorManager.greyTextColor.withOpacity(0.5)),
                  SizedBox(width: 6.w),
                  Text(
                    model.family?.name ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorManager.greyTextColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
