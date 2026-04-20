import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_functions.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/raw_materials/view/widgets/packages_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class RawMaterialDetailsView extends StatelessWidget {
  final RawMaterialModel material;
  final bool isFromPriceTracker;

  const RawMaterialDetailsView({
    super.key,
    required this.material,
    this.isFromPriceTracker = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RawMaterialDetailsCubit, BaseState<RawMaterialModel>>(
      builder: (context, state) {
        final currentMaterial = state.isSuccess ? state.data! : material;
        final bool isLoading = state.isLoading;

        final String imageUrl = currentMaterial.image ?? '';
        final String title = currentMaterial.name ?? '';
        final String category = currentMaterial.family?.name ?? AppStrings.category.tr();
        final String description = currentMaterial.description ?? '';
        final String casNumber = currentMaterial.casNumber ?? '';

        // Placeholder for missing API fields

        return Scaffold(
          backgroundColor: ColorManager.bg,
          extendBodyBehindAppBar: true,
          appBar: DefaultAppBar(
            text: AppStrings.productDetails.tr(),
            backgroundColor: Colors.transparent,
            titleColor: ColorManager.black,
            withLeading: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Product Image Container
                Hero(
                  tag: 'raw_material_grid_${currentMaterial.id}',
                  child: Container(
                    width: double.infinity,
                    height: 0.4.sh,
                    color: const Color(0xFFF3FAF0),
                    child: imageUrl.isEmpty
                        ? Icon(
                            Icons.image_not_supported_outlined,
                            size: 60.sp,
                            color: Colors.grey[400],
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(color: Colors.white),
                            ),
                          ),
                  ),
                ),
                
                // Content Sheet
                Transform.translate(
                  offset: Offset(0, -30.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title Section
                        Center(
                          child: Column(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF1B3D2F),
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A7D2C).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: const Color(0xFF4A7D2C).withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF4A7D2C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Description Section
                        Row(
                          children: [
                            const Icon(Icons.description_outlined, color: Color(0xFF4A7D2C), size: 20),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.description.tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1B3D2F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorManager.greyTextColor,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 30.h),

                        // Info Cards Section
                        Column(
                          verticalDirection: VerticalDirection.down,
                          children: [
                            _buildInfoRow(
                              icon: Icons.tag_rounded,
                              label: AppStrings.casNumber.tr(),
                              value: casNumber,
                              isLoading: isLoading,
                              onCopy: () => AppFunctions.copyText(
                                  context: context, mounted: true, text: casNumber),
                            ),
                            if (currentMaterial.price != null) ...[
                              SizedBox(height: 12.h),
                              _buildInfoRow(
                                icon: Icons.payments_outlined,
                                label: AppStrings.currentPrice.tr(),
                                value: "${currentMaterial.price} ${AppStrings.egp.tr()}",
                                isLoading: isLoading,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 48.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: isFromPriceTracker
              ? Container(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: DefaultButtonWidget(
                    text: AppStrings.purchaseRequest.tr(),
                    color: ColorManager.primary,
                    textColor: ColorManager.white,
                    onPressed: () {
                      context.push(AppRouters.connectSupplierView, extra: currentMaterial.id);
                    },
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    String content, {
    bool isTitle = false,
    required bool isLoading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isTitle ? FontWeight.bold : FontWeight.w500,
            color: isTitle ? const Color(0xFF1B3D2F) : const Color(0xFFB4B4CC),
          ),
          textAlign: TextAlign.right,
        ),
        if (content.isNotEmpty || isLoading) ...[
          SizedBox(height: 8.h),
          if (isLoading && content.isEmpty)
            SkeletonWidget(
              isLoading: true,
              child: SkeletonBar(width: 200.w, height: 14.h, radius: 4),
            )
          else
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Text(
                content,
                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF1B3D2F), height: 1.5),
                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
              ),
            ),
        ],
      ],
    );
  }
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isLoading,
    VoidCallback? onCopy,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE8F2EE)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F9D1).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: const Color(0xFF4A7D2C), size: 20.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8A9992),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                if (isLoading && value.isEmpty)
                  SkeletonWidget(
                    isLoading: true,
                    child: SkeletonBar(width: 80.w, height: 14.h, radius: 4),
                  )
                else
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3D2F),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (onCopy != null && value.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCopy,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.copy_rounded,
                    size: 18.sp,
                    color: const Color(0xFF4A7D2C),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
