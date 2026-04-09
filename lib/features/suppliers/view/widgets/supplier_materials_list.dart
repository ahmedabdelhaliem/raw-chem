import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/price_tracker/model/price_tracker_model.dart';
import 'package:raw_chem/features/suppliers/cubit/suppliers_materials_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'supplier_material_card.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';

class SupplierMaterialsList extends StatelessWidget {
  const SupplierMaterialsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuppliersMaterialsCubit, BaseState<PriceTrackerModel>>(
      builder: (context, state) {
        if (state.isLoading) {
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const _MaterialCardSkeleton(),
                childCount: 3,
              ),
            ),
          );
        }
        if (state.isSuccess) {
          if (state.items.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Text(
                    'No materials supplied by this supplier.',
                    style: TextStyle(color: ColorManager.greyTextColor, fontSize: 13.sp),
                  ),
                ),
              ),
            );
          }
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final model = state.items[index];
                  return SupplierMaterialCard(
                    model: model,
                    onTap: () {
                      context.push(
                        AppRouters.rawMaterialDetailsView,
                        extra: {
                          'material': model.toRawMaterial(),
                          'isFromPriceTracker': true,
                        },
                      );
                    },
                  )
                      .animate()
                      .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                      .slideX(begin: 0.1);
                },
                childCount: state.items.length,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _MaterialCardSkeleton extends StatelessWidget {
  const _MaterialCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
