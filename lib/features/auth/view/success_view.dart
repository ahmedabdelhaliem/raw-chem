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

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          // Background Gradient & Floating Particles
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
                          _buildAnimatedIcon(),
                          SizedBox(height: 32.h),
                          Text(
                            AppStrings.passwordChangedTitle.tr(),
                            textAlign: TextAlign.center,
                            style: getBoldStyle(color: ColorManager.textColor, fontSize: 26.sp),
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                          SizedBox(height: 12.h),
                          Text(
                            AppStrings.passwordChangedSubtitle.tr(),
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                              color: ColorManager.greyTextColor,
                              fontSize: 15.sp,
                            ).copyWith(height: 1.5),
                          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    // Action Button
                    DefaultButtonWidget(
                      onPressed: () => context.go(AppRouters.loginView),
                      text: AppStrings.backToLogin.tr(),
                      color: ColorManager.primary,
                      textColor: ColorManager.white,
                      radius: 16.r,
                    ).animate().fadeIn(delay: 1.seconds).slideY(begin: 0.5, end: 0),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary.withValues(alpha: 0.08),
            ColorManager.white,
            ColorManager.primary.withValues(alpha: 0.04),
          ],
        ),
      ),
      child: Stack(
        children: List.generate(6, (index) {
          final random = math.Random(index);
          return Positioned(
            top: random.nextDouble() * 1.sh,
            left: random.nextDouble() * 1.sw,
            child:
                Container(
                      width: (40 + random.nextInt(60)).w,
                      height: (40 + random.nextInt(60)).w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.03),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .move(
                      begin: Offset.zero,
                      end: Offset(random.nextDouble() * 20, random.nextDouble() * 20),
                      duration: (3 + random.nextInt(4)).seconds,
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
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          decoration: BoxDecoration(
            color: ColorManager.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: ColorManager.white.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    ).animate().scale(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1),
      duration: 600.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildAnimatedIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer Glow
        Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3), duration: 2.seconds),

        // Main Icon Circle
        Container(
          width: 75.w,
          height: 75.w,
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary,
                blurRadius: 15,
                spreadRadius: -5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.check_rounded, color: ColorManager.white, size: 45),
        ).animate().scale(
          begin: Offset.zero,
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.elasticOut,
        ),
      ],
    );
  }

  List<Widget> _buildConfetti(BuildContext context) {
    final colors = [ColorManager.primary, Colors.orange, Colors.blue, Colors.pink, Colors.yellow];
    return List.generate(40, (index) {
      final random = math.Random(index);
      final color = colors[random.nextInt(colors.length)];
      final size = (4 + random.nextInt(6)).toDouble();

      return Positioned(
        top: 0.4.sh, // Start from center
        left: 0.5.sw,
        child:
            Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.8),
                    shape: random.nextBool() ? BoxShape.circle : BoxShape.rectangle,
                  ),
                )
                .animate()
                .move(
                  begin: Offset.zero,
                  end: Offset(
                    (random.nextDouble() - 0.5) * 1.5.sw, // Spread wide
                    (random.nextDouble() + 0.5) * 0.6.sh, // Fall down
                  ),
                  duration: (1.5 + random.nextDouble()).seconds,
                  curve: Curves.easeOutQuart,
                )
                .rotate(begin: 0, end: random.nextDouble() * 4, duration: 2.seconds)
                .fadeOut(delay: 1.seconds, duration: 500.ms),
      );
    });
  }
}
