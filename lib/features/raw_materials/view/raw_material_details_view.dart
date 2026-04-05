import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/raw_materials/view/widgets/packages_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class RawMaterialDetailsView extends StatelessWidget {
  final RawMaterialModel material;

  const RawMaterialDetailsView({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RawMaterialDetailsCubit, BaseState<RawMaterialModel>>(
      builder: (context, state) {
        final currentMaterial = state.isSuccess ? state.data! : material;
        final bool isLoading = state.isLoading;

        final String imageUrl =
            currentMaterial.image ??
            'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=300';
        final String title = currentMaterial.name ?? '';
        final String category = currentMaterial.family?.name ?? 'Category';
        final String description = currentMaterial.description ?? '';
        final String casNumber = currentMaterial.casNumber ?? '';

        // Placeholder for missing API fields

        return Scaffold(
          backgroundColor: ColorManager.bg,
          appBar: DefaultAppBar(
            text: AppStrings.productDetails.tr(),
            backgroundColor: ColorManager.bg,
            titleColor: ColorManager.black,
            withLeading: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Image
                Hero(
                  tag: 'raw_material_grid_${currentMaterial.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFFF3FAF0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: .25.sh,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.white, height: .25.sh),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Title & Category
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B3D2F),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F9D1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF4A7D2C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Description
                _buildInfoSection('الوصف :', description, isLoading: isLoading),
                SizedBox(height: 15.h),

                // Average Price

                // Meta Data
                _buildInfoSection('التفاصيل الفنية', '', isTitle: true, isLoading: false),
                SizedBox(height: 8.h),
                _buildInfoRow('CAS Number: ', casNumber, isLoading: isLoading),

                SizedBox(height: 40.h),

                // Action Buttons
                DefaultButtonWidget(
                  text: AppStrings.addToCart.tr(),
                  onPressed: () {
                    // TODO: Add cart logic
                  },
                  color: ColorManager.white,
                  textColor: const Color(0xFF006B3E),
                  withBorder: true,
                  borderColor: const Color(0xFF006B3E),
                  radius: 12.r,
                  height: 50.h,
                ),
                SizedBox(height: 15.h),
                DefaultButtonWidget(
                  text: AppStrings.contactSupplier.tr(),
                  onPressed: () {
                    PackagesBottomSheet.show(context);
                  },
                  color: const Color(0xFF006B3E),
                  textColor: Colors.white,
                  radius: 12.r,
                  height: 50.h,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(
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
            Text(
              content,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF1B3D2F), height: 1.5),
              textAlign: TextAlign.right,
            ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {required bool isLoading}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isLoading && value.isEmpty)
          SkeletonWidget(
            isLoading: true,
            child: SkeletonBar(width: 80.w, height: 14.h, radius: 4),
          )
        else
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3D2F),
            ),
          ),
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: const Color(0xFFB4B4CC)),
        ),
      ],
    );
  }
}
