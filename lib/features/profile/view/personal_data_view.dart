import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _isPopping = false;
  int? _selectedCategoryId;
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );
    
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileCubit>().state.data;
    if (user != null) {
      _nameController = TextEditingController(text: user.name ?? '');
      _emailController = TextEditingController(text: user.email ?? '');
      _phoneController = TextEditingController(text: user.phone ?? '');
      _companyController = TextEditingController(text: user.companyName ?? '');
      _selectedCategoryId = int.tryParse(user.categoryId?.toString() ?? '') ?? user.category?.id;
      _hasInitializedFields = true;
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _phoneController = TextEditingController();
      _companyController = TextEditingController();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<CategoriesCubit>()..fetchCategories()),
      ],
      child: BlocConsumer<ProfileCubit, BaseState<ProfileUser>>(
        listener: (context, state) {
          if (state.isSuccess && !_hasInitializedFields && state.data != null) {
            _nameController.text = state.data?.name ?? '';
            _emailController.text = state.data?.email ?? '';
            _phoneController.text = state.data?.phone ?? '';
            _companyController.text = state.data?.companyName ?? '';
            _selectedCategoryId = int.tryParse(state.data?.categoryId?.toString() ?? '') ?? state.data?.category?.id;
            _hasInitializedFields = true;
          } else if (state.isSuccess && _hasInitializedFields && !state.isLoading && !_isPopping) {
            _isPopping = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
               context.showSuccessMessage(AppStrings.profileUpdatedSuccessfully.tr());
               if (context.mounted) {
                 context.pop();
               }
            });
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
                  color: ColorManager.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: ColorManager.primary,
              elevation: 0,
              iconTheme: const IconThemeData(color: ColorManager.white),
            ),
            body: SkeletonWidget(
              isLoading: state.data == null,
              child: state.data == null
                  ? PersonalDataFormSkeleton()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Styled Header Section
                          SizedBox(
                            height: 200.h,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(32.r),
                                        bottomRight: Radius.circular(32.r),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: _pickImage,
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
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
                                            radius: 60.r,
                                            backgroundColor: ColorManager.lightGrey.withOpacity(0.5),
                                            backgroundImage: _pickedImage != null
                                                ? FileImage(File(_pickedImage!.path)) as ImageProvider
                                                : (state.data?.image != null && state.data!.image!.isNotEmpty
                                                    ? NetworkImage(state.data!.image!)
                                                    : null),
                                            child: _pickedImage == null && (state.data?.image == null || state.data!.image!.isEmpty)
                                                ? Icon(Iconsax.user, size: 50.sp, color: ColorManager.greyTextColor)
                                                : null,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: ColorManager.white, width: 2),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Iconsax.camera,
                                            color: ColorManager.white,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10.h),


                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildTextField(
                                    label: AppStrings.fullName.tr(),
                                    controller: _nameController,
                                    icon: Iconsax.user,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildTextField(
                                    label: AppStrings.email.tr(),
                                    controller: _emailController,
                                    icon: Iconsax.sms,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildTextField(
                                    label: AppStrings.phoneNumber.tr(),
                                    controller: _phoneController,
                                    icon: Iconsax.call,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildTextField(
                                    label: AppStrings.companyName.tr(),
                                    controller: _companyController,
                                    icon: Iconsax.building,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildCategoryDropdown(),
                                  SizedBox(height: 40.h),
                                  DefaultButtonWidget(
                                    isLoading: state.isLoading,
                                    onPressed: () {
                                      final request = UpdateProfileRequest(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text,
                                        companyName: _companyController.text,
                                        categoryId: _selectedCategoryId ?? 1,
                                        image: _pickedImage,
                                      );
                                      context.read<ProfileCubit>().updateProfile(request);
                                    },
                                    text: AppStrings.save.tr(),
                                    color: ColorManager.primary,
                                    textColor: ColorManager.white,
                                    radius: 16.r,
                                    height: 54.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
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
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: ColorManager.primary, size: 20.sp),
            filled: true,
            fillColor: ColorManager.bg.withOpacity(0.5),
            contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: ColorManager.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            AppStrings.field.tr(),
            style: TextStyle(
              fontSize: 13.sp,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            List<CategoryModel> categories = [];
            if (state is CategoriesSuccess) {
              categories = state.categories;
            }

            final hasValidValue = _selectedCategoryId != null && categories.any((cat) => cat.id == _selectedCategoryId);

            return DropdownButtonFormField<int>(
              value: hasValidValue ? _selectedCategoryId : null,
              dropdownColor: ColorManager.white,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: ColorManager.blackText),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.grid_5, color: ColorManager.primary, size: 20.sp),
                filled: true,
                fillColor: ColorManager.bg.withOpacity(0.5),
                contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: ColorManager.primary, width: 1.5),
                ),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem<int>(
                  value: cat.id,
                  child: Text(cat.name ?? ''),
                );
              }).toList(),
              onChanged: (id) {
                setState(() {
                  _selectedCategoryId = id;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
