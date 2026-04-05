import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import '../../../../common/resources/color_manager.dart';
import '../../../../common/resources/strings_manager.dart';
import '../../../../common/widgets/default_form_field.dart';

class SignupFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController companyController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController birthDateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final int? selectedCategoryId;
  final void Function(int?) onCategoryChanged;

  const SignupFormWidget({
    super.key,
    required this.nameController,
    required this.companyController,
    required this.phoneController,
    required this.emailController,
    required this.birthDateController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name Field
        DefaultFormField(
          controller: nameController,
          hintText: AppStrings.name.tr(),
          prefixWidget: const Icon(Icons.person_outline, color: ColorManager.greyTextColor),
        ),
        SizedBox(height: 15.h),
        // Company Field
        DefaultFormField(
          controller: companyController,
          hintText: AppStrings.companyName.tr(),
          withValidate: false, // Optional for now
          prefixWidget: const Icon(Icons.business_outlined, color: ColorManager.greyTextColor),
        ),
        SizedBox(height: 15.h),
        // Category Dropdown
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            List<CategoryModel> categories = [];
            if (state is CategoriesSuccess) {
              categories = state.categories;
            }
            return DropdownButtonFormField<int>(
              value: selectedCategoryId,
              hint: Text(AppStrings.field.tr(), style: const TextStyle(color: ColorManager.greyTextColor)),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.grid_view_outlined, color: ColorManager.greyTextColor),
                filled: true,
                fillColor: ColorManager.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: ColorManager.lightGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: ColorManager.lightGrey),
                ),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem<int>(
                  value: cat.id,
                  child: Text(cat.name ?? ''),
                );
              }).toList(),
              onChanged: onCategoryChanged,
              validator: (value) => value == null ? 'Please select a category' : null,
            );
          },
        ),
        SizedBox(height: 15.h),
        // Birth Date Field
        DefaultFormField(
          controller: birthDateController,
          hintText: AppStrings.dateOfBirth.tr(),
          readOnly: true,
          prefixWidget: const Icon(Icons.calendar_today_outlined, color: ColorManager.greyTextColor),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              birthDateController.text = formattedDate;
            }
          },
        ),
        SizedBox(height: 15.h),
        // Phone Field
        DefaultFormField(
          controller: phoneController,
          hintText: AppStrings.phoneNumber.tr(),
          keyboardType: TextInputType.phone,
          prefixWidget: const Icon(Icons.phone_outlined, color: ColorManager.greyTextColor),
        ),
        SizedBox(height: 15.h),
        // Email Field
        DefaultFormField(
          controller: emailController,
          hintText: AppStrings.email.tr(),
          keyboardType: TextInputType.emailAddress,
          prefixWidget: const Icon(Icons.email_outlined, color: ColorManager.greyTextColor),
        ),
        SizedBox(height: 15.h),
        // Password Field
        DefaultFormField(
          controller: passwordController,
          hintText: AppStrings.password.tr(),
          obscureText: true,
          prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
        ),
        SizedBox(height: 15.h),
        // Confirm Password Field
        DefaultFormField(
          controller: confirmPasswordController,
          hintText: AppStrings.confirmPassword.tr(),
          obscureText: true,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          prefixWidget: const Icon(Icons.lock_outline, color: ColorManager.greyTextColor),
        ),
      ],
    );
  }
}
