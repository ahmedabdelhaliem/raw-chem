import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

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
        final String ingredients = currentRecipe.ingredients ?? '';
        final String measurements = currentRecipe.measurements ?? '';
        final String preparation = currentRecipe.preparationInstructions ?? '';

        return Scaffold(
          backgroundColor: ColorManager.bg,
          appBar: DefaultAppBar(
            text: 'تفاصيل الوصفة',
            backgroundColor: ColorManager.bg,
            titleColor: ColorManager.black,
            withLeading: context.locale.languageCode != 'ar',
            actions: context.locale.languageCode == 'ar'
                ? [
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.black),
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
                      title: 'الوصف :',
                      content: desc,
                      isLoading: isLoading,
                      delay: 300,
                    ),

                    // Ingredients
                    _buildSectionWithCopy(
                      context,
                      title: 'مكونات',
                      content: ingredients,
                      copyLabel: 'نسخ',
                      isLoading: isLoading,
                      delay: 400,
                    ),

                    // Measurements
                    _buildSectionWithCopy(
                      context,
                      title: 'القياسات',
                      content: measurements,
                      copyLabel: 'نسخ',
                      isLoading: isLoading,
                      delay: 500,
                    ),

                    // Preparation
                    _buildSectionWithCopy(
                      context,
                      title: 'تعليمات التحضير',
                      content: preparation,
                      copyLabel: 'نسخ',
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
                        color: ColorManager.bg.withOpacity(0.8),
                        blurRadius: 10,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: DefaultButtonWidget(
                    text: 'نسخ الوصفة الكاملة',
                    color: ColorManager.primary,
                    textColor: ColorManager.white,
                    radius: 12.r,
                    fontSize: 14.sp,
                    height: 50.h,
                    isIcon: true,
                    textFirst: true,
                    iconBuilder: Icon(Icons.copy_rounded, color: ColorManager.white, size: 20.sp),
                    onPressed: () {
                      final fullRecipe =
                          'الوصفة: $title\n\nالمكونات:\n$ingredients\n\nالقياسات:\n$measurements\n\nطريقة التحضير:\n$preparation';
                      Clipboard.setData(ClipboardData(text: fullRecipe));
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('تم نسخ الوصفة الكاملة بنجاح')));
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
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(color: ColorManager.primary)),
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
            textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
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
        _buildSection(context, title: title, content: content, isLoading: isLoading, delay: delay),
        if (!isLoading || content.isNotEmpty)
          Align(
            alignment: context.locale.languageCode == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: content));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('تم نسخ $title بنجاح')));
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
                    Icon(Icons.copy_rounded, color: ColorManager.primary, size: 16.sp),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: (delay + 100).ms).scale(),
        SizedBox(height: 20.h),
      ],
    );
  }
}
