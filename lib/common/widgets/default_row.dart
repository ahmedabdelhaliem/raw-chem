import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultRow extends StatelessWidget {
  const DefaultRow({super.key, this.text, this.text2, this.onTap});
  final String? text;
  final String? text2;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // مهم جدًا
          children: [
            // === النص "الكل" أو "المزيد" على الشمال ===
            TextButton(
              onPressed: () {
                // اكتب هنا اللي عايز يحصل لما يضغط
                debugPrint("تم الضغط على الكل / المزيد");
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // عشان ما ياخدش مساحة زيادة
                children: [
                  Text(
                    text ?? "",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  // SizedBox(width: 6.w),
                  // Icon(
                  //   Icons.arrow_forward_ios,
                  //   size: 16.r,
                  //   color: ColorManager.primary,
                  // ),
                ],
              ),
            ),
            if (text2 != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text2!,
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.sp,
                    color: ColorManager.primary,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
