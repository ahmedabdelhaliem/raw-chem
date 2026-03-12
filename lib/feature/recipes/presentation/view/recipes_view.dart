import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/recipe_card_widget.dart';

import 'recipe_details_view.dart';

class RecipesView extends StatelessWidget {
  const RecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.recipes.tr(),
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
          Expanded(child: _buildRecipesGrid(context)),
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
          // Search Bar
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
                  hintText: 'ابحث ...',
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

  Widget _buildRecipesGrid(BuildContext context) {
    // The image used is a powder sample, like in the previous design.
    const String dummyImage =
        'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=300';
    return GridView.builder(
      padding: EdgeInsets.all(20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.63,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return RecipeCardWidget(
          imageUrl: dummyImage,
          title: 'مسحوق الغسيل الاقتصادي',
          category: 'منظفات الغسيل',
          description: 'منظف مسحوق فعال وبأسعار معقولة للغسيل العام، مصمم للاستخدام بكميات كبيرة.',
          heroTag: 'recipe_grid_$index',
          onButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailsView(heroTag: 'recipe_grid_$index'),
              ),
            );
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailsView(heroTag: 'recipe_grid_$index'),
              ),
            );
          },
        ).animate().fadeIn(delay: (100 * index).ms).scale(delay: (100 * index).ms);
      },
    );
  }
}
