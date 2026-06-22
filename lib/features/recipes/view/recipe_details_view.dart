import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_functions.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class RecipeDetailsView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailsView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsCubit, BaseState<RecipeModel>>(
      builder: (context, state) {
        final currentRecipe = state.isSuccess ? state.data! : recipe;
        final bool isLoading = state.isLoading;

        final String imageUrl = currentRecipe.image ?? '';
        final String title = currentRecipe.name ?? '';
        // final String category = 'Default';

        final String desc = currentRecipe.description ?? '';
        final List<RecipeIngredientModel> ingredients =
            currentRecipe.ingredients ?? [];
        final String measurements = currentRecipe.measurements ?? '';
        final String preparation = currentRecipe.preparationInstructions ?? '';

        return Scaffold(
          backgroundColor: ColorManager.bg,
          appBar: DefaultAppBar(
            text: AppStrings.recipeDetails.tr(),
            backgroundColor: ColorManager.bg,
            titleColor: ColorManager.black,
            withLeading: context.locale.languageCode != 'ar',
            actions: context.locale.languageCode == 'ar'
                ? [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorManager.black,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ]
                : null,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Image
                    Hero(
                      tag: 'recipe_grid_${currentRecipe.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: _buildMainImage(imageUrl),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Title and Category
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primary,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                    SizedBox(height: 10.h),

                    // Description
                    _buildSection(
                      context,
                      title: '${AppStrings.description.tr()} :',
                      content: desc,
                      isLoading: isLoading,
                      delay: 300,
                    ),

                    // Ingredients
                    _buildIngredientsSection(
                      context,
                      ingredients: ingredients,
                      isLoading: isLoading,
                      delay: 400,
                    ),

                    // Measurements

                    // Preparation
                    _buildSectionWithCopy(
                      context,
                      title: AppStrings.preparationInstructions.tr(),
                      content: preparation,
                      copyLabel: AppStrings.copy.tr(),
                      isLoading: isLoading,
                      delay: 600,
                    ),
                  ],
                ),
              ),

              // Sticky Bottom Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                  decoration: BoxDecoration(
                    color: ColorManager.bg,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.bg.withValues(alpha: 0.8),
                        blurRadius: 10,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: DefaultButtonWidget(
                    text: AppStrings.copyFullRecipe.tr(),
                    color: ColorManager.primary,
                    textColor: ColorManager.white,
                    radius: 12.r,
                    fontSize: 14.sp,
                    height: 50.h,
                    isIcon: true,
                    textFirst: true,
                    iconBuilder: Icon(
                      Icons.copy_rounded,
                      color: ColorManager.white,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      final formattedIngredients = ingredients
                          .map((item) {
                            final formula = item.chemicalFormula ?? '';
                            final name = item.chemicalName ?? '';
                            final trade = item.tradeName ?? '';
                            final pct = item.percentage ?? '';
                            return '$formula - $name - $trade - $pct%';
                          })
                          .join('\n');
                      final fullRecipe =
                          '${AppStrings.recipe.tr()}: $title\n\n${AppStrings.ingredients.tr()}:\n$formattedIngredients\n\n${AppStrings.measurements.tr()}:\n$measurements\n\n${AppStrings.preparationInstructions.tr()}:\n$preparation';
                      AppFunctions.copyText(
                        context: context,
                        mounted: true,
                        text: fullRecipe,
                      );
                    },
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainImage(String imageUrl) {
    return Container(
      height: 160.h,
      width: double.infinity,
      color: const Color(0xffF0F7FF),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: ColorManager.primary),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: ColorManager.greyTextColor),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    required bool isLoading,
    required int delay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: ColorManager.greyTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5.h),
        if (isLoading && content.isEmpty)
          SkeletonWidget(
            isLoading: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBar(width: 250.w, height: 14.h, radius: 4),
                SizedBox(height: 5.h),
                SkeletonBar(width: 200.w, height: 14.h, radius: 4),
                SizedBox(height: 5.h),
                SkeletonBar(width: 150.w, height: 14.h, radius: 4),
              ],
            ),
          )
        else
          Text(
            content,
            style: TextStyle(
              fontSize: 13.sp,
              color: ColorManager.black,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
            textAlign: context.locale.languageCode == 'ar'
                ? TextAlign.right
                : TextAlign.left,
          ),
        SizedBox(height: 15.h),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }

  Widget _buildSectionWithCopy(
    BuildContext context, {
    required String title,
    required String content,
    required String copyLabel,
    required bool isLoading,
    required int delay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSection(
          context,
          title: title,
          content: content,
          isLoading: isLoading,
          delay: delay,
        ),
        if (!isLoading || content.isNotEmpty)
          Align(
            alignment: context.locale.languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                AppFunctions.copyText(
                  context: context,
                  mounted: true,
                  text: content,
                );
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffD2E8B1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      copyLabel,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primary,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.copy_rounded,
                      color: ColorManager.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: (delay + 100).ms).scale(),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildIngredientsSection(
    BuildContext context, {
    required List<RecipeIngredientModel> ingredients,
    required bool isLoading,
    required int delay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.ingredients.tr(),
          style: TextStyle(
            fontSize: 12.sp,
            color: ColorManager.greyTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        _buildIngredientsTable(context, ingredients, isLoading),
        SizedBox(height: 10.h),
        if (!isLoading || ingredients.isNotEmpty)
          Align(
            alignment: context.locale.languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                final formattedIngredients = ingredients
                    .map((item) {
                      final formula = item.chemicalFormula ?? '';
                      final name = item.chemicalName ?? '';
                      final trade = item.tradeName ?? '';
                      final pct = item.percentage ?? '';
                      return '$formula - $name - $trade - $pct%';
                    })
                    .join('\n');
                AppFunctions.copyText(
                  context: context,
                  mounted: true,
                  text: formattedIngredients,
                );
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffD2E8B1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.copy.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primary,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.copy_rounded,
                      color: ColorManager.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: (delay + 100).ms).scale(),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildIngredientsTable(
    BuildContext context,
    List<RecipeIngredientModel> ingredients,
    bool isLoading,
  ) {
    if (isLoading && ingredients.isEmpty) {
      return SkeletonWidget(
        isLoading: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBar(width: double.infinity, height: 40.h, radius: 8.r),
            SizedBox(height: 10.h),
            SkeletonBar(width: double.infinity, height: 35.h, radius: 8.r),
            SizedBox(height: 5.h),
            SkeletonBar(width: double.infinity, height: 35.h, radius: 8.r),
            SizedBox(height: 5.h),
            SkeletonBar(width: double.infinity, height: 35.h, radius: 8.r),
          ],
        ),
      );
    }

    if (ingredients.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            AppStrings.noDataFound.tr(),
            style: TextStyle(
              fontSize: 12.sp,
              color: ColorManager.greyTextColor,
            ),
          ),
        ),
      );
    }

    // Build the table
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.greyBorder, width: 1.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Table(
          border: TableBorder(
            verticalInside: BorderSide(
              color: ColorManager.greyBorder.withValues(alpha: 0.6),
              width: 1.r,
            ),
            horizontalInside: BorderSide(
              color: ColorManager.greyBorder.withValues(alpha: 0.4),
              width: 1.r,
            ),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1.6), // Chemical Name (long)
            1: FlexColumnWidth(1.4), // Trade Name (medium)
            2: FlexColumnWidth(0.7), // Percentage (very short)
            3: FlexColumnWidth(1.4), // Chem// Chemical Formula / Notes (short)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // Header Row
            TableRow(
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.06),
              ),
              children: [
                _buildHeaderCell(
                  AppStrings.chemicalName.tr(),
                  context,
                  isShort: false,
                ),
                _buildHeaderCell(
                  AppStrings.tradeName.tr(),
                  context,
                  isShort: false,
                ),
                _buildHeaderCell(
                  AppStrings.percentage.tr(),
                  context,
                  isShort: true,
                ),
                _buildHeaderCell(
                  AppStrings.chemicalFormula.tr(),
                  context,
                  isShort: true,
                ),
              ],
            ),
            // Data Rows
            ...List.generate(ingredients.length, (index) {
              final item = ingredients[index];
              final isOdd = index % 2 != 0;
              return TableRow(
                decoration: BoxDecoration(
                  color: isOdd ? ColorManager.fillColor : ColorManager.white,
                ),
                children: [
                  _buildDataCell(
                    item.chemicalName ?? '',
                    context,
                    isShort: false,
                  ),
                  _buildDataCell(item.tradeName ?? '', context, isShort: false),
                  _buildDataCell(
                    item.percentage != null ? '${item.percentage}%' : '',
                    context,
                    isShort: true,
                    isBold: true,
                    textColor: ColorManager.primary,
                  ),
                  _buildDataCell(
                    item.chemicalFormula ?? '',
                    context,
                    isShort: true,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(
    String text,
    BuildContext context, {
    required bool isShort,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: ColorManager.primary,
          fontFamily: 'Rubik',
        ),
        textAlign: isShort
            ? TextAlign.center
            : (context.locale.languageCode == 'ar'
                  ? TextAlign.right
                  : TextAlign.left),
      ),
    );
  }

  Widget _buildDataCell(
    String text,
    BuildContext context, {
    required bool isShort,
    bool isBold = false,
    Color? textColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: textColor ?? ColorManager.textColor,
          fontFamily: 'Rubik',
        ),
        textAlign: isShort
            ? TextAlign.center
            : (context.locale.languageCode == 'ar'
                  ? TextAlign.right
                  : TextAlign.left),
      ),
    );
  }
}
