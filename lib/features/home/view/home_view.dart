import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_banner_widget.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/recipe_card_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_skeleton.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<RecipesCubit>()..fetchRecipes()),
        BlocProvider(create: (context) => instance<RawMaterialsCubit>()..fetchMaterials()),
        BlocProvider(create: (context) => instance<BannersCubit>()..fetchBanners()),
        BlocProvider(create: (context) => instance<PriceTrackerCubit>()..fetchSupplierMaterials()),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.bg,
        appBar: AppBar(backgroundColor: ColorManager.bg, elevation: 0, toolbarHeight: 00.h),
        body: BlocBuilder<BannersCubit, BaseState<BannerModel>>(
          builder: (context, bannerState) {
            // we use BannersCubit as a primary indicator for home connectivity
            if (bannerState.isFailure && bannerState.failure is NetworkFailure) {
              return DefaultErrorWidget(
                errorMessage: bannerState.errorMessage ?? AppStrings.noInternetError.tr(),
                imagePath: ImageAssets.noInternet,
                isLottie: false,
                buttonTitle: AppStrings.retry.tr(),
                onPressed: () => _refreshAll(context),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _refreshAll(context),
              color: ColorManager.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                      child: _buildBanner(bannerState),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildSectionHeader(context, AppStrings.priceTracker.tr(), () {
                        context.push(AppRouters.priceTrackerView);
                      }),
                    ),
                    _buildPriceTrackerList(),
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
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Notification Icon with Premium look
        GestureDetector(
          onTap: () => context.push(AppRouters.notificationsSettingsView),
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.notifications_outlined, color: ColorManager.primary, size: 24.sp),
          ),
        ),

        // Logo
        Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80.h),
            child: Image.asset(ImageAssets.logoBlack, fit: BoxFit.contain),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2); // Slide down for header
  }

  Widget _buildBanner(BaseState<BannerModel> state) {
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
      if (banners.isEmpty) {
        // Show an empty placeholder banner area
        return AspectRatio(
          aspectRatio: 16 / 7,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.bg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorManager.greyBorder.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Icon(Icons.image_outlined, size: 40.sp, color: ColorManager.greyTextColor),
            ),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms);
      }
      return DefaultBannerWidget<BannerModel>(
        images: banners,
        imageUrl: (image) => image.banner ?? '',
        aspectRatio: 16 / 7,
      ).animate().fadeIn(delay: 400.ms, duration: 600.ms).scale(begin: const Offset(0.9, 0.9));
    }
    if (state.isFailure) {
      return Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.red.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: ColorManager.red, size: 30.sp),
            SizedBox(height: 8.h),
            Text(
              state.errorMessage ?? AppStrings.unknownError.tr(),
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> _refreshAll(BuildContext context) async {
    context.read<BannersCubit>().fetchBanners();
    context.read<RecipesCubit>().fetchRecipes();
    context.read<RawMaterialsCubit>().fetchMaterials();
    context.read<PriceTrackerCubit>().fetchSupplierMaterials();
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

  Widget _buildPriceTrackerList() {
    return BlocBuilder<PriceTrackerCubit, BaseState<PriceTrackerModel>>(
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
          final items = state.items;
          if (items.isEmpty) {
            return _buildSectionEmpty(AppStrings.noDataFound.tr());
          }

          final itemCount = items.length > 5 ? 5 : items.length;

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
                    final item = items[index];
                    final date = item.date != null
                        ? DateFormat(
                            'MMM dd, yyyy',
                          ).format(DateTime.tryParse(item.date!) ?? DateTime.now())
                        : '';

                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: SizedBox(
                        width: .58.sw,
                        child: GestureDetector(
                          onTap: () {
                            final material = RawMaterialModel(
                              id: item.id,
                              name: item.name,
                              casNumber: item.casNumber,
                              description: item.description,
                              image: item.image,
                              family: item.family,
                            );
                            context.push(
                              AppRouters.rawMaterialDetailsView,
                              extra: {'material': material, 'isFromPriceTracker': true},
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7FDF5),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: const Color(0xFFE2F9D1), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
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
                                        item.name ?? "Product",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF1B3D2F),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 14.sp,
                                          color: const Color(0xFFB4B4CC),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          date,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: const Color(0xFFB4B4CC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                if (item.family != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2F9D1),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      item.family?.name ?? '',
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
                                    Expanded(
                                      child: Text(
                                        "${AppStrings.source.tr()}: ${item.supplier?.name ?? ''}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: const Color(0xFF4A7D2C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.currentPrice.tr(),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color(0xFFB4B4CC),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "${AppStrings.egp.tr()}${item.price ?? item.averagePrice ?? ''}",
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
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        if (state.isFailure) {
          return _buildSectionError(
            state.errorMessage ?? AppStrings.unknownError.tr(),
            () => context.read<PriceTrackerCubit>().fetchSupplierMaterials(),
          );
        }
        return const SizedBox.shrink();
      },
    ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.1);
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
                      child: SizedBox(width: .58.sw, child: const RawMaterialSkeleton()),
                    );
                  }),
                ),
              ),
            ),
          );
        }
        if (state.isSuccess) {
          final materials = state.items;
          if (materials.isEmpty) {
            return _buildSectionEmpty(AppStrings.noItemsToDisplay.tr());
          }

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
        if (state.isFailure) {
          return _buildSectionError(
            state.errorMessage ?? AppStrings.unknownError.tr(),
            () => context.read<RawMaterialsCubit>().fetchMaterials(),
          );
        }
        return const SizedBox.shrink();
      },
    ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.1);
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
          if (recipes.isEmpty) {
            return _buildSectionEmpty(AppStrings.noItemsToDisplay.tr());
          }

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
                          category: '',
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
        if (state.isFailure) {
          return _buildSectionError(
            state.errorMessage ?? AppStrings.unknownError.tr(),
            () => context.read<RecipesCubit>().fetchRecipes(),
          );
        }
        return const SizedBox.shrink();
      },
    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).slideY(begin: 0.1);
  }

  Widget _buildSectionError(String message, VoidCallback onRetry) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.red.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: ColorManager.red, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorManager.blackText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: onRetry,
            icon: Icon(Icons.refresh_rounded, color: ColorManager.primary, size: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionEmpty(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined, color: ColorManager.lightGreyTextColor2, size: 40.sp),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 13.sp,
              color: ColorManager.greyTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
