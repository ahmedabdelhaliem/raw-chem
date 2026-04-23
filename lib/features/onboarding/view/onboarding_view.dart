import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
import 'package:raw_chem/common/widgets/shimmer_container_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  int _currentIndex = 0;

  void _finishOnBoarding() {
    _appPreferences.setOnBoardingScreenViewed();
    context.go(AppRouters.loginView);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<OnboardingCubit>()..fetchWelcomeScreens(),
      child: BlocBuilder<OnboardingCubit, BaseState<WelcomeScreenModel>>(
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  // Premium Background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            ColorManager.lightGreen.withValues(alpha: 0.2),
                            ColorManager.lightGreen.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildAnimatedOrb(
                    top: -40.h,
                    right: -40.w,
                    color: ColorManager.primary.withValues(alpha: 0.05),
                    size: 180.w,
                  ),
                  _buildAnimatedOrb(
                    bottom: 100.h,
                    left: -60.w,
                    color: ColorManager.secondry.withValues(alpha: 0.1),
                    size: 220.w,
                  ),
                  Center(
                    child: Container(
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
                      child: Image.asset(ImageAssets.logo, width: 100.w, height: 100.w, fit: BoxFit.contain),
                    )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05), duration: 1.seconds, curve: Curves.easeInOut)
                        .shimmer(duration: 1.seconds, color: ColorManager.primary.withValues(alpha: 0.2)),
                  ),
                ],
              ),
            );
          }
          if (state.isSuccess) {
            final screens = state.items;

            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  // Premium Background (Consistent with Splash)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            ColorManager.lightGreen.withValues(alpha: 0.2),
                            ColorManager.lightGreen.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Animated Orbs
                  _buildAnimatedOrb(
                    top: -40.h,
                    right: -40.w,
                    color: ColorManager.primary.withValues(alpha: 0.05),
                    size: 180.w,
                  ),
                  _buildAnimatedOrb(
                    bottom: 100.h,
                    left: -60.w,
                    color: ColorManager.secondry.withValues(alpha: 0.1),
                    size: 220.w,
                  ),

                  // Main Content
                  SafeArea(
                    child: Column(
                      children: [
                        // Header
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _finishOnBoarding,
                                style: TextButton.styleFrom(
                                  foregroundColor: ColorManager.primary,
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                                ),
                                child: Text(
                                  AppStrings.skip.tr(),
                                  style: getBoldStyle(color: ColorManager.primary, fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // PageView
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: screens.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return OnBoardingPage(model: screens[index]);
                            },
                          ),
                        ),

                        // Bottom Navigation Area
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Smooth Indicator
                              if (screens.isNotEmpty)
                                SmoothPageIndicator(
                                  controller: _pageController,
                                  count: screens.length,
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: ColorManager.primary,
                                    dotColor: ColorManager.primary.withValues(alpha: 0.15),
                                    dotHeight: 8.h,
                                    dotWidth: 8.w,
                                    expansionFactor: 4,
                                    spacing: 6.w,
                                  ),
                                ),
                              if (screens.isEmpty) const Spacer(),

                              // Premium Next/Get Started Button
                              _buildActionButton(screens.length),
                            ],
                          ),
                        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // Error State
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off_rounded, size: 60.sp, color: ColorManager.red),
                  SizedBox(height: 15.h),
                  TextButton(
                    onPressed: () => context.read<OnboardingCubit>().fetchWelcomeScreens(),
                    child: Text(
                      'Retry',
                      style: getBoldStyle(color: ColorManager.primary, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedOrb({double? top, double? bottom, double? left, double? right, required Color color, required double size}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 5.seconds)
          .blur(begin: const Offset(30, 30), end: const Offset(50, 50)),
    );
  }

  Widget _buildActionButton(int totalScreens) {
    bool isLast = totalScreens == 0 || _currentIndex == totalScreens - 1;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 56.h,
      width: isLast ? 160.w : 56.w,
      child: ElevatedButton(
        onPressed: () {
          if (isLast) {
            _finishOnBoarding();
          } else {
            _pageController.nextPage(duration: 500.ms, curve: Curves.easeInOut);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 6,
          shadowColor: ColorManager.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isLast ? 16.r : 28.r),
          ),
        ),
        child: isLast
            ? Text(
                AppStrings.getStart.tr(),
                style: getBoldStyle(color: Colors.white, fontSize: 16.sp),
              )
            : Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final WelcomeScreenModel model;
  const OnBoardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h), // Top padding for centering feel
            // Image with Premium container
            Container(
              height: 280.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: (model.image != null && model.image!.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: model.image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            ShimmerContainerWidget(height: 280.h, radios: 30.r),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.image_not_supported_outlined,
                              size: 40.sp, color: ColorManager.greyTextColor),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack),

            SizedBox(height: 40.h),

            // Title
            Text(
              (context.locale.languageCode == 'ar' ? model.titleAr : model.titleEn) ?? '',
              textAlign: TextAlign.center,
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: 24.sp,
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),

            SizedBox(height: 15.h),

            // Sub-branding point info
            Text(
              "Highest quality raw materials from global suppliers delivered right to your facility.",
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.greyTextColor,
                fontSize: 14.sp,
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
            SizedBox(height: 20.h), // Bottom padding
          ],
        ),
      ),
    );
  }
}
