import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'widgets/supplier_bottom_actions.dart';
import 'widgets/supplier_contact_section.dart';
import 'widgets/supplier_materials_list.dart';
import 'widgets/supplier_sliver_app_bar.dart';

class SupplierDetailsView extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetailsView({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SupplierSliverAppBar(supplier: supplier),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _buildSectionTitle(AppStrings.aboutUs.tr()),
                  SizedBox(height: 12.h),
                  Text(
                    supplier.desc ?? AppStrings.noDescription.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.greyTextColor.withValues(alpha: 0.8),
                      height: 1.6,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(AppStrings.contactDetails.tr()),
                  SizedBox(height: 16.h),
                  SupplierContactSection(supplier: supplier),
                  SizedBox(height: 32.h),
                  _buildSectionTitle(AppStrings.suppliedMaterials.tr()),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          const SupplierMaterialsList(),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
      bottomNavigationBar: SupplierBottomActions(supplier: supplier),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w800,
        color: ColorManager.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}
