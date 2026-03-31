import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/cart/view/order_success_view.dart';
import 'package:raw_chem/features/cart/view/widgets/address_bottom_sheet.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final int totalCost;

  const CheckoutBottomSheet({super.key, required this.totalCost});

  static void show(BuildContext context, {required int totalCost}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CheckoutBottomSheet(totalCost: totalCost),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'الدفع',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 48.w), // To balance the header center
            ],
          ),
          SizedBox(height: 20.h),

          // Options List
          _buildOptionRow(
            title: 'التوصيل',
            trailingText: 'اختر الطريقة',
            onTap: () {
              Navigator.pop(context); // close Checkout sheet
              AddressBottomSheet.show(context); // open address sheet
            },
          ),
          Divider(color: Colors.grey.shade200, height: 1),
          _buildOptionRow(
            title: 'الدفع',
            trailingWidget: Container(
              width: 32.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(Icons.credit_card, size: 14.sp, color: Colors.blue.shade800),
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey.shade200, height: 1),
          _buildOptionRow(
            title: 'رمز الخصم',
            trailingText: 'اختر الخصم',
            onTap: () {},
          ),
          Divider(color: Colors.grey.shade200, height: 1),
          _buildOptionRow(
            title: 'التكلفة الإجمالية',
            trailingText: '$totalCost جنية',
            trailingTextColor: Colors.black,
            onTap: () {},
          ),

          SizedBox(height: 15.h),

          Text(
            'من خلال إجراء الطلب، فإنك توافق على الشروط\nوالأحكام الخاصة بنا',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              color: ColorManager.greyTextColor,
              height: 1.5,
            ),
          ),

          SizedBox(height: 20.h),

          // Complete Order Button
          DefaultButtonWidget(
            text: 'أكمل الطلب',
            onPressed: () {
              Navigator.pop(context); // Close sheet
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderSuccessView()),
              );
            },
            color: const Color(0xFF006B3E),
            textColor: Colors.white,
            radius: 14.r,
            height: 55.h,
            fontSize: 14.sp,
            isIcon: true,
            textFirst: true, // Icon on left side for RTL
            iconBuilder: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 16.sp),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
        ],
      ),
    );
  }

  Widget _buildOptionRow({
    required String title,
    String? trailingText,
    Color? trailingTextColor,
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54, // The design shows titles in light grey/black
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: trailingTextColor ?? Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (trailingWidget != null) trailingWidget,
                SizedBox(width: 10.w),
                Icon(Icons.arrow_back_ios_new_rounded, size: 14.sp, color: Colors.grey.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
