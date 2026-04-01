import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
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
        backgroundColor: ColorManager.white,
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
                   Text(state.errorMessage ?? "An error occurred"),
                   TextButton(
                     onPressed: () => context.read<StaticPagesCubit>().getAboutUs(),
                     child: const Text("Retry"),
                   )
                ],
              ),
            );
          }

          return SkeletonWidget(
            isLoading: state.isLoading,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: [
                  if (data?.banner != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        data!.banner!,
                        width: double.infinity,
                        height: 150.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150.h,
                          color: ColorManager.lightGrey,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.title ?? 'About Raw Chem',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          data?.description ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorManager.greyTextColor,
                            height: 1.5,
                          ),
                        ),
                        if (data?.updatedAt != null) ...[
                          SizedBox(height: 24.h),
                          Divider(color: ColorManager.lightGrey2.withOpacity(0.5)),
                          SizedBox(height: 12.h),
                          Text(
                            "${"Last updated"}: ${data!.updatedAt}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorManager.greyTextColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
