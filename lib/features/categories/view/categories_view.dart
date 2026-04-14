import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/empty_state_widget.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<CategoriesCubit>()..fetchCategories(),
      child: Scaffold(
        backgroundColor: ColorManager.bg,
        appBar: DefaultAppBar(
          text: AppStrings.categories.tr(),
          backgroundColor: ColorManager.bg,
          titleColor: ColorManager.black,
          withLeading: false,
        ),
        body: Column(
          children: [

            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const _CategoriesSkeleton();
                  } else if (state is CategoriesSuccess) {
                    final categories = state.categories;
                    if (categories.isEmpty) {
                      return EmptyStateWidget(
                        onButtonPressed: () => context.read<CategoriesCubit>().fetchCategories(),
                        buttonTitle: AppStrings.retry.tr(),
                      );
                    }
                    return GridView.builder(
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
                    );
                  } else if (state is CategoriesError) {
                    final isNoInternet = state.failure is NetworkFailure;
                    return DefaultErrorWidget(
                      errorMessage: state.failure.message,
                      imagePath: isNoInternet ? ImageAssets.noInternet : null,
                      isLottie: !isNoInternet,
                      buttonTitle: AppStrings.retry.tr(),
                      onPressed: () => context.read<CategoriesCubit>().fetchCategories(),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const _CategoryCard({required this.category});

  IconData _getIconForCategory(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('paint') || lowerName.contains('دهانات')) return Icons.format_paint_rounded;
    if (lowerName.contains('cosmetic') || lowerName.contains('مستحضرات')) return Icons.face_retouching_natural_rounded;
    if (lowerName.contains('detergent') || lowerName.contains('منظفات')) return Icons.sanitizer_rounded;
    return Icons.grid_view_rounded;
  }

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
          onTap: () {
            context.push(AppRouters.categoryItemsView, extra: category);
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: const BoxDecoration(color: ColorManager.bg, shape: BoxShape.circle),
                child: Icon(
                  _getIconForCategory(category.name ?? ''),
                  size: 40.sp,
                  color: ColorManager.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                category.name ?? '',
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

class _CategoriesSkeleton extends StatelessWidget {
  const _CategoriesSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: true,
      child: GridView.builder(
        padding: EdgeInsets.all(20.w),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 0.9,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const _CategorySkeletonCard(),
      ),
    );
  }
}

class _CategorySkeletonCard extends StatelessWidget {
  const _CategorySkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: const BoxDecoration(
              color: ColorManager.bg,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 80.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: ColorManager.bg,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
