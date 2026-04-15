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
    final prefixIconColor = ColorManager.primary.withValues(alpha: 0.6);
    const prefixIconSize = 20.0;

    return Column(
      children: [
        // Name Field
        DefaultFormField(
          controller: nameController,
          hintText: AppStrings.name.tr(),
          prefixWidget: Icon(Icons.person_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
        SizedBox(height: 10.h),
        // Company Field
        DefaultFormField(
          controller: companyController,
          hintText: AppStrings.companyName.tr(),
          withValidate: false,
          prefixWidget: Icon(Icons.business_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
        SizedBox(height: 10.h),
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
              prefixWidget: Icon(Icons.grid_view_rounded, color: prefixIconColor, size: prefixIconSize.sp),
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
        SizedBox(height: 10.h),
        // Birth Date Field
        DefaultFormField(
          controller: birthDateController,
          hintText: AppStrings.dateOfBirth.tr(),
          readOnly: true,
          prefixWidget: Icon(Icons.calendar_today_rounded, color: prefixIconColor, size: prefixIconSize.sp),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: ColorManager.primary,
                      onPrimary: Colors.white,
                      onSurface: ColorManager.textColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              birthDateController.text = formattedDate;
            }
          },
        ),
        SizedBox(height: 10.h),
        // Phone Field
        DefaultFormField(
          controller: phoneController,
          hintText: AppStrings.phoneNumber.tr(),
          keyboardType: TextInputType.phone,
          prefixWidget: Icon(Icons.phone_iphone_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
        SizedBox(height: 10.h),
        // Email Field
        DefaultFormField(
          controller: emailController,
          hintText: AppStrings.email.tr(),
          keyboardType: TextInputType.emailAddress,
          prefixWidget: Icon(Icons.email_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
        SizedBox(height: 10.h),
        // Password Field
        DefaultFormField(
          controller: passwordController,
          hintText: AppStrings.password.tr(),
          obscureText: true,
          prefixWidget: Icon(Icons.lock_person_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
        SizedBox(height: 10.h),
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
          prefixWidget: Icon(Icons.lock_person_rounded, color: prefixIconColor, size: prefixIconSize.sp),
        ),
      ],
    );
  }
}
