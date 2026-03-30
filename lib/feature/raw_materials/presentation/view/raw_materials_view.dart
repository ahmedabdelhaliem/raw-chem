import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/filter_bottom_sheet_widget.dart';

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
        actions: [
          GestureDetector(
            onTap: () {
              context.push(AppRouters.cartView);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorManager.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.shopping_cart_outlined, color: ColorManager.black, size: 20.sp),
                  Positioned(
                    top: -2.h,
                    right: -2.w,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFF006B3E),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (context.locale.languageCode == 'ar')
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.black),
              onPressed: () => context.pop(),
            ),
        ],
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
          GestureDetector(
            onTap: () async {
              final result = await FilterBottomSheetWidget.show(context);
              if (result != null) {
                // TODO: Apply filter based on selected index
              }
            },
            child: Container(
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
          ),
          SizedBox(width: 10.w),
          // Search Bar with Avatar
          Expanded(
            child: Container(
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
                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
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
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.62, // Adjust aspect ratio to provide more height
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final String heroTag = 'raw_material_grid_$index';
        const String imageUrl = 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=300';
        const String title = 'حمض ألكيل بنزين السلفونيك الخطي (LABSA)';
        const String category = 'مادة فعالة سطحياً';
        const String description = 'يوفر تغلغل سطح الأميل الممتلئ بشكل قوي، وهو المكون الأساسي لمنظفات الغسيل.';
        const String casNumber = '25155-30-0';
        const String averagePrice = '1200 جنية - 1100 جنية';
        const String supplier = 'دلتا للحلول الكيميائية';

        return RawMaterialCardWidget(
          imageUrl: imageUrl,
          title: title,
          category: category,
          description: description,
          casNumber: casNumber,
          averagePrice: averagePrice,
          supplier: supplier,
          heroTag: heroTag,
          onTap: () {
            context.push(
              AppRouters.rawMaterialDetailsView,
              extra: {
                'imageUrl': imageUrl,
                'title': title,
                'category': category,
                'description': description,
                'casNumber': casNumber,
                'averagePrice': averagePrice,
                'supplier': supplier,
                'heroTag': heroTag,
              },
            );
          },
        )
            .animate()
            .fadeIn(delay: (index * 50).ms, duration: 400.ms)
            .scale(begin: const Offset(0.9, 0.9));
      },
    );
  }
}
