import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_banner_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/recipe_card_widget.dart';
import 'package:raw_chem/features/home/view/widgets/supplier_card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<RecipesCubit>()..fetchRecipes()),
        BlocProvider(create: (context) => instance<RawMaterialsCubit>()..fetchMaterials()),
        BlocProvider(create: (context) => instance<BannersCubit>()..fetchBanners()),
        BlocProvider(create: (context) => instance<SuppliersCubit>()..fetchSuppliers()),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.bg,
        appBar: AppBar(backgroundColor: ColorManager.bg, elevation: 0, toolbarHeight: 00.h),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildHeader(context),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildSearchBar(context),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildBanner(),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildSectionHeader(context, AppStrings.suppliers.tr(), () {
                  context.push(AppRouters.suppliersView);
                }),
              ),
              _buildSuppliersList(),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildSectionHeader(context, AppStrings.rawMaterials.tr(), () {
                  context.push(AppRouters.rawMaterialsView);
                }),
              ),
              _buildRawMaterialsList(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildSectionHeader(context, AppStrings.recipes.tr(), () {
                  context.push(AppRouters.recipesView);
                }),
              ),
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
            context.push(AppRouters.cartView);
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
    return BlocBuilder<BannersCubit, BaseState<BannerModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return DefaultBannerWidget<BannerModel>(
            images: const [],
            imageUrl: (image) => '',
            isLoading: true,
            aspectRatio: 16 / 7,
          );
        }
        if (state.isSuccess) {
          final banners = state.items;
          if (banners.isEmpty) return const SizedBox.shrink();
          return DefaultBannerWidget<BannerModel>(
            images: banners,
            imageUrl: (image) => image.banner ?? '',
            aspectRatio: 16 / 7,
          ).animate().scale(delay: 200.ms, duration: 500.ms);
        }
        return const SizedBox.shrink();
      },
    );
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
    return BlocBuilder<SuppliersCubit, BaseState<SupplierModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(width: .53.sw, child: const SkeletonCard(radius: 12)),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        if (state.isSuccess) {
          final suppliers = state.items;
          if (suppliers.isEmpty) return const SizedBox.shrink();

          final itemCount = suppliers.length > 5 ? 5 : suppliers.length;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(itemCount, (index) {
                    final supplier = suppliers[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SupplierCardWidget(
                        name: supplier.name ?? '',
                        address: supplier.address,
                        desc: supplier.desc,
                        imageUrl: supplier.image ?? '',
                      ),
                    );
                  }),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRawMaterialsList(BuildContext context) {
    return BlocBuilder<RawMaterialsCubit, BaseState<RawMaterialModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(width: .58.sw, child: const SkeletonCard(radius: 12)),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        if (state.isSuccess) {
          final materials = state.items;
          if (materials.isEmpty) return const SizedBox.shrink();

          final itemCount = materials.length > 5 ? 5 : materials.length;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(itemCount, (index) {
                    final material = materials[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(
                        width: .58.sw,
                        child: RawMaterialCardWidget(
                          imageUrl: material.image ?? '',
                          title: material.name ?? '',
                          category: material.family?.name ?? '',
                          description: material.description ?? '',
                          casNumber: material.casNumber ?? '',
                          heroTag: 'raw_material_home_${material.id}',
                          onTap: () {
                            context.push(AppRouters.rawMaterialDetailsView, extra: material);
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }

  Widget _buildRecipesList(BuildContext context) {
    return BlocBuilder<RecipesCubit, BaseState<RecipeModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(width: .6.sw, child: const SkeletonCard(radius: 12)),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        if (state.isSuccess) {
          final recipes = state.items;
          if (recipes.isEmpty) return const SizedBox.shrink();

          final itemCount = recipes.length > 5 ? 5 : recipes.length;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(itemCount, (index) {
                    final recipe = recipes[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(
                        width: .6.sw,
                        child: RecipeCardWidget(
                          imageUrl: recipe.image ?? '',
                          title: recipe.name ?? '',
                          category: 'Default',
                          description: recipe.description ?? '',
                          heroTag: 'recipe_home_${recipe.id}',
                          onButtonTap: () {
                            context.push(AppRouters.recipeDetailsView, extra: recipe);
                          },
                          onTap: () {
                            context.push(AppRouters.recipeDetailsView, extra: recipe);
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms);
  }
}
