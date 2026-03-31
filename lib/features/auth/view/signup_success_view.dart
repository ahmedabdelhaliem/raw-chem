import 'dart:math' as math;
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

class SignupSuccessView extends StatelessWidget {
  const SignupSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorManager.textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Premium Animated Background
          _buildPremiumBackground(),

          // Main Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Glassmorphic Card
                    _buildGlassCard(
                      context,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildAnimatedCelebrateIcon(),
                          SizedBox(height: 32.h),
                          Text(
                            AppStrings.signupSuccessTitle.tr(),
                            textAlign: TextAlign.center,
                            style: getBoldStyle(color: ColorManager.textColor, fontSize: 26.sp),
                          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                          SizedBox(height: 12.h),
                          Text(
                            AppStrings.signupSuccessSubtitle.tr(),
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                              color: ColorManager.greyTextColor,
                              fontSize: 15.sp,
                            ).copyWith(height: 1.6),
                          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    // Action Button
                    DefaultButtonWidget(
                      onPressed: () => context.go(AppRouters.loginView),
                      text: AppStrings.exploreApp.tr(),
                      color: ColorManager.primary,
                      textColor: ColorManager.white,
                      radius: 16.r,
                    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5, end: 0),
                  ],
                ),
              ),
            ),
          ),

          // Confetti Burst Overlay
          ..._buildConfetti(context),
        ],
      ),
    );
  }

  Widget _buildPremiumBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            ColorManager.primary.withOpacity(0.06),
            ColorManager.white,
            ColorManager.primary.withOpacity(0.06),
          ],
        ),
      ),
      child: Stack(
        children: List.generate(8, (index) {
          final random = math.Random(index + 100);
          return Positioned(
            top: random.nextDouble() * 1.sh,
            left: random.nextDouble() * 1.sw,
            child:
                Container(
                      width: (30 + random.nextInt(50)).w,
                      height: (30 + random.nextInt(50)).w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withOpacity(0.04),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .move(
                      begin: Offset.zero,
                      end: Offset(random.nextDouble() * 30, random.nextDouble() * 30),
                      duration: (4 + random.nextInt(3)).seconds,
                      curve: Curves.easeInOut,
                    ),
          );
        }),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
          decoration: BoxDecoration(
            color: ColorManager.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: ColorManager.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: child,
        ),
      ),
    ).animate().scale(
      begin: const Offset(0.7, 0.7),
      end: const Offset(1, 1),
      duration: 700.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildAnimatedCelebrateIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsing background circles
        ...List.generate(2, (index) {
          return Container(
                width: (110 + (index * 30)).w,
                height: (110 + (index * 30)).w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.08 - (index * 0.03)),
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: Offset(1.1 + (index * 0.1), 1.1 + (index * 0.1)),
                duration: (2 + index).seconds,
              );
        }),

        // Main Icon
        Container(
          width: 85.w,
          height: 85.w,
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary,
                blurRadius: 20,
                spreadRadius: -5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.celebration_rounded, color: ColorManager.white, size: 45),
        ).animate().scale(
          begin: Offset.zero,
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
        ),
      ],
    );
  }

  List<Widget> _buildConfetti(BuildContext context) {
    final colors = [ColorManager.primary, Colors.amber, Colors.lightBlue, Colors.pinkAccent];
    return List.generate(50, (index) {
      final random = math.Random(index + 200);
      final color = colors[random.nextInt(colors.length)];
      final size = (5 + random.nextInt(5)).toDouble();

      return Positioned(
        top: 0.45.sh,
        left: 0.5.sw,
        child:
            Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(random.nextBool() ? 2 : 10),
                  ),
                )
                .animate()
                .move(
                  begin: Offset.zero,
                  end: Offset(
                    (random.nextDouble() - 0.5) * 1.8.sw,
                    (random.nextDouble() + 0.5) * 0.7.sh,
                  ),
                  duration: (2 + random.nextDouble()).seconds,
                  curve: Curves.easeOutCubic,
                )
                .rotate(begin: 0, end: random.nextDouble() * 6, duration: 2.5.seconds)
                .fadeOut(delay: 1.2.seconds, duration: 800.ms),
      );
    });
  }
}
