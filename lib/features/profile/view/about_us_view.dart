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

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  void initState() {
    super.initState();
    context.read<StaticPagesCubit>().getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUs.tr(),
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
                   Icon(Icons.error_outline, size: 60.sp, color: ColorManager.red),
                   SizedBox(height: 16.h),
                   Text(
                     state.errorMessage ?? AppStrings.unknownError.tr(),
                     style: TextStyle(fontSize: 14.sp, color: ColorManager.greyTextColor),
                   ),
                   SizedBox(height: 20.h),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: ColorManager.primary,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                     ),
                     onPressed: () => context.read<StaticPagesCubit>().getAboutUs(),
                     child: Text(AppStrings.retry.tr(), style: const TextStyle(color: Colors.white)),
                   )
                ],
              ).animate().fadeIn(),
            );
          }

          return SkeletonWidget(
            isLoading: state.isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h), // Added bottom spacing for Nav Bar
              child: Column(
                children: [
                  // Primary Branding Section (using API banner)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.primary.withValues(alpha: 0.1),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              ImageAssets.logo,
                              height: 80.h,
                              width: 80.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9)),

                  // Description Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.04),
                          blurRadius: 20,
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
                                data?.title ?? AppStrings.aboutUs.tr(),
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
                        Text(
                          data?.description ?? '',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorManager.blackText.withValues(alpha: 0.75),
                            height: 1.8,
                          ),
                        ),
                        
                        if (data?.updatedAt != null) ...[
                          SizedBox(height: 32.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: ColorManager.bg,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.history_rounded, size: 14.sp, color: ColorManager.greyTextColor),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "${AppStrings.lastUpdated.tr()}: ${data!.updatedAt}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: ColorManager.greyTextColor,
                                      fontWeight: FontWeight.w500,
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
                  
                  // Bottom Branding (Subtle watermark)
                  SizedBox(height: 50.h),
                  Text(
                    AppStrings.appName.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: ColorManager.greyTextColor.withValues(alpha: 0.2),
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
