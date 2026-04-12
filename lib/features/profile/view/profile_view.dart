import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/profile_menu_item_widget.dart';

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
            toolbarHeight: 00.h,

            centerTitle: true,
            backgroundColor: ColorManager.primary,
            elevation: 0,
            iconTheme: const IconThemeData(color: ColorManager.white),
          ),
          body: SkeletonWidget(
            isLoading: user == null,
            child: user == null
                ? const ProfileSkeleton()
                : RefreshIndicator(
                    onRefresh: () => context.read<ProfileCubit>().getProfile(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // Premium Header with Gradient
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 120.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(32.r),
                                    bottomRight: Radius.circular(32.r),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -40.h,
                                child: Container(
                                  padding: EdgeInsets.all(4.r),
                                  decoration: const BoxDecoration(
                                    color: ColorManager.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 50.r,
                                    backgroundColor: ColorManager.lightGrey.withOpacity(0.5),
                                    backgroundImage: user.image != null && user.image!.isNotEmpty
                                        ? NetworkImage(user.image!)
                                        : null,
                                    child: user.image == null || user.image!.isEmpty
                                        ? Icon(
                                            Iconsax.user,
                                            size: 40.sp,
                                            color: ColorManager.greyTextColor,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 50.h),

                          // User Info
                          Column(
                            children: [
                              Text(
                                user.name ?? 'Name',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.blackText,
                                ),
                              ),
                              Text(
                                user.email ?? 'email@example.com',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorManager.greyTextColor,
                                ),
                              ),
                              if (user.category?.name != null) ...[
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    user.category!.name!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Account Section
                                _buildSectionTitle(AppStrings.myPersonalData.tr()),
                                  _buildMenuCard([
                                    ProfileMenuItemWidget(
                                      title: AppStrings.myPersonalData.tr(),
                                      iconData: Iconsax.user,
                                      onTap: () => context.push(AppRouters.personalDataView),
                                    ),
                                    _buildDivider(),
                                    ProfileMenuItemWidget(
                                      title: AppStrings.chatInbox.tr(),
                                      iconData: Iconsax.message_2,
                                      onTap: () => context.push(AppRouters.chatInboxView),
                                    ),
                                    _buildDivider(),
                                    ProfileMenuItemWidget(
                                      title: AppStrings.ordersHistory.tr(),
                                      iconData: Iconsax.document,
                                      onTap: () => context.push(AppRouters.ordersHistoryView),
                                    ),
                                  ]),

                                SizedBox(height: 24.h),

                                // App Settings Section
                                _buildSectionTitle(AppStrings.settings.tr()),
                                _buildMenuCard([
                                  ProfileMenuItemWidget(
                                    title: AppStrings.language.tr(),
                                    iconData: Iconsax.language_square,
                                    onTap: () => context.push(AppRouters.languageView),
                                  ),
                                  _buildDivider(),
                                  ProfileMenuItemWidget(
                                    title: AppStrings.notifications.tr(),
                                    iconData: Iconsax.notification,
                                    onTap: () => context.push(AppRouters.notificationsSettingsView),
                                  ),
                                ]),

                                SizedBox(height: 24.h),

                                // Support Section
                                _buildSectionTitle(AppStrings.help.tr()),
                                _buildMenuCard([
                                  ProfileMenuItemWidget(
                                    title: AppStrings.help.tr(),
                                    iconData: Iconsax.info_circle,
                                    onTap: () => context.push(AppRouters.helpSupportView),
                                  ),
                                  _buildDivider(),
                                  ProfileMenuItemWidget(
                                    title: AppStrings.aboutUs.tr(),
                                    iconData: Iconsax.status,
                                    onTap: () => context.push(AppRouters.aboutUsView),
                                  ),
                                  _buildDivider(),
                                  ProfileMenuItemWidget(
                                    title: AppStrings.termsAndConditions.tr(),
                                    iconData: Iconsax.shield_tick,
                                    onTap: () => context.push(AppRouters.termsConditionsView),
                                  ),
                                ]),

                                SizedBox(height: 32.h),

                                // Logout
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ProfileMenuItemWidget(
                                    title: AppStrings.logout.tr(),
                                    iconData: Iconsax.logout,
                                    color: ColorManager.red,
                                    isLoading: state.isLoading,
                                    onTap: () => context.read<ProfileCubit>().logout(),
                                  ),
                                ),
                                SizedBox(height: 40.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 8.h, right: 8.w),
      child: Text(
        title,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: ColorManager.primary),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 50.w,
      endIndent: 16.w,
      color: ColorManager.lightGrey2.withOpacity(0.5),
    );
  }
}
