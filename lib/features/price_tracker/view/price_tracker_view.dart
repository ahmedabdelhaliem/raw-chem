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
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/empty_state_widget.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/common/widgets/filter_bottom_sheet_widget.dart';
import 'package:raw_chem/features/raw_materials/cubit/raw_material_families_cubit.dart';


class PriceTrackerView extends StatefulWidget {
  const PriceTrackerView({super.key});

  @override
  State<PriceTrackerView> createState() => _PriceTrackerViewState();
}

class _PriceTrackerViewState extends State<PriceTrackerView> {
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<PriceTrackerCubit>().fetchSupplierMaterials();
  }

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
        BlocProvider(create: (context) => instance<RawMaterialFamiliesCubit>()),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.bg,
        appBar: DefaultAppBar(
          text: AppStrings.priceTracker.tr(),
          backgroundColor: ColorManager.bg,
          titleColor: ColorManager.black,
          withLeading: false, // In MainView, so no leading usually
        ),
        body: Column(
          children: [
            Builder(builder: (context) => _buildSearchSection(context)),
            Expanded(
              child: BlocBuilder<PriceTrackerCubit, BaseState<PriceTrackerModel>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const _PriceTrackerSkeleton();
                  } else if (state.isSuccess ||
                      state.isPaginationLoading ||
                      state.isPaginationFailure) {
                    if (state.items.isEmpty) {
                      return EmptyStateWidget(
                        onButtonPressed: () =>
                            context.read<PriceTrackerCubit>().fetchSupplierMaterials(),
                        buttonTitle: AppStrings.retry.tr(),
                      );
                    }

                    final cubit = context.read<PriceTrackerCubit>();

                    return PaginatedListWrapper(
                      scrollController: _scrollController,
                      paginationHandler: cubit.paginationHandler,
                      fetchFunction: (page, limit, [params]) =>
                          instance<PriceTrackerRepo>().getSupplierMaterials(
                        page: page,
                        q: cubit.searchQuery,
                        casNumber: cubit.casNumberString,
                        materialFamilyIds: cubit.selectedFamilyIds,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          return PriceTrackerCard(model: state.items[index])
                              .animate()
                              .fadeIn(
                                  delay: (index > 4 ? 50 : index * 50).ms, duration: 400.ms)
                              .slideX(begin: 0.1);
                        },
                      ),
                    );
                  } else if (state.isError) {
                    final isNoInternet = state.failure is NetworkFailure;
                    return DefaultErrorWidget(
                      errorMessage: state.errorMessage ?? AppStrings.unknownError.tr(),
                      imagePath: isNoInternet ? ImageAssets.noInternet : null,
                      isLottie: !isNoInternet,
                      buttonTitle: AppStrings.retry.tr(),
                      onPressed: () => context.read<PriceTrackerCubit>().fetchSupplierMaterials(),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                    initialSelectedIds: context.read<PriceTrackerCubit>().selectedFamilyIds,
                  );
                  if (!context.mounted) return;
                  if (result != null) {
                    context.read<PriceTrackerCubit>().fetchSupplierMaterials(familyIds: result);
                  }
                },
                child: Container(
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
              );
            },
          ),
          SizedBox(width: 10.w),
          // Search Bar
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
                textAlign:
                    context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(seconds: 2), () {
                    final text = value.trim();
                    // Check if the input is only digits and/or hyphens (valid CAS number pattern)
                    final isCasNumber = RegExp(r'^[\d-]+$').hasMatch(text) && text.isNotEmpty;

                    if (isCasNumber) {
                      context.read<PriceTrackerCubit>().fetchSupplierMaterials(query: '', casNumber: text);
                    } else {
                      context.read<PriceTrackerCubit>().fetchSupplierMaterials(query: text, casNumber: '');
                    }
                  });
                },
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
        ],
      ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
    );
  }
}

class PriceTrackerCard extends StatelessWidget {
  final PriceTrackerModel model;

  const PriceTrackerCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final date = model.date != null
        ? DateFormat('MMM dd, yyyy').format(DateTime.tryParse(model.date!) ?? DateTime.now())
        : '';

    return GestureDetector(
      onTap: () {
        final material = RawMaterialModel(
          id: model.id,
          name: model.name,
          casNumber: model.casNumber,
          description: model.description,
          image: model.image,
          family: model.family,
        );
        context.push(
          AppRouters.rawMaterialDetailsView,
          extra: {
            'material': material,
            'isFromPriceTracker': true,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FDF5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2F9D1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
                  model.name ?? "Sodium Lauryl Sulfate (SLS)",
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
                  Icon(Icons.calendar_today_outlined,
                      size: 14.sp, color: const Color(0xFFB4B4CC)),
                  SizedBox(width: 4.w),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFFB4B4CC)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (model.family != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F9D1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    model.family?.name ?? '',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4A7D2C),
                    ),
                  ),
                ),
              if (model.casNumber != null && model.casNumber!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ColorManager.greyTextColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "${AppStrings.casNumber.tr()}: ${model.casNumber}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.greyTextColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.source.tr(),
                      style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      model.supplier?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF4A7D2C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.currentPrice.tr(),
                      style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                    ),
                    SizedBox(height: 4.h),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${AppStrings.egp.tr()}${model.price ?? model.averagePrice ?? ''}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class _PriceTrackerSkeleton extends StatelessWidget {
  const _PriceTrackerSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: true,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: SizedBox(
              width: double.infinity,
              height: 120.h,
              child: const SkeletonCard(radius: 12),
            ),
          );
        },
      ),
    );
  }
}
