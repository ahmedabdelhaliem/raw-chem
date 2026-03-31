import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';

class PriceTrackerView extends StatelessWidget {
  const PriceTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.priceTracker.tr(),
        backgroundColor: ColorManager.bg,
        titleColor: ColorManager.black,
        withLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      textAlign: context.locale.languageCode == 'ar'
                          ? TextAlign.right
                          : TextAlign.left,
                      decoration: InputDecoration(
                        hintText: '${AppStrings.search.tr()}...',
                        hintStyle: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
                        prefixIcon: const Icon(Icons.search, color: ColorManager.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.tune_rounded, color: ColorManager.black, size: 24.sp),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const PriceTrackerCard()
                    .animate()
                    .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                    .slideX(begin: 0.1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PriceTrackerCard extends StatelessWidget {
  const PriceTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FDF5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2F9D1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                  "Sodium Lauryl Sulfate (SLS)",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B3D2F),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 14.sp, color: const Color(0xFFB4B4CC)),
                  SizedBox(width: 4.w),
                  Text(
                    "Nov 20, 2023",
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFFB4B4CC)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F9D1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              AppStrings.surfactant.tr(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A7D2C),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${AppStrings.source.tr()} Supplier B",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF4A7D2C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.priceTrend.tr(),
                        style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.trending_up_rounded, size: 16.sp, color: Colors.black),
                          SizedBox(width: 4.w),
                          Text(
                            AppStrings.up.tr(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 25.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.currentPrice.tr(),
                        style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${AppStrings.egp.tr()}28000",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
