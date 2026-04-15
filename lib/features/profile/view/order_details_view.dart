import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<ConfirmPaymentCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.orderDetails.tr(),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _buildDetailRow('رقم الطلب', '016440693 - EGY'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('اسم العميل', 'محمد كمال'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('رقم الموبايل', '+20 100 000 0000'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('البريد الالكتروني', 'm.kamal@example.com'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('المدينة', 'القاهرة'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('العنوان الرياضي', 'مدينة نصر - بجوار النادي الأهلي'),
                  SizedBox(height: 12.h),
                  _buildDetailRow('طريقة الدفع', 'الدفع عند الاستلام'),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Cart Items
            Text(
              AppStrings.items.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.blackText,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: ListView.separated(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  height: 32.h,
                  color: ColorManager.lightGrey2.withOpacity(0.5),
                ),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: ColorManager.lightGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child:
                              Icon(Icons.shopping_bag, color: ColorManager.primary, size: 24.sp),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'حمض ألكيل بنزين السلفونيك الخطي',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.blackText,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'الكمية: x${index + 1}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorManager.greyTextColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '1,250.00 جنية',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            SizedBox(height: 32.h),
            // Payment Button
            BlocConsumer<ConfirmPaymentCubit, BaseState<dynamic>>(
              listener: (context, state) {
                if (state.isSuccess) {
                  final response = state.data;
                  final paymentData = response?['payment_data'];
                  final paymentUrl = paymentData?['redirectTo'];

                  if (paymentUrl != null) {
                    context.push(AppRouters.fawaterkWebView, extra: {'url': paymentUrl});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.requestSentSuccess.tr())),
                    );
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
              builder: (context, state) {
                return DefaultButtonWidget(
                  text: 'الدفع المباشر',
                  isLoading: state.isLoading,
                  onPressed: () {
                    // For now, using mocked ID 2 based on postman example and payment_method_id 2
                    context.read<ConfirmPaymentCubit>().confirmPayment(
                          orderId: 2,
                          paymentMethodId: 2,
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
                    child: Icon(Icons.payment, color: const Color(0xFF006B3E), size: 14.sp),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.greyTextColor,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.blackText,
            ),
          ),
        ),
      ],
    );
  }
}
