import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import '../../../../common/resources/color_manager.dart';
import '../../../../common/resources/strings_manager.dart';
import '../../../../common/widgets/default_form_field.dart';
import '../../../../common/widgets/filter_bottom_sheet_widget.dart';

class SignupFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController companyController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController birthDateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final List<int> selectedCategoryIds;
  final void Function(List<int>) onCategoryChanged;

  const SignupFormWidget({
    super.key,
    required this.nameController,
    required this.companyController,
    required this.phoneController,
    required this.emailController,
    required this.birthDateController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedCategoryIds,
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
            final selectedNames = selectedCategoryIds.isNotEmpty
                ? categories
                    .where((cat) => selectedCategoryIds.contains(cat.id))
                    .map((cat) => cat.name)
                    .join(', ')
                : '';

            return DefaultFormField(
              controller: TextEditingController(text: selectedNames),
              hintText: AppStrings.field.tr(),
              readOnly: true,
              prefixWidget: const Icon(Icons.grid_view_outlined, color: ColorManager.greyTextColor),
              onTap: () async {
                List<FilterItem> items = categories
                    .where((cat) => cat.id != null && cat.name != null)
                    .map((cat) => FilterItem(id: cat.id!, title: cat.name!))
                    .toList();

                final result = await FilterBottomSheetWidget.show(
                  context: context,
                  items: items,
                  initialSelectedIds: selectedCategoryIds,
                  title: AppStrings.field.tr(),
                );
                
                if (result != null) {
                  onCategoryChanged(result);
                }
              },
              validator: (value) => selectedCategoryIds.isEmpty ? 'Please select at least one category' : null,
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
