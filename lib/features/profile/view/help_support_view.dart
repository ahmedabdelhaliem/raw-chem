import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_bar.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';
import 'package:raw_chem/features/profile/cubit/faq_cubit.dart';
import 'package:raw_chem/features/profile/model/faq/faq_model.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  @override
  void initState() {
    super.initState();
    context.read<FaqCubit>().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.help.tr(),
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
      body: BlocBuilder<FaqCubit, BaseState<List<FaqModel>>>(
        builder: (context, state) {
          final faqs = state.data ?? [];

          if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? "An error occurred"),
                  TextButton(
                    onPressed: () => context.read<FaqCubit>().getFaqs(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FAQ Section
                Text(
                  'الأسئلة الشائعة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.blackText,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: state.isLoading && faqs.isEmpty
                      ? _buildSkeletonList()
                      : faqs.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(20.w),
                          child: const Center(child: Text("No questions available")),
                        )
                      : Column(
                          children: List.generate(
                            faqs.length,
                            (index) => Column(
                              children: [
                                _buildFaqItem(
                                  question: faqs[index].question,
                                  answer: faqs[index].answer,
                                ),
                                if (index != faqs.length - 1)
                                  Divider(
                                    height: 1,
                                    color: ColorManager.lightGrey2.withOpacity(0.5),
                                  ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonList() {
    return SkeletonWidget(
      isLoading: true,
      child: Column(
        children: List.generate(
          5,
          (index) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBar(width: 200.w, height: 14.h),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
              ),
              if (index != 4) Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ExpansionTile(
        title: Text(
          question,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.blackText,
          ),
        ),
        iconColor: ColorManager.primary,
        collapsedIconColor: ColorManager.greyTextColor,
        expandedAlignment: Alignment.centerRight,
        childrenPadding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              answer,
              style: TextStyle(fontSize: 13.sp, color: ColorManager.greyTextColor, height: 1.6),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
