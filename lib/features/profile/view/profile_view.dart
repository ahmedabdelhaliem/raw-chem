import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/profile_menu_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';

import 'help_support_view.dart';
import 'language_view.dart';
import 'notifications_settings_view.dart';
import 'orders_history_view.dart';
import 'personal_data_view.dart';
import 'terms_conditions_view.dart';
import 'widgets/profile_skeleton.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, BaseState<ProfileUser>>(

        listener: (context, state) {
          if (state.isSuccess && state.data == null) {
            // Success with null data means logout was successful
            context.go(AppRouters.loginView);
          } else if (state.isError) {
            context.showErrorMessage(state.errorMessage ?? "Operation failed");
          }
        },
        builder: (context, state) {
          final user = state.data;

          return Scaffold(
            backgroundColor: ColorManager.bg,
            appBar: AppBar(
              title: Text(
                AppStrings.account.tr(),
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
            body: SkeletonWidget(
              isLoading: user == null,
              child: user == null
                  ? const ProfileSkeleton()
                  : RefreshIndicator(
                onRefresh: () => context.read<ProfileCubit>().getProfile(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    children: [
                      // User Header
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: ColorManager.lightGrey.withOpacity(0.5),
                            backgroundImage: const NetworkImage(
                              'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200',
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            user.name ?? 'Loading Name...', // Placeholder text for Skeletonizer
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.blackText,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user.email ?? 'loading.email@example.com', // Placeholder text for Skeletonizer
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorManager.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),

                          // Main Menu Options
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                ProfileMenuItemWidget(
                                  title: AppStrings.myPersonalData.tr(),
                                  iconData: Iconsax.user,
                                  onTap: () => context.push(AppRouters.personalDataView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.ordersHistory.tr(),
                                  iconData: Iconsax.document,
                                  onTap: () => context.push(AppRouters.ordersHistoryView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.language.tr(),
                                  iconData: Iconsax.language_square,
                                  onTap: () => context.push(AppRouters.languageView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.notifications.tr(),
                                  iconData: Iconsax.notification,
                                  onTap: () => context.push(AppRouters.notificationsSettingsView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.help.tr(),
                                  iconData: Iconsax.info_circle,
                                  onTap: () => context.push(AppRouters.helpSupportView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.aboutUs.tr(),
                                  iconData: Iconsax.status,
                                  onTap: () => context.push(AppRouters.aboutUsView),
                                ),
                                Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                                ProfileMenuItemWidget(
                                  title: AppStrings.termsAndConditions.tr(),
                                  iconData: Iconsax.shield_tick,
                                  onTap: () => context.push(AppRouters.termsConditionsView),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Logout
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ProfileMenuItemWidget(
                              title: AppStrings.logout.tr(), // Logout text
                              iconData: Iconsax.logout,
                              color: ColorManager.red,
                              isLoading: state.isLoading,
                              onTap: () {
                                context.read<ProfileCubit>().logout();
                              },
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}



