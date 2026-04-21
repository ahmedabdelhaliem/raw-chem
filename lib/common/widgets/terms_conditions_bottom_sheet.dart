import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/profile/cubit/static_pages_cubit.dart';
import 'package:raw_chem/features/profile/model/static_page/static_page_model.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';

class TermsConditionsBottomSheet extends StatelessWidget {
  final VoidCallback onAgree;

  const TermsConditionsBottomSheet({super.key, required this.onAgree});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onAgree,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider(
        create: (context) => instance<StaticPagesCubit>()..getTerms(),
        child: TermsConditionsBottomSheet(onAgree: onAgree),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.h),
            width: 50.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: ColorManager.lightGrey,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.termsAndConditions.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.blackText,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, color: ColorManager.greyTextColor),
                ),
              ],
            ),
          ),

          Divider(color: ColorManager.lightGrey.withValues(alpha: 0.5)),

          // Content
          Expanded(
            child: BlocBuilder<StaticPagesCubit, BaseState<StaticPageData>>(
              builder: (context, state) {
                if (state.isError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_rounded, color: Colors.red, size: 40.sp),
                        SizedBox(height: 10.h),
                        Text(state.errorMessage ?? AppStrings.unknownError.tr()),
                        TextButton(
                          onPressed: () => context.read<StaticPagesCubit>().getTerms(),
                          child: Text(AppStrings.retry.tr()),
                        ),
                      ],
                    ),
                  );
                }

                final data = state.data;

                return SkeletonWidget(
                  isLoading: state.isLoading,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data?.title != null)
                          Text(
                            data!.title!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primary,
                            ),
                          ),
                        SizedBox(height: 15.h),
                        Text(
                          data?.description ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorManager.blackText.withValues(alpha: 0.8),
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer Action
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
            child: DefaultButtonWidget(
              text: AppStrings.confirm.tr(),
              onPressed: () {
                onAgree();
                Navigator.pop(context);
              },
              color: ColorManager.primary,
              textColor: Colors.white,
              radius: 12.r,
            ),
          ),
        ],
      ),
    );
  }
}
