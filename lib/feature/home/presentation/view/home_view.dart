import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_banner_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/recipe_card_widget.dart';
import 'package:raw_chem/feature/cart/presentation/view/cart_view.dart';
import 'package:raw_chem/feature/raw_materials/presentation/view/raw_materials_view.dart';
import 'package:raw_chem/feature/recipes/presentation/view/recipe_details_view.dart';
import 'package:raw_chem/feature/recipes/presentation/view/recipes_view.dart';

import 'widgets/supplier_card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              _buildHeader(context),
              SizedBox(height: 10.h),
              _buildSearchBar(context),
              SizedBox(height: 10.h),
              _buildBanner(),
              SizedBox(height: 10.h),
              _buildSectionHeader(context, AppStrings.suppliers.tr(), () {}),
              SizedBox(height: 4.h),
              _buildSuppliersList(),
              SizedBox(height: 10.h),
              _buildSectionHeader(context, AppStrings.rawMaterials.tr(), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RawMaterialsView()),
                );
              }),
              SizedBox(height: 10.h),
              _buildRawMaterialsList(),
              SizedBox(height: 10.h),
              _buildSectionHeader(context, AppStrings.recipes.tr(), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipesView()),
                );
              }),
              SizedBox(height: 10.h),
              _buildRecipesList(context),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80.h),
            child: Image.asset(ImageAssets.logoBlack, fit: BoxFit.contain),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
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
                Icon(Icons.shopping_cart_outlined, color: ColorManager.black, size: 24.sp),
                Positioned(
                  top: -2.h,
                  right: -2.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: Color(0xFF006B3E),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1);
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
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
        textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          hintText: AppStrings.search.tr(),
          hintStyle: TextStyle(color: ColorManager.grey, fontSize: 14.sp),
          prefixIcon: const Icon(Icons.search, color: ColorManager.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 500.ms);
  }

  Widget _buildBanner() {
    return DefaultBannerWidget<String>(
      images: const ['https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=600'],
      imageUrl: (image) => image,
      title: (image) => AppStrings.bannerTitle.tr(),
      isSpecialOffer: (image) => true,
      aspectRatio: 16 / 7,
    ).animate().scale(delay: 200.ms, duration: 500.ms);
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onMoreTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackText,
          ),
        ),
        TextButton(
          onPressed: onMoreTap,
          child: Text(
            AppStrings.viewMore.tr(),
            style: TextStyle(fontSize: 14.sp, color: ColorManager.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildSuppliersList() {
    return SizedBox(
      height: .105.sh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          return const SupplierCardWidget(
            name: 'ايجيبت كيم الصناعية',
            rating: '4.9',
            location: 'مدينة السادات',
            products: 'الزيوليت، كبريتات الصوديوم، الإنزيمات، STPP',
            imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=200',
          );
        },
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }

  Widget _buildRawMaterialsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(4, (index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 15.w),
                child: SizedBox(
                  width: .58.sw,
                  child: RawMaterialCardWidget(
                    imageUrl:
                        'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=300',
                    title: 'حمض ألكيل بنزين السلفونيك الخطي (LABSA)',
                    category: 'مادة فعالة سطحياً',
                    description:
                        'يوفر تغلغل سطح الأميل الممتلئ بشكل قوي، وهو المكون الأساسي لمنظفات الغسيل.',
                    casNumber: '25155-30-0',
                    averagePrice: '1200 جنية - 1100 جنية',
                    supplier: 'دلتا للحلول الكيميائية',
                    heroTag: 'raw_material_home_$index',
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }

  Widget _buildRecipesList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(4, (index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 15.w),
                child: SizedBox(
                  width: .6.sw,
                  child: RecipeCardWidget(
                    imageUrl:
                        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=300',
                    title: 'مسحوق الغسيل الاقتصادي',
                    category: 'منظفات الغسيل',
                    description: 'منظف فعال وبأسعار مناسبة مصمم للاستخدام اليومي وبكميات كبيرة.',
                    heroTag: 'recipe_home_$index',
                    onButtonTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailsView(heroTag: 'recipe_home_$index'),
                        ),
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailsView(heroTag: 'recipe_home_$index'),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms);
  }
}
