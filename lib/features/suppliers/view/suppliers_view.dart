import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/features/home/view/widgets/supplier_card_widget.dart';
import 'package:raw_chem/features/suppliers/cubit/suppliers_cubit.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';
import 'package:raw_chem/features/suppliers/repo/suppliers_repo.dart';

class SuppliersView extends StatefulWidget {
  const SuppliersView({super.key});

  @override
  State<SuppliersView> createState() => _SuppliersViewState();
}

class _SuppliersViewState extends State<SuppliersView> {
  final ScrollController _scrollController = ScrollController();

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
        text: AppStrings.suppliers.tr(),
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
          _buildSearchSection(context),
          Expanded(
            child: BlocBuilder<SuppliersCubit, BaseState<SupplierModel>>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const _SuppliersSkeleton();
                } else if (state.isSuccess || state.isPaginationLoading || state.isPaginationFailure) {
                  if (state.items.isEmpty) {
                    return Center(child: Text(AppStrings.noData.tr()));
                  }
                  return PaginatedListWrapper(
                    scrollController: _scrollController,
                    paginationHandler: context.read<SuppliersCubit>().paginationHandler,
                    fetchFunction: (page, limit, [params]) => instance<SuppliersRepo>().getSuppliers(page: page),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final supplier = state.items[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: SupplierCardWidget(
                            width: double.infinity,
                            name: supplier.name ?? '',
                            address: supplier.address,
                            desc: supplier.desc,
                            imageUrl: supplier.image ?? '',
                          ).animate().fadeIn(delay: (index > 4 ? 50 : index * 50).ms, duration: 400.ms).slideX(begin: 0.1),
                        );
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
                          onPressed: () => context.read<SuppliersCubit>().fetchSuppliers(),
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
                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
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

class _SuppliersSkeleton extends StatelessWidget {
  const _SuppliersSkeleton();

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
              height: 100.h,
              child: const SkeletonCard(radius: 12),
            ),
          );
        },
      ),
    );
  }
}
