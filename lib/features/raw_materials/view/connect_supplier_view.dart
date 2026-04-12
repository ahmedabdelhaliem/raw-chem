import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_dropdown_menu_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';
import 'package:go_router/go_router.dart';

class ConnectSupplierView extends StatefulWidget {
  final int materialId;
  const ConnectSupplierView({super.key, required this.materialId});

  @override
  State<ConnectSupplierView> createState() => _ConnectSupplierViewState();
}

class _ConnectSupplierViewState extends State<ConnectSupplierView> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _detailedAreaController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _messageController.dispose();
    _detailedAreaController.dispose();
    _quantityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<LocationsCubit>()..getCountries()),
        BlocProvider(create: (context) => instance<CreatePurchaseOrderCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreatePurchaseOrderCubit, BaseState<dynamic>>(
            listener: (context, state) {
              if (state.isSuccess) {
                final response = state.data;
                final paymentUrl = response?['payment_url'] ?? response?['invoice_url'];

                if (paymentUrl != null) {
                  context.push(AppRouters.fawaterkWebView, extra: {'url': paymentUrl});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppStrings.requestSentSuccess.tr())),
                  );
                  context.pop();
                }
              } else if (state.isError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? AppStrings.unknownError.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<LocationsCubit, LocationsState>(
          builder: (context, locationState) {
            final locationCubit = context.read<LocationsCubit>();

          return Scaffold(
            backgroundColor: ColorManager.bg,
            appBar: DefaultAppBar(
              text: AppStrings.connectWithSupplier.tr(),
              backgroundColor: ColorManager.bg,
              titleColor: ColorManager.black,
              withLeading: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome Section
                  Text(
                    AppStrings.welcomeUser.tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B3D2F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppStrings.happyToConnectMessage.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorManager.greyTextColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),

                  // Form Section
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DefaultDropdownMenuWidget<CountryModel>(
                          title: AppStrings.country.tr(),
                          hintText: AppStrings.country.tr(),
                          items: locationState.countries,
                          selectedValue: locationState.selectedCountry,
                          onSelected: (val) => locationCubit.selectCountry(val),
                          optionTitle: (item) => item?.name ?? '',
                          searchOptionTitle: (item) => item?.name ?? '',
                          enabled: !locationState.isLoadingCountries,
                        ),
                        SizedBox(height: 20.h),
                        DefaultDropdownMenuWidget<GovernorateModel>(
                          title: AppStrings.governorate.tr(),
                          hintText: AppStrings.governorate.tr(),
                          items: locationState.governorates,
                          selectedValue: locationState.selectedGovernorate,
                          onSelected: (val) => locationCubit.selectGovernorate(val),
                          optionTitle: (item) => item?.name ?? '',
                          searchOptionTitle: (item) => item?.name ?? '',
                          enabled:
                              locationState.selectedCountry != null && !locationState.isLoadingGovernorates,
                        ),
                        SizedBox(height: 20.h),
                        DefaultDropdownMenuWidget<CityModel>(
                          title: AppStrings.city.tr(),
                          hintText: AppStrings.city.tr(),
                          items: locationState.cities,
                          selectedValue: locationState.selectedCity,
                          onSelected: (val) => locationCubit.selectCity(val),
                          optionTitle: (item) => item?.name ?? '',
                          searchOptionTitle: (item) => item?.name ?? '',
                          enabled: locationState.selectedGovernorate != null && !locationState.isLoadingCities,
                        ),
                        SizedBox(height: 20.h),
                        DefaultFormField(
                          controller: _quantityController,
                          title: AppStrings.quantity.tr(),
                          hintText: AppStrings.quantityHint.tr(),
                          fillColor: ColorManager.white,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return AppStrings.quantityHint.tr();
                            }
                            if (double.tryParse(val) == null) {
                              return "يرجى إدخال رقم صحيح";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        DefaultFormField(
                          controller: _phoneController,
                          title: AppStrings.recipientPhone.tr(),
                          hintText: AppStrings.recipientPhoneHint.tr(),
                          fillColor: ColorManager.white,
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return AppStrings.recipientPhoneHint.tr();
                            }
                            if (val.length < 10) {
                              return "رقم الهاتف غير صحيح";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        DefaultFormField(
                          controller: _detailedAreaController,
                          title: AppStrings.detailedArea.tr(),
                          hintText: AppStrings.detailedAreaHint.tr(),
                          fillColor: ColorManager.white,
                          validator: (val) =>
                              (val == null || val.isEmpty) ? AppStrings.detailedAreaHint.tr() : null,
                        ),
                        SizedBox(height: 20.h),
                        DefaultFormField(
                          controller: _messageController,
                          title: AppStrings.messageLabel.tr(),
                          hintText: AppStrings.messageHint.tr(),
                          fillColor: ColorManager.white,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Action Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<CreatePurchaseOrderCubit, BaseState<dynamic>>(
                          builder: (context, purchaseState) {
                            return DefaultButtonWidget(
                              text: AppStrings.requestQuoteButton.tr(),
                              isLoading: purchaseState.isLoading,
                              onPressed: () {
                                debugPrint("Purchase Button Pressed");
                                
                                // 1. Validate Form Fields (Text inputs)
                                final isFormValid = _formKey.currentState?.validate() ?? false;
                                
                                // 2. Validate Dropdowns (Locations)
                                final isLocationValid = locationState.selectedCountry != null &&
                                    locationState.selectedGovernorate != null &&
                                    locationState.selectedCity != null;

                                if (!isFormValid || !isLocationValid) {
                                  debugPrint("Validation Failed: Form($isFormValid), Location($isLocationValid)");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('يرجى التأكد من ملء جميع الحقول واختيار الموقع بالكامل'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  return;
                                }

                                debugPrint("All Valid! Sending Request for Material ID: ${widget.materialId}");
                                context.read<CreatePurchaseOrderCubit>().createPurchaseOrder(
                                      materialId: widget.materialId,
                                      quantity: double.tryParse(_quantityController.text) ?? 1,
                                      countryId: locationState.selectedCountry!.id,
                                      governorateId: locationState.selectedGovernorate!.id,
                                      cityId: locationState.selectedCity!.id,
                                      distinguishingMark: _detailedAreaController.text,
                                      recipientPhone: _phoneController.text,
                                    );
                              },
                              color: const Color(0xFF006B3E),
                              textColor: Colors.white,
                              radius: 12.r,
                              height: 54.h,
                              isIcon: true,
                              textFirst: true,
                              iconBuilder: Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 14.sp),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(width: 12.w),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _handleChat(context),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 54.h,
                      width: 54.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF25D366).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24.sp),
                    ),
                  ),
                ),
              ],
            ),
                ],
              ),
            ),
          );
        },
      ),
    ),
    );
  }

  Future<void> _handleChat(BuildContext context) async {
    debugPrint("Chat integration: Starting chat initialization...");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.startingChat.tr()), duration: const Duration(seconds: 1)),
    );
    
    // Using supplierId 1 as a fallback for support if no specific ID is available
    const int supportSupplierId = 1;

    try {
      final result = await instance<ChatRepo>().createChat(supportSupplierId);

      result.fold(
        (failure) {
          debugPrint("Chat integration: API Failure - ${failure.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.failedToStartChat.tr(args: [failure.message])),
              backgroundColor: Colors.red,
            ),
          );
        },
        (response) {
          debugPrint("Chat integration: Success! Chat ID: ${response.chatId}");
          
          if (!context.mounted) return;
          
          context.push(AppRouters.chatView);
        },
      );
    } catch (e) {
      debugPrint("Chat integration: Unexpected Error - $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.unexpectedError.tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
