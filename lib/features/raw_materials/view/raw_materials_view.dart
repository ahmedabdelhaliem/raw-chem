import 'dart:async';

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

import 'package:raw_chem/common/widgets/filter_bottom_sheet_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_card_widget.dart';
import 'package:raw_chem/common/widgets/raw_material_skeleton.dart';
import 'package:raw_chem/features/raw_materials/cubit/raw_material_families_cubit.dart';

class RawMaterialsView extends StatefulWidget {
  const RawMaterialsView({super.key});

  @override
  State<RawMaterialsView> createState() => _RawMaterialsViewState();
}

class _RawMaterialsViewState extends State<RawMaterialsView> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<RawMaterialsCubit>()..fetchMaterials()),
        BlocProvider(
          create: (context) =>
              instance<RawMaterialFamiliesCubit>(), // Make sure it's fetching inside the cubit
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.bg,
        appBar: DefaultAppBar(
          text: AppStrings.rawMaterials.tr(),
          backgroundColor: ColorManager.bg,
          titleColor: ColorManager.black,
          withLeading: context.locale.languageCode != 'ar',
          actions: [
            if (context.locale.languageCode == 'ar')
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.black),
                onPressed: () => context.pop(),
              ),
          ],
        ),
        body: Column(
          children: [
            Builder(builder: (context) => _buildSearchSection(context)),
            Expanded(
              child: BlocBuilder<RawMaterialsCubit, BaseState<RawMaterialModel>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const _RawMaterialsSkeleton();
                  } else if (state.isSuccess ||
                      state.isPaginationLoading ||
                      state.isPaginationFailure) {
                    return PaginatedListWrapper(
                      scrollController: _scrollController,
                      paginationHandler: context.read<RawMaterialsCubit>().paginationHandler,
                      fetchFunction: (page, limit, [params]) =>
                          instance<RawMaterialsRepo>().getMaterials(
                            page: page,
                            materialFamilyIds: context.read<RawMaterialsCubit>().selectedFamilyIds,
                            q: context.read<RawMaterialsCubit>().searchQuery,
                          ),
                      loadingWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
                      ),
                      child: _buildMaterialsGrid(state.items),
                    );
                  } else if (state.isFailure) {
                    final isNoInternet = state.failure is NetworkFailure;
                    return DefaultErrorWidget(
                      errorMessage: state.errorMessage ?? AppStrings.unknownError.tr(),
                      imagePath: isNoInternet ? ImageAssets.noInternet : null,
                      isLottie: !isNoInternet,
                      buttonTitle: AppStrings.retry.tr(),
                      onPressed: () => context.read<RawMaterialsCubit>().fetchMaterials(),
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

  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          // Filter Icon
          BlocBuilder<RawMaterialFamiliesCubit, BaseState<MaterialFamilyModel>>(
            builder: (context, familiesState) {
              return GestureDetector(
                onTap: () async {
                  List<FilterItem> items = [];
                  if (familiesState.isSuccess) {
                    items = familiesState.items
                        .map((family) => FilterItem(id: family.id, title: family.name))
                        .toList();
                  }

                  final result = await FilterBottomSheetWidget.show(
                    context: context,
                    items: items,
                    initialSelectedIds: context.read<RawMaterialsCubit>().selectedFamilyIds,
                  );
                  if (result != null) {
                    context.read<RawMaterialsCubit>().fetchMaterials(familyIds: result);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.tune_rounded, color: ColorManager.black, size: 24.sp),
                ),
              );
            },
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
                    color: ColorManager.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(seconds: 2), () {
                    final text = value.trim();
                    // Check if the input contains a hyphen and consists only of digits/hyphens (valid CAS number pattern)
                    final isCasNumber = text.contains('-') && RegExp(r'^[\d-]+$').hasMatch(text) && text.isNotEmpty;

                    if (isCasNumber) {
                      context.read<RawMaterialsCubit>().fetchMaterials(query: '', casNumber: text);
                    } else {
                      context.read<RawMaterialsCubit>().fetchMaterials(query: text, casNumber: '');
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: AppStrings.searchMaterialsHint.tr(),
                  hintStyle: TextStyle(
                    color: ColorManager.greyTextColor.withValues(alpha: 0.5),
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

  Widget _buildMaterialsGrid(List<RawMaterialModel> materials) {
    if (materials.isEmpty) {
      return EmptyStateWidget(
        onButtonPressed: () => context.read<RawMaterialsCubit>().fetchMaterials(),
        buttonTitle: AppStrings.retry.tr(),
      );
    }


    return ListView.builder(
      controller: _scrollController,
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
                  Expanded(
                    child: _buildMaterialCard(context, materials[startIndex + 1], startIndex + 1),
                  )
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

          heroTag: 'raw_material_grid_${material.id}',
          onTap: () {
            context.push(AppRouters.rawMaterialDetailsView, extra: material);
          },
        )
        .animate()
        .fadeIn(delay: (index > 4 ? 50 : index * 50).ms, duration: 400.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

class _RawMaterialsSkeleton extends StatelessWidget {
  const _RawMaterialsSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: true,
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4, // 4 rows * 2 = 8 skeleton items
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: RawMaterialSkeleton()),
                SizedBox(width: 12.w),
                const Expanded(child: RawMaterialSkeleton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
