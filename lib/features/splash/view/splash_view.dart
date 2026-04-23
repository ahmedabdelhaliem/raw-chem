import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/http/connectivity_service.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> { 
  Timer? _timer;
  bool _showNoInternet = false;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 2 ), _checkConnectivityAndNavigate);
  }

  Future<void> _checkConnectivityAndNavigate() async {
    if (_isChecking) return;
    _isChecking = true;

    try {
      final hasInternet = await instance<ConnectivityService>().hasInternet;

      if (!hasInternet) {
        if (mounted) {
          setState(() {
            _showNoInternet = true;
            _isChecking = false;
          });
        }
        return;
      }

      if (mounted) _goNext();
    } catch (_) {
      if (mounted) _goNext();
    }
  }

  void _goNext() {
    final prefs = instance<AppPreferences>();
    final token = prefs.getToken();
    final isOnBoardingViewed = prefs.isOnBoardingScreenViewed();

    if (token.isNotEmpty) {
      context.go(AppRouters.btmNav);
    } else {
      // FOR TEST: Always go to Onboarding to test
      context.go(AppRouters.onBoardingView);
    }
  }

  void _onRetry() {
    setState(() {
      _showNoInternet = false;
      _isChecking = false;
    });
    _checkConnectivityAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Premium Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    ColorManager.lightGreen.withValues(alpha: 0.3),
                    ColorManager.lightGreen.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
          ),

          // Animated Orbs for a "Chemical/Liquid" feel
          _buildAnimatedOrb(
            top: -50.h,
            left: -50.w,
            color: ColorManager.primary.withValues(alpha: 0.05),
            size: 200.w,
          ),
          _buildAnimatedOrb(
            bottom: -80.h,
            right: -80.w,
            color: ColorManager.secondry.withValues(alpha: 0.1),
            size: 250.w,
          ),

          // Main Content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: _showNoInternet ? _buildNoInternetState() : _buildLogoState(),
          ),


        ],
      ),
    );
  }

  Widget _buildAnimatedOrb({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child:
          Container(
                width: size,
                height: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 4.seconds,
                curve: Curves.easeInOut,
              )
              .blur(begin: const Offset(30, 30), end: const Offset(50, 50)),
    );
  }

  Widget _buildLogoState() {
    return Center(
      key: const ValueKey('logo_state'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo with sophisticated animation
          Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.1),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Image.asset(ImageAssets.logo, width: 140.w, height: 140.w, fit: BoxFit.contain),
              )
              .animate()
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1, 1),
                duration: 1200.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: 800.ms)
              .shimmer(
                delay: 1500.ms,
                duration: 1500.ms,
                color: ColorManager.primary.withValues(alpha: 0.1),
              ),

          SizedBox(height: 30.h),

          // Slogan / Project Name
          Text(
                AppStrings.appName.tr(),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: ColorManager.primary,
                  letterSpacing: 2,
                ),
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 800.ms)
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack),

          SizedBox(height: 8.h),

          Text(
           AppStrings.appDescription.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.greyTextColor,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn(delay: 900.ms, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildNoInternetState() {
    return Center(
      key: const ValueKey('no_internet_state'),
      child:
          Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                padding: EdgeInsets.all(30.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Modern Error Icon
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: ColorManager.red.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.wifi_off_rounded, size: 50.sp, color: ColorManager.red),
                    ).animate().shake(duration: 500.ms, hz: 4),

                    SizedBox(height: 24.h),

                    Text(
                      AppStrings.noInternetTitle.tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.blackText,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      AppStrings.noInternetMessage.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorManager.greyTextColor,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32.h),

                    // Premium Retry Button
                    SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: ElevatedButton(
                        onPressed: _onRetry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: ColorManager.primary.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh_rounded, size: 20.sp),
                            SizedBox(width: 10.w),
                            Text(
                              AppStrings.retry.tr(),
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
