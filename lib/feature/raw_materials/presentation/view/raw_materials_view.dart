import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';

class RawMaterialsView extends StatelessWidget {
  const RawMaterialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.rawMaterials.tr(),
        backgroundColor: ColorManager.bg,
        titleColor: ColorManager.black,
        withLeading: context.locale.languageCode != 'ar',
        actions: context.locale.languageCode == 'ar'
            ? [
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.black),
                  onPressed: () => Navigator.maybePop(context),
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          _buildSearchSection(context),
          Expanded(child: _buildMaterialsGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          // Filter Icon
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
          SizedBox(width: 10.w),
          // Search Bar with Avatar
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(15.r),
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
                      hintText: 'حمض ...',
                      hintStyle: TextStyle(
                        color: ColorManager.greyTextColor.withOpacity(0.5),
                        fontSize: 14.sp,
                      ),
                      suffixIcon: const Icon(Icons.search, color: ColorManager.black),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                    ),
                  ),
                ),
                // Centered Avatar
                Positioned(
                  top: -10.h,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2);
  }

  Widget _buildMaterialsGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.68,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return RawMaterialCardWidget(
              imageUrl: 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=300',
              title: 'حمض ألكيل بنزين السلفونيك الخطي (LABSA)',
              category: 'مادة فعالة سطحياً',
              description:
                  'يوفر تغلغل سطح الأميل الممتلئ بشكل قوي، وهو المكون الأساسي لمنظفات الغسيل.',
              casNumber: '25155-30-0',
              averagePrice: '1200 جنية - 1100 جنية',
              supplier: 'دلتا للحلول الكيميائية',
              heroTag: 'raw_material_grid_$index',
            )
            .animate()
            .fadeIn(delay: (index * 50).ms, duration: 400.ms)
            .scale(begin: const Offset(0.9, 0.9));
      },
    );
  }
}
