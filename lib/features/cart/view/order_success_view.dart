import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/features/main/view/main_view.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            
            // Success Icon with Animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF006B3E),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 60.sp,
                ),
              ),
            ),
            
            SizedBox(height: 40.h),
            
            // Success Text
            Text(
              'تم قبول طلبك',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.blackText,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 15.h),
            
            Text(
              'تم تسجيل طلبك وهو في طريقه\nإلى المعالجة.',
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorManager.greyTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            const Spacer(flex: 2),
            
            // Return Button
            DefaultButtonWidget(
              text: 'العودة إلى الصفحة الرئيسية',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainView()),
                  (route) => false,
                );
              },
              color: ColorManager.white,
              textColor: ColorManager.blackText,
              withBorder: false,
              elevation: 0,
              fontSize: 14.sp,
              isUnderLine: false,
            ),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
