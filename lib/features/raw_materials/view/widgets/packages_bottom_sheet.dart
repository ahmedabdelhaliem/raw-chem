import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/raw_materials/view/connect_supplier_view.dart';

class PackagesBottomSheet extends StatelessWidget {
  final int materialId;
  const PackagesBottomSheet({super.key, required this.materialId});

  static void show(BuildContext context, int materialId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PackagesBottomSheet(materialId: materialId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.subscriptionPackagesTitle.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3D2F),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            AppStrings.choosePackageSubtitle.tr(),
            style: TextStyle(fontSize: 12.sp, color: ColorManager.greyTextColor),
          ),
          SizedBox(height: 25.h),

          // Packages Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPackageCard(
                title: AppStrings.package1Title.tr(),
                price: '100 ${AppStrings.egp.tr()}',
                duration: AppStrings.egpMonth.tr(),
                color: const Color(0xFF1B3D2F),
              ),
              _buildPackageCard(
                title: AppStrings.package2Title.tr(),
                price: '190 ${AppStrings.egp.tr()}',
                duration: AppStrings.egp2Months.tr(),
                color: const Color(0xFFD4E7C5),
                textColor: const Color(0xFF1B3D2F),
              ),
              _buildPackageCard(
                title: AppStrings.package3Title.tr(),
                price: '280 ${AppStrings.egp.tr()}',
                duration: AppStrings.egp3Months.tr(),
                color: const Color(0xFFBBE4A2),
                textColor: const Color(0xFF1B3D2F),
              ),
            ],
          ),
          SizedBox(height: 35.h),

          // Action Button
          DefaultButtonWidget(
            text: AppStrings.sendRequestButton.tr(),
            onPressed: () {
              Navigator.pop(context); // Close sheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectSupplierView(materialId: materialId),
                ),
              );
            },
            color: const Color(0xFF006B3E),
            textColor: Colors.white,
            radius: 12.r,
            height: 50.h,
            isIcon: true,
            textFirst: true,
            iconBuilder: Container(
              padding: EdgeInsets.all(5.w),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 14.sp),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String price,
    required String duration,
    required Color color,
    Color textColor = Colors.white,
  }) {
    return Container(
      width: .28.sw,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 10.sp, color: textColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            price,
            style: TextStyle(fontSize: 12.sp, color: textColor, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),
          Text(
            duration,
            style: TextStyle(fontSize: 8.sp, color: textColor.withValues(alpha: 0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
