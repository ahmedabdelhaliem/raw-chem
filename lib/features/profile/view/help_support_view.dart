import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.help.tr(),
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
            // FAQ Section
            Text(
              'الأسئلة الشائعة',
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
              child: Column(
                children: [
                  _buildFaqItem(
                    question: 'كيف أقدر أطلب منتجات؟',
                    answer:
                        'يمكنك التصفح عبر الأقسام المختلفة لإضافة أي منتج ثم الضغط "إتمام الطلب" وتتبع خطوات الدفع والاستلام.',
                  ),
                  Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                  _buildFaqItem(
                    question: 'إمتى هيوصل طلبي؟',
                    answer:
                        'يتم توصيل الطلبات في نفس اليوم أو خلال ساعات حسب المنطقة، وسيظهر لك مدة التوصيل المتوقعة عند إتمام الطلب.',
                  ),
                  Divider(height: 1, color: ColorManager.lightGrey2.withOpacity(0.5)),
                  _buildFaqItem(
                    question: 'هل أقدر أغير أو أكنسل الطلب؟',
                    answer:
                        'نعم، تقدر تلغي الطلب أو تعدل عليه طالما أنه في مرحلة قيد المعالجة ولم يتم خروجه للتوصيل للعميل.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Contact Us
            Text(
              'تواصل معنا',
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
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'لو عندك أي مشكلة أو استفسار تاني، تقدر تتواصل معانا عن طريق الأرقام دي:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.greyTextColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(Iconsax.call, color: ColorManager.primary, size: 24.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'اتصل بنا: 19000',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorManager.blackText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Iconsax.sms, color: ColorManager.primary, size: 24.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'support@rawchem.com',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorManager.blackText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 48.h),
            Center(
              child: Text(
                'تم التصميم وتطوير بواسطة برمجة تك',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: ColorManager.blackText,
        ),
      ),
      iconColor: ColorManager.primary,
      collapsedIconColor: ColorManager.greyTextColor,
      childrenPadding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h),
      children: [
        Text(
          answer,
          style: TextStyle(
            fontSize: 13.sp,
            color: ColorManager.greyTextColor,
            height: 1.6,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
