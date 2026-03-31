import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(title: AppStrings.cosmetics.tr(), icon: Icons.face_retouching_natural_rounded),
      CategoryModel(title: AppStrings.paints.tr(), icon: Icons.format_paint_rounded),
      CategoryModel(title: AppStrings.others.tr(), icon: Icons.grid_view_rounded),
      CategoryModel(title: AppStrings.detergents.tr(), icon: Icons.sanitizer_rounded),
    ];

    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.categories.tr(),
        backgroundColor: ColorManager.bg,
        titleColor: ColorManager.black,
        withLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.9,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _CategoryCard(category: categories[index])
                    .animate()
                    .fadeIn(delay: (index * 100).ms, duration: 500.ms)
                    .scale(begin: const Offset(0.9, 0.9));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: const BoxDecoration(color: ColorManager.bg, shape: BoxShape.circle),
                child: Icon(category.icon, size: 40.sp, color: ColorManager.black.withOpacity(0.8)),
              ),
              SizedBox(height: 12.h),
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryModel {
  final String title;
  final IconData icon;

  CategoryModel({required this.title, required this.icon});
}
