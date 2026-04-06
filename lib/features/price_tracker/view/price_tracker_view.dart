import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';

class PriceTrackerView extends StatefulWidget {
  const PriceTrackerView({super.key});

  @override
  State<PriceTrackerView> createState() => _PriceTrackerViewState();
}

class _PriceTrackerViewState extends State<PriceTrackerView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PriceTrackerCubit>().fetchSupplierMaterials();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.priceTracker.tr(),
        backgroundColor: ColorManager.bg,
        titleColor: ColorManager.black,
        withLeading: false, // In MainView, so no leading usually
      ),
      body: Column(
        children: [
          _buildSearchSection(context),
          Expanded(
            child: BlocBuilder<PriceTrackerCubit, BaseState<PriceTrackerModel>>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const _PriceTrackerSkeleton();
                } else if (state.isSuccess ||
                    state.isPaginationLoading ||
                    state.isPaginationFailure) {
                  if (state.items.isEmpty) {
                    return Center(child: Text(AppStrings.noData.tr()));
                  }
                  return PaginatedListWrapper(
                    scrollController: _scrollController,
                    paginationHandler:
                        context.read<PriceTrackerCubit>().paginationHandler,
                    fetchFunction: (page, limit, [params]) => instance<PriceTrackerRepo>()
                        .getSupplierMaterials(page: page),
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage ?? AppStrings.unknownError.tr()),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          onPressed: () => context
                              .read<PriceTrackerCubit>()
                              .fetchSupplierMaterials(),
                          child: Text(AppStrings.retry.tr()),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                textAlign:
                    context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
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

    return Container(
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
          SizedBox(height: 6.h),
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
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  "${AppStrings.source.tr()}: ${model.supplier?.name ?? ''}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF4A7D2C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.priceTrend.tr(),
                        style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.trending_up_rounded, size: 16.sp, color: Colors.black),
                          SizedBox(width: 4.w),
                          Text(
                            AppStrings.up.tr(),
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
                  SizedBox(width: 25.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.currentPrice.tr(),
                        style: TextStyle(fontSize: 10.sp, color: const Color(0xFFB4B4CC)),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${AppStrings.egp.tr()}${model.averagePrice ?? ''}",
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
        ],
      ),
    );
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
