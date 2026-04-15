import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_dropdown_menu_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';

class ConnectSupplierView extends StatefulWidget {
  final int? materialId;
  final PurchaseOrderModel? order;

  const ConnectSupplierView({super.key, this.materialId, this.order});

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
    // If order is provided, show the Order Details UI (merged logic)
    if (widget.order != null) {
      return _buildOrderDetailsMode(context, widget.order!);
    }

    // Otherwise show the Order Creation Form Mode
    return _buildCreateOrderMode(context);
  }

  // --- MODE 1: CREATE ORDER FORM ---
  Widget _buildCreateOrderMode(BuildContext context) {
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
                  context.showSuccessMessage(AppStrings.requestSentSuccess.tr());
                  context.pop();
                }
              } else if (state.isError) {
                context.showErrorMessage(state.errorMessage ?? AppStrings.unknownError.tr());
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
                            enabled: locationState.selectedCountry != null && !locationState.isLoadingGovernorates,
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
                                return AppStrings.enterValidNumber.tr();
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
                                return AppStrings.invalidPhone.tr();
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
                            validator: (val) => (val == null || val.isEmpty) ? AppStrings.detailedAreaHint.tr() : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<CreatePurchaseOrderCubit, BaseState<dynamic>>(
                            builder: (context, purchaseState) {
                              return DefaultButtonWidget(
                                text: AppStrings.requestQuoteButton.tr(),
                                isLoading: purchaseState.isLoading,
                                onPressed: () {
                                  final isFormValid = _formKey.currentState?.validate() ?? false;
                                  final isLocationValid = locationState.selectedCountry != null && locationState.selectedGovernorate != null && locationState.selectedCity != null;

                                  if (!isFormValid || !isLocationValid) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(AppStrings.fillAllDetails.tr()), backgroundColor: Colors.orange),
                                    );
                                    return;
                                  }

                                  context.read<CreatePurchaseOrderCubit>().createPurchaseOrder(
                                        materialId: widget.materialId ?? 0,
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
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 14.sp),
                                ),
                              );
                            },
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

  // --- MODE 2: ORDER STATUS / DETAILS ---
  Widget _buildOrderDetailsMode(BuildContext context, PurchaseOrderModel order) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<ConfirmPaymentCubit>()),
        BlocProvider(create: (context) => instance<PaymentMethodsCubit>()..fetchPaymentMethods()),
        BlocProvider(
          create: (context) {
            final cubit = instance<PurchaseOrderDetailsCubit>();
            // If the order is a "skeleton" (common when clicking from notifications), fetch full details
            if (order.supplierMaterial == null || order.quantity == 0) {
              cubit.getPurchaseOrderDetails(order.id);
            } else {
              // Initialize with current order data
              cubit.emit(BaseState(status: Status.success, data: order));
            }
            return cubit;
          },
        ),
      ],
      child: BlocBuilder<PurchaseOrderDetailsCubit, BaseState<PurchaseOrderModel>>(
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              backgroundColor: const Color(0xFFF8F9FE),
              appBar: DefaultAppBar(
                text: AppStrings.orderDetails.tr(),
                backgroundColor: ColorManager.white,
                titleColor: ColorManager.black,
                withLeading: true,
              ),
              body: _buildOrderDetailsShimmer(),
            );
          }

          if (state.isError) {
            return Scaffold(
              backgroundColor: const Color(0xFFF8F9FE),
              appBar: DefaultAppBar(
                text: 'خطأ',
                backgroundColor: ColorManager.white,
                titleColor: ColorManager.black,
                withLeading: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'حدث خطأ ما'),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<PurchaseOrderDetailsCubit>().getPurchaseOrderDetails(order.id),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          }

          final currentOrder = state.data ?? order;

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FE),
            appBar: DefaultAppBar(
              text: currentOrder.status == 'accepted' 
                  ? AppStrings.orderDetails.tr() 
                  : currentOrder.status == 'rejected' 
                    ? AppStrings.orderDetails.tr()
                    : AppStrings.orderDetails.tr(),
              backgroundColor: ColorManager.white,
              titleColor: ColorManager.black,
              withLeading: true,
            ),
            body: RefreshIndicator(
              onRefresh: () => context.read<PurchaseOrderDetailsCubit>().getPurchaseOrderDetails(currentOrder.id),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPremiumOrderInfoCard(currentOrder),
                    if (currentOrder.status == 'rejected' && currentOrder.rejectionReason != null) ...[
                      SizedBox(height: 24.h),
                      _buildRejectionCard(currentOrder.rejectionReason!),
                    ],
                    SizedBox(height: 24.h),
                    Text(
                      AppStrings.items.tr(),
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: ColorManager.blackText),
                    ),
                    SizedBox(height: 16.h),
                    _buildOrderItemsSummary(currentOrder),
                    SizedBox(height: 24.h),
                    if (currentOrder.status == 'accepted' && currentOrder.supplierQuote != null) ...[
                      _buildPriceSummaryCard(currentOrder),
                      SizedBox(height: 20.h),
                    ],
                  ],
                ),
              ),
            ),
            bottomNavigationBar: currentOrder.status == 'accepted' 
                ? (currentOrder.isPaid 
                    ? _buildGeneralChatBottomBar(context, currentOrder) 
                    : _buildBottomPaymentBar(context, currentOrder))
                : null,
          );
        },
      ),
    );
  }

  Widget _buildPremiumOrderInfoCard(PurchaseOrderModel order) {
    String statusText = '';
    Color statusColor = Colors.grey;
    Color statusBgColor = Colors.grey.withValues(alpha: 0.15);
    
    if (order.status == 'accepted' || order.status == 'awaiting_payment') {
      if (order.isPaid) {
          statusText = AppStrings.statusPaid.tr();
          statusColor = const Color(0xFF19B273);
          statusBgColor = const Color(0xFF19B273).withValues(alpha: 0.15);
      } else {
          statusText = AppStrings.statusAwaitingPayment.tr();
          statusColor = ColorManager.primary;
          statusBgColor = ColorManager.primary.withValues(alpha: 0.15);
      }
    } else if (order.status == 'rejected') {
      statusText = AppStrings.statusRejected.tr();
      statusColor = Colors.red;
      statusBgColor = Colors.red.withValues(alpha: 0.15);
    } else {
      statusText = AppStrings.statusPending.tr();
      statusColor = Colors.amber.shade900;
      statusBgColor = Colors.amber.withValues(alpha: 0.15);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(color: ColorManager.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(Icons.receipt_long_rounded, color: ColorManager.primary, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.invoiceNumber.tr(), style: TextStyle(fontSize: 12.sp, color: ColorManager.greyTextColor)),
                    SizedBox(height: 4.h),
                    Text(order.invoice?.invoiceNumber ?? '#PO-${order.id}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: ColorManager.blackText)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(20.r)),
                child: Text(statusText, style: TextStyle(color: statusColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16.h), child: const Divider(color: Color(0xFFEEEEEE))),
          _buildInfoRow(Icons.phone_outlined, AppStrings.recipientPhone.tr(), order.recipientPhone ?? AppStrings.notProvided.tr()),
          if (order.location != null) ...[
             SizedBox(height: 12.h),
             _buildInfoRow(Icons.location_on_outlined, AppStrings.location.tr(), '${order.location?.city ?? ''} - ${order.location?.governorate ?? ''} - ${order.location?.country ?? ''}'),
          ],
          if (order.distinguishingMark != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(Icons.map_outlined, AppStrings.detailedArea.tr(), order.distinguishingMark!),
          ],
          SizedBox(height: 12.h),
          _buildInfoRow(Icons.date_range_outlined, AppStrings.orderDate.tr(), order.createdAt?.split('T').first ?? AppStrings.notProvided.tr()),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: ColorManager.greyTextColor),
          SizedBox(width: 12.w),
          Text(title, style: TextStyle(fontSize: 13.sp, color: ColorManager.greyTextColor)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: ColorManager.blackText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectionCard(String reason) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.red.shade100),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
              SizedBox(width: 8.w),
              Text('سبب رفض المورد:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.red.shade900)),
            ],
          ),
          SizedBox(height: 8.h),
          Text(reason, style: TextStyle(fontSize: 14.sp, color: Colors.red.shade800)),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSummary(PurchaseOrderModel order) {
    final material = order.supplierMaterial;
    if (material == null) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(color: const Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(12.r)),
            child: Icon(Icons.science_outlined, color: ColorManager.primary, size: 30.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(material.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: ColorManager.blackText), maxLines: 2),
                if (material.supplierName != null) 
                  Text(material.supplierName!, style: TextStyle(fontSize: 12.sp, color: ColorManager.greyTextColor)),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(color: ColorManager.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8.r)),
                      child: Text('${AppStrings.quantity.tr()}: ${order.quantity}', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: ColorManager.primary)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (order.supplierQuote != null) ...[
                             Text('${order.supplierQuote?.unitPrice} ${AppStrings.egp.tr()}', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w900, color: ColorManager.primary)),
                             Text('${order.listedUnitPrice} ${AppStrings.egp.tr()}', style: TextStyle(fontSize: 11.sp, decoration: TextDecoration.lineThrough, color: ColorManager.greyTextColor)),
                        ] else ...[
                             Text('${order.listedUnitPrice} ${AppStrings.egp.tr()}', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w900, color: ColorManager.blackText)),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummaryCard(PurchaseOrderModel order) {
    final quote = order.supplierQuote!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.payment_rounded, color: ColorManager.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Text(AppStrings.orderDetails.tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: ColorManager.blackText)),
            ],
          ),
          SizedBox(height: 20.h),
          _buildPriceRow(AppStrings.subtotal.tr(), '${quote.lineSubtotal} ${AppStrings.egp.tr()}'),
          if (quote.discountPercent != null && quote.discountPercent != '0.00' && quote.discountPercent != 'null') ...[
             SizedBox(height: 14.h),
             _buildPriceRow(
               '${AppStrings.discount.tr()} (${quote.discountPercent}%)', 
               '- ${quote.discountTotal ?? '0'} ${AppStrings.egp.tr()}', 
               isGreen: true
             ),
          ] else if (quote.discountAmount != null && quote.discountAmount != '0.00' && quote.discountAmount != 'null') ...[
             SizedBox(height: 14.h),
             _buildPriceRow(
               AppStrings.discount.tr(), 
               '- ${quote.discountAmount} ${AppStrings.egp.tr()}', 
               isGreen: true
             ),
          ],
          SizedBox(height: 14.h),
          _buildPriceRow(AppStrings.shippingFee.tr(), quote.shippingFee != null && quote.shippingFee != '0.00' ? '${quote.shippingFee} ${AppStrings.egp.tr()}' : AppStrings.notProvided.tr(), isGreen: quote.shippingFee == null || quote.shippingFee == '0.00'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h), 
            child: Row(
              children: List.generate(30, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  height: 1,
                  color: index % 2 == 0 ? Colors.grey.shade200 : Colors.transparent,
                ),
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.total.tr(), style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: ColorManager.blackText)),
              Text('${order.invoice?.grandTotal ?? quote.grandTotal} ${AppStrings.egp.tr()}', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900, color: ColorManager.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 14.sp, color: ColorManager.greyTextColor)),
        Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: isGreen ? const Color(0xFF19B273) : ColorManager.blackText)),
      ],
    );
  }

  Widget _buildBottomPaymentBar(BuildContext context, PurchaseOrderModel order) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 30.h),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))]),
      child: BlocConsumer<ConfirmPaymentCubit, BaseState<dynamic>>(
        listener: (context, state) {
          if (state.isSuccess) {
            final paymentData = state.data?['payment_data'];
            
            // Handle embedded errors from Fawaterk (even if response is 200)
            if (paymentData is Map && paymentData.containsKey('error')) {
              context.showToast(
                text: 'خطأ في عملية الدفع: ${paymentData['error']}',
                color: Colors.red,
              );
              return;
            }

            final url = paymentData?['redirectTo'] ?? paymentData?['url'];
            if (url != null) {
              context.push(AppRouters.fawaterkWebView, extra: {'url': url});
            } else {
              context.showToast(
                text: 'فشل في بدء عملية الدفع: لم يتم العثور على رابط التحويل',
                color: Colors.orange,
              );
            }
          } else if (state.isError) {
            context.showToast(
              text: state.errorMessage ?? AppStrings.unknownError.tr(),
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: AppStrings.payNow.tr(),
                  isLoading: state.isLoading,
                  onPressed: () => _showPaymentMethodsBottomSheet(context, order),
                  color: ColorManager.primary,
                  textColor: Colors.white,
                  radius: 16.r,
                  height: 56.h,
                ),
              ),
              SizedBox(width: 12.w),
              _buildFloatingChatButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGeneralChatBottomBar(BuildContext context, PurchaseOrderModel order) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 30.h),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, -5))]),
      child: DefaultButtonWidget(
        text: AppStrings.contactSupplier.tr(),
        onPressed: () => _handleChat(context, order.supplierMaterial?.id ?? 1),
        color: const Color(0xFF25D366),
        textColor: Colors.white,
        radius: 16.r,
        height: 56.h,
        isIcon: true,
        textFirst: true,
        iconBuilder: Icon(Icons.chat_bubble_rounded, size: 20.sp, color: Colors.white),
      ),
    );
  }

  // --- SHARED HELPER METHODS ---

  Widget _buildFloatingChatButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleChat(context, 1),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 54.h,
          width: 54.h,
          decoration: BoxDecoration(
            color: const Color(0xFF25D366),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [BoxShadow(color: const Color(0xFF25D366).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }

  Future<void> _handleChat(BuildContext context, int supplierId) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppStrings.startingChat.tr()), duration: const Duration(seconds: 1)));
    try {
      final result = await instance<ChatRepo>().createChat(supplierId);
      result.fold(
        (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppStrings.failedToStartChat.tr(args: [failure.message])), backgroundColor: Colors.red)),
        (response) {
          if (!context.mounted) return;
          context.push(AppRouters.chatView);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppStrings.unexpectedError.tr()), backgroundColor: Colors.red));
    }
  }

  void _showPaymentMethodsBottomSheet(BuildContext context, PurchaseOrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: context.read<ConfirmPaymentCubit>(),
          child: BlocProvider.value(
            value: context.read<PaymentMethodsCubit>(),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(height: 30.h),
                  Text(AppStrings.selectPaymentMethod.tr(), style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900, color: ColorManager.blackText)),
                  SizedBox(height: 30.h),
                  BlocBuilder<PaymentMethodsCubit, BaseState<List<PaymentMethodModel>>>(
                    builder: (context, state) {
                      if (state.isLoading) return const Center(child: CircularProgressIndicator());
                      if (state.isSuccess) {
                        final methods = state.data ?? [];
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: methods.length,
                          separatorBuilder: (context, index) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            final method = methods[index];
                            final iconColor = _getPaymentColor(method.paymentCode);
                            final iconData = _getPaymentIcon(method.paymentCode);
                            
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20.r),
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<ConfirmPaymentCubit>().confirmPayment(
                                        orderId: order.id, 
                                        paymentMethodId: method.paymentId,
                                      );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: iconColor.withValues(alpha: 0.05),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: iconColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(14.r),
                                        ),
                                        child: Icon(iconData, color: iconColor, size: 26.sp),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              method.paymentMethod,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.blackText,
                                              ),
                                            ),
                                            if (method.paymentCode.toLowerCase().contains('fawry')) ...[
                                              SizedBox(height: 4.h),
                                              Text(
                                                'ادفع من أي منفذ فوري',
                                                style: TextStyle(fontSize: 12.sp, color: ColorManager.greyTextColor),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF8F9FE),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.arrow_back_ios_new_rounded, size: 14.sp, color: ColorManager.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getPaymentIcon(String code) {
    if (code.toLowerCase().contains('fawry')) return Icons.storefront_rounded;
    if (code.toLowerCase().contains('wallet')) return Icons.account_balance_wallet_rounded;
    return Icons.payment_rounded;
  }

  Color _getPaymentColor(String code) {
    if (code.toLowerCase().contains('fawry')) return Colors.amber.shade600;
    if (code.toLowerCase().contains('wallet')) return Colors.blue.shade600;
    return const Color(0xFF006B3E); 
  }

  Widget _buildOrderDetailsShimmer() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card Shimmer
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            ),
            SizedBox(height: 24.h),
            // Items Label Shimmer
            Container(height: 20.h, width: 80.w, color: Colors.white),
            SizedBox(height: 16.h),
            // Items Card Shimmer
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            ),
            SizedBox(height: 24.h),
            // Price Summary Card Shimmer
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
            ),
          ],
        ),
      ),
    );
  }
}
