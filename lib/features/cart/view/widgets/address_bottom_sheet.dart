import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/cart/view/order_success_view.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddressBottomSheet(),
      ),
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  'العنوان',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 48.w),
              ],
            ),
            SizedBox(height: 15.h),

            // Map Placeholder
            Text(
              'العنوان على الخريطة',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                'https://miro.medium.com/v2/resize:fit:1200/1*qYUvh-dpTfwlaEXqZAEQSA.png',
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120.h,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.map, color: Colors.grey, size: 40),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Form Rows
            Row(
              children: [
                Expanded(child: _buildFormField('البلد', 'مصر', isDropdown: true)),
                SizedBox(width: 15.w),
                Expanded(child: _buildFormField('المدينة', 'الجيزة', isDropdown: true)),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(child: _buildFormField('رقم العمارة', '20')),
                SizedBox(width: 15.w),
                Expanded(child: _buildFormField('رقم الدور', '3')),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(child: _buildFormField('رقم الشقة', '15')),
                SizedBox(width: 15.w),
                Expanded(child: _buildFormField('علامة مميزة', 'اعلى محل (اسم المحل)')),
              ],
            ),
            SizedBox(height: 15.h),
            _buildFormField('اسم الشارع', '24 امبابة ----'),
            SizedBox(height: 15.h),
            _buildFormField('رقم موبايل المستلم', '+20 01000000000',
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Image.network(
                      'https://flagcdn.com/w40/eg.png',
                      width: 24.w,
                      height: 16.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.flag),
                    ),
                  ),
                )),
            
            SizedBox(height: 30.h),

            // Complete Order Button
            DefaultButtonWidget(
              text: 'أكمل الطلب',
              onPressed: () {
                // By replacing, we put OrderSuccessView on top.
                // It will cover everything, and its "return to home" handles stack clearing.
                Navigator.pushReplacement(
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
              textFirst: true,
              iconBuilder: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 16.sp),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String value, {bool isDropdown = false, Widget? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 44.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isDropdown && suffixIcon == null) const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!isDropdown && suffixIcon == null) const Spacer(),
              if (isDropdown || suffixIcon != null) const Spacer(),
              if (isDropdown) Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 18.sp),
              if (suffixIcon != null) suffixIcon,
            ],
          ),
        ),
      ],
    );
  }
}
