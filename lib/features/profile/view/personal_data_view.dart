import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/extensions/context_extension.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/profile/model/profile/profile_model.dart';
import 'package:raw_chem/features/profile/model/update_profile/update_profile_request.dart';
import 'package:raw_chem/features/profile/cubit/profile_cubit.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_card.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_list.dart';
import 'widgets/personal_data_skeleton.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyController;
  bool _hasInitializedFields = false;


  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileCubit>().state.data;
    if (user != null) {
      _nameController = TextEditingController(text: user.name ?? '');
      _emailController = TextEditingController(text: user.email ?? '');
      _phoneController = TextEditingController(text: user.phone ?? '');
      _companyController = TextEditingController(text: user.companyName ?? '');
      _hasInitializedFields = true;
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _phoneController = TextEditingController();
      _companyController = TextEditingController();
      // Wait for data via listener
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, BaseState<ProfileUser>>(
      listener: (context, state) {
        // 1. Initial data loading (if it wasn't available in initState)
        if (state.isSuccess && !_hasInitializedFields && state.data != null) {
          _nameController.text = state.data?.name ?? '';
          _emailController.text = state.data?.email ?? '';
          _phoneController.text = state.data?.phone ?? '';
          _companyController.text = state.data?.companyName ?? '';
          _hasInitializedFields = true;
        } 
        // 2. Profile update operation success (only if we were already initialized)
        else if (state.isSuccess && _hasInitializedFields && !state.isLoading) {
          context.showSuccessMessage(AppStrings.profileUpdatedSuccessfully.tr());
          Navigator.pop(context);
        } else if (state.isError) {
          context.showErrorMessage(state.errorMessage ?? "Update failed");
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.bg,
          appBar: AppBar(
            title: Text(
              AppStrings.myPersonalData.tr(),
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
            isLoading: state.data == null,
            child: state.data == null
                ? PersonalDataFormSkeleton()
                : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
              children: [
                // Profile Picture
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: const BoxDecoration(
                          color: ColorManager.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.camera,
                          color: ColorManager.white,
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Form Fields
                _buildTextField(
                  label: AppStrings.fullName.tr(),
                  controller: _nameController,
                  icon: Iconsax.user,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: AppStrings.email.tr(),
                  controller: _emailController,
                  icon: Iconsax.sms,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: AppStrings.phoneNumber.tr(),
                  controller: _phoneController,
                  icon: Iconsax.call,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: "اسم الشركة", // Company Name
                  controller: _companyController,
                  icon: Iconsax.building,
                ),
                SizedBox(height: 48.h),

                DefaultButtonWidget(
                  isLoading: state.isLoading,
                  onPressed: () {
                    final request = UpdateProfileRequest(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      companyName: _companyController.text,
                      categoryId: 1, // Placeholder for now, as state.data?.id was the User's ID, not Category ID
                    );
                    context.read<ProfileCubit>().updateProfile(request);
                  },
                  text: AppStrings.save.tr(),
                  color: ColorManager.primary,
                  textColor: ColorManager.white,
                  radius: 12.r,
                  height: 50.h,
                  fontSize: 16.sp,
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.greyTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: ColorManager.primary, size: 20.sp),
            filled: true,
            fillColor: ColorManager.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorManager.lightGrey2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorManager.lightGrey2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
          ),
        ),
      ],
    );
  }
}
