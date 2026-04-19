import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/recipe_card_widget.dart';
import 'package:raw_chem/common/widgets/empty_state_widget.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/features/categories/cubit/category_materials_cubit.dart';
import 'package:raw_chem/features/categories/cubit/category_recipes_cubit.dart';


class CategoryItemsView extends StatefulWidget {
  final CategoryModel category;

  const CategoryItemsView({super.key, required this.category});

  @override
  State<CategoryItemsView> createState() => _CategoryItemsViewState();
}

class _CategoryItemsViewState extends State<CategoryItemsView> {
  final ScrollController _recipesScrollController = ScrollController();
  final ScrollController _materialsScrollController = ScrollController();

  @override
  void dispose() {
    _recipesScrollController.dispose();
    _materialsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => instance<CategoryMaterialsCubit>()..fetchItems(widget.category.id!),
        ),
        BlocProvider(
          create: (context) => instance<CategoryRecipesCubit>()..fetchItems(widget.category.id!),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorManager.bg,
          appBar: DefaultAppBar(
            text: widget.category.name ?? '',
            backgroundColor: ColorManager.bg,
            titleColor: ColorManager.black,
            withLeading: true,
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primary.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: ColorManager.white,
                  unselectedLabelColor: ColorManager.greyTextColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.box_1, size: 18.sp),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              AppStrings.rawMaterials.tr(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.task_square, size: 18.sp),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              AppStrings.recipes.tr(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildMaterialsTab(),
                    _buildRecipesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialsTab() {
    return BlocBuilder<CategoryMaterialsCubit, BaseState<RawMaterialModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return const _SkeletonGrid();
        } else if (state.isSuccess || state.isPaginationLoading || state.isPaginationFailure) {
          return PaginatedListWrapper(
            scrollController: _materialsScrollController,
            paginationHandler: context.read<CategoryMaterialsCubit>().paginationHandler,
            fetchFunction: (page, limit, [params]) => instance<CategoriesRepo>().getCategoryMaterials(
              categoryId: widget.category.id!,
              page: page,
            ),
            loadingWidget: const _SkeletonLoadingRow(),
            child: _buildMaterialsGrid(state.items),
          );
        } else if (state.isFailure) {
          final isNoInternet = state.failure is NetworkFailure;
          return DefaultErrorWidget(
            errorMessage: state.errorMessage ?? AppStrings.unknownError.tr(),
            imagePath: isNoInternet ? ImageAssets.noInternet : null,
            isLottie: !isNoInternet,
            buttonTitle: AppStrings.retry.tr(),
            onPressed: () => context.read<CategoryMaterialsCubit>().fetchItems(widget.category.id!),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRecipesTab() {
    return BlocBuilder<CategoryRecipesCubit, BaseState<RecipeModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return const _SkeletonGrid();
        } else if (state.isSuccess || state.isPaginationLoading || state.isPaginationFailure) {
          return PaginatedListWrapper(
            scrollController: _recipesScrollController,
            paginationHandler: context.read<CategoryRecipesCubit>().paginationHandler,
            fetchFunction: (page, limit, [params]) => instance<CategoriesRepo>().getCategoryRecipes(
              categoryId: widget.category.id!,
              page: page,
            ),
            loadingWidget: const _SkeletonLoadingRow(),
            child: _buildRecipesGrid(state.items),
          );
        } else if (state.isFailure) {
          final isNoInternet = state.failure is NetworkFailure;
          return DefaultErrorWidget(
            errorMessage: state.errorMessage ?? AppStrings.unknownError.tr(),
            imagePath: isNoInternet ? ImageAssets.noInternet : null,
            isLottie: !isNoInternet,
            buttonTitle: AppStrings.retry.tr(),
            onPressed: () => context.read<CategoryRecipesCubit>().fetchItems(widget.category.id!),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMaterialsGrid(List<RawMaterialModel> materials) {
    if (materials.isEmpty) {
      return EmptyStateWidget(
        onButtonPressed: () => context.read<CategoryMaterialsCubit>().fetchItems(widget.category.id!),
        buttonTitle: AppStrings.retry.tr(),
      );
    }


    return ListView.builder(
      controller: _materialsScrollController,
      padding: EdgeInsets.all(20.w),
      itemCount: (materials.length / 2).ceil(),
      itemBuilder: (context, index) {
        final startIndex = index * 2;
        final hasSecondItem = startIndex + 1 < materials.length;

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildMaterialCard(context, materials[startIndex], startIndex)),
                SizedBox(width: 12.w),
                if (hasSecondItem)
                  Expanded(child: _buildMaterialCard(context, materials[startIndex + 1], startIndex + 1))
                else
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaterialCard(BuildContext context, RawMaterialModel material, int index) {
    return RawMaterialCardWidget(
      imageUrl: material.image ?? '',
      title: material.name ?? '',
      category: material.family?.name ?? '',
      description: material.description ?? '',
      casNumber: material.casNumber ?? '',
      heroTag: 'cat_material_${material.id}',
      onTap: () {
        context.push(AppRouters.rawMaterialDetailsView, extra: material);
      },
    ).animate().fadeIn(delay: (50 * (index % 10)).ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildRecipesGrid(List<RecipeModel> recipes) {
    if (recipes.isEmpty) {
      return EmptyStateWidget(
        onButtonPressed: () => context.read<CategoryRecipesCubit>().fetchItems(widget.category.id!),
        buttonTitle: AppStrings.retry.tr(),
      );
    }


    return ListView.builder(
      controller: _recipesScrollController,
      padding: EdgeInsets.all(20.w),
      itemCount: (recipes.length / 2).ceil(),
      itemBuilder: (context, index) {
        final startIndex = index * 2;
        final hasSecondItem = startIndex + 1 < recipes.length;

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildRecipeCard(context, recipes[startIndex], startIndex)),
                SizedBox(width: 12.w),
                if (hasSecondItem)
                  Expanded(child: _buildRecipeCard(context, recipes[startIndex + 1], startIndex + 1))
                else
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecipeCard(BuildContext context, RecipeModel recipe, int index) {
    return RecipeCardWidget(
      imageUrl: recipe.image ?? '',
      title: recipe.name ?? '',
      category: widget.category.name ?? '',
      description: recipe.description ?? '',
      heroTag: 'cat_recipe_${recipe.id}',
      onTap: () {
        context.push(AppRouters.recipeDetailsView, extra: recipe);
      },
      onButtonTap: () {
        context.push(AppRouters.recipeDetailsView, extra: recipe);
      },
    ).animate().fadeIn(delay: (50 * (index % 10)).ms).scale(begin: const Offset(0.95, 0.95));
  }


}

class _SkeletonGrid extends StatelessWidget {
  const _SkeletonGrid();

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: true,
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) => const _SkeletonLoadingRow(),
      ),
    );
  }
}

class _SkeletonLoadingRow extends StatelessWidget {
  const _SkeletonLoadingRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(child: SkeletonCard(radius: 12)),
            SizedBox(width: 12.w),
            const Expanded(child: SkeletonCard(radius: 12)),
          ],
        ),
      ),
    );
  }
}
