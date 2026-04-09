import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/common/widgets/default_form_field.dart';
import 'package:go_router/go_router.dart';

class ConnectSupplierView extends StatefulWidget {
  const ConnectSupplierView({super.key});

  @override
  State<ConnectSupplierView> createState() => _ConnectSupplierViewState();
}

class _ConnectSupplierViewState extends State<ConnectSupplierView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            DefaultFormField(
              controller: _nameController,
              title: AppStrings.fullName.tr(),
              hintText: AppStrings.fullNameHint.tr(),
              fillColor: ColorManager.white,
            ),
            SizedBox(height: 20.h),
            DefaultFormField(
              controller: _emailController,
              title: AppStrings.email.tr(),
              hintText: 'example@gmail.com',
              fillColor: ColorManager.white,
              suffixIcon: const Icon(Icons.email_outlined, color: ColorManager.greyTextColor),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            DefaultFormField(
              controller: _messageController,
              title: AppStrings.messageLabel.tr(),
              hintText: AppStrings.messageHint.tr(),
              fillColor: ColorManager.white,
              maxLines: 5,
            ),
            SizedBox(height: 40.h),

            // Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                    text: AppStrings.requestQuoteButton.tr(),
                    onPressed: () {
                      // TODO: Submit logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppStrings.requestSentSuccess.tr())),
                      );
                      Navigator.pop(context);
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
          
          context.push(
            AppRouters.chatView,
            extra: {
              'chatId': response.chatId,
              'supplierName': AppStrings.supportComplaints.tr(),
            },
          );
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
