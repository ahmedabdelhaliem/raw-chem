import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.termsAndConditions.tr(),
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
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الشروط والأحكام',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'يُرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام التطبيق. من خلال الوصول إلى هذا التطبيق أو استخدامه، فإنك توافق على الالتزام بهذه الشروط. إذا كنت لا توافق على أي جزء من الشروط، فلا يحق لك استخدام التطبيق. نحن نحتفظ بالحق في تعديل أو استبدال هذه الشروط في أي وقت.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.greyTextColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'نحن نقوم بجمع واستخدام وحماية معلوماتك الشخصية كما هو موضح في سياسة الخصوصية الخاصة بنا. نحرص على عدم مشاركة بياناتك الشخصية مع أطراف ثالثة دون موافقتك الصريحة.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.greyTextColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
