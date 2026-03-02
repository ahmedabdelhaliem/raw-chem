import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/current_user.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';
import 'package:raw_chem/common/widgets/rating_dialog_example.dart';

class TextInputDialog {
  /// [onCompleted] بيرجع النص اللي المستخدم دخله
  static Future<void> show(
    BuildContext context, {
    required String title,
    bool? isCode,
    // required String description,
    required void Function(String text) onCompleted,
  }) async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // زر الإغلاق
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.black,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24.r),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // العنوان

                SizedBox(height: 6.h),

                // الوصف
                const Divider(
                  thickness: 1.5,
                ),
                SizedBox(height: 20.h),
                DefaultFormField(
                  controller: controller,
                  maxLines: isCode == true ? 1 : 3,
                  hintText: AppStrings.writeHere.tr(),
                  borderRadius: 8.r,
                  borderColor: ColorManager.greyBorder,
                )

                // TextField عادي
                ,
                SizedBox(height: 24.h),

                // زر التأكيد
                DefaultButtonWidget(
                    text: AppStrings.send.tr(),
                    color: ColorManager.primary,
                    textColor: Colors.white,
                    radius: 12.r,
                    onPressed: () {
                      final text = controller.text;

                     onCompleted(text);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
