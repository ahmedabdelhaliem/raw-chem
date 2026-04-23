import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/profile/cubit/static_pages_cubit.dart';
import 'package:raw_chem/features/profile/model/static_page/static_page_model.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({super.key});

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  @override
  void initState() {
    super.initState();
    context.read<StaticPagesCubit>().getTerms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.termsAndConditions.tr(),
          style: TextStyle(
            color: ColorManager.blackText,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.blackText),
      ),
      body: BlocBuilder<StaticPagesCubit, BaseState<StaticPageData>>(
        builder: (context, state) {
          final data = state.data;
          
          if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.gavel_rounded, size: 60.sp, color: ColorManager.greyTextColor.withValues(alpha: 0.3)),
                   SizedBox(height: 16.h),
                   Text(state.errorMessage ?? AppStrings.unknownError.tr(), style: TextStyle(fontSize: 14.sp)),
                   TextButton(
                     onPressed: () => context.read<StaticPagesCubit>().getTerms(),
                     child: Text(AppStrings.retry.tr()),
                   ),
                ],
              ),
            );
          }

          return SkeletonWidget(
            isLoading: state.isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
              child: Column(
                children: [
                  // Primary Branding Header (Dynamic from API)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.primary.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImageAssets.logo,
                            height: 70.h,
                            width: 70.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9)),

                  // Terms Content Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(28.r),
                      border: Border.all(color: ColorManager.primary.withValues(alpha: 0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.03),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 5.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(2.r),
                                gradient: LinearGradient(
                                  colors: [ColorManager.primary, ColorManager.primary.withValues(alpha: 0.6)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                data?.title ?? AppStrings.termsAndConditions.tr(),
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w800,
                                  color: ColorManager.blackText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Divider(color: ColorManager.lightGrey2.withValues(alpha: 0.5), thickness: 0.8),
                        SizedBox(height: 20.h),
                        Text(
                          data?.description ?? '',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorManager.blackText.withValues(alpha: 0.7),
                            height: 1.8,
                          ),
                        ),
                        
                        if (data?.updatedAt != null) ...[
                          SizedBox(height: 40.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: ColorManager.bg,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified_rounded, size: 14.sp, color: ColorManager.primary),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "${AppStrings.lastUpdated.tr()}: ${data!.updatedAt}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: ColorManager.greyTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.05),

                  // Footer Notes
                  SizedBox(height: 50.h),
                  Text(
                    AppStrings.appName.tr(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: ColorManager.greyTextColor.withValues(alpha: 0.3),
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
