import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_bar.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';
import 'package:raw_chem/features/profile/cubit/faq_cubit.dart';
import 'package:raw_chem/features/profile/cubit/settings_cubit.dart';
import 'package:raw_chem/features/profile/model/faq/faq_model.dart';
import 'package:raw_chem/features/profile/model/settings/settings_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
    context.read<SettingsCubit>().getSettings();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // If no app handles this URL, silently ignore
    }
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
        backgroundColor: ColorManager.bg,
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
                  Icon(
                    Icons.help_center_outlined,
                    size: 60.sp,
                    color: ColorManager.greyTextColor.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.errorMessage ?? AppStrings.unknownError.tr(),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () => context.read<FaqCubit>().getFaqs(),
                    child: Text(AppStrings.retry.tr()),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Contact Section
                _buildContactHeader(),
                SizedBox(height: 32.h),

                // FAQ Header
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      AppStrings.faqs.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.blackText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // FAQ List
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withValues(alpha: 0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: state.isLoading && faqs.isEmpty
                      ? _buildSkeletonList()
                      : faqs.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(30.w),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: ColorManager.greyTextColor.withValues(alpha: 0.4),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  AppStrings.noDataFound.tr(),
                                  style: const TextStyle(color: ColorManager.greyTextColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(
                            faqs.length,
                            (index) => _buildFaqItem(
                              question: faqs[index].question,
                              answer: faqs[index].answer,
                              isLast: index == faqs.length - 1,
                            ),
                          ),
                        ),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.1),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppStrings.howCanWeHelp.tr(),
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.reachOutToUs.tr(),
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12.sp),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<SettingsCubit, BaseState<SettingsModel>>(
            builder: (context, state) {
              final settings = state.data;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildContactButton(
                    icon: Icons.chat_bubble_rounded,
                    label: AppStrings.whatsApp.tr(),
                    onTap: () {
                      if (settings?.whatsapp != null) {
                        _launchUrl("https://wa.me/${settings!.whatsapp}");
                      }
                    },
                  ),
                  _buildContactButton(
                    icon: Icons.email_rounded,
                    label: AppStrings.email.tr(),
                    onTap: () {
                      if (settings?.email != null) {
                        _launchUrl("mailto:${settings!.email}");
                      }
                    },
                  ),
                  _buildContactButton(
                    icon: Icons.phone_rounded,
                    label: AppStrings.phone.tr(),
                    onTap: () {
                      if (settings?.phone != null) {
                        _launchUrl("tel:${settings!.phone}");
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24.sp),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w500),
        ),
      ],
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
              if (index != 4)
                Divider(height: 1, color: ColorManager.lightGrey2.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer, bool isLast = false}) {
    return Column(
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              question,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.blackText,
              ),
            ),
            iconColor: ColorManager.primary,
            collapsedIconColor: ColorManager.greyTextColor,
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: ColorManager.greyTextColor.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
            color: ColorManager.lightGrey2.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
