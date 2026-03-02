import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/assets_manager.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/resources/styles_manager.dart';
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

  final List<OnBoardingModel> _pages = [
    OnBoardingModel(
      title: AppStrings.onBoardingTitle1,
      body: AppStrings.onBoardingBody1,
      image: ImageAssets.onBoarding1,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle2,
      body: AppStrings.onBoardingBody2,
      image: ImageAssets.onBoarding2,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle3,
      body: AppStrings.onBoardingBody3,
      image: ImageAssets.onBoarding3,
    ),
  ];

  void _finishOnBoarding() {
    _appPreferences.setOnBoardingScreenViewed();
    context.go(AppRouters.loginView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _finishOnBoarding,
            child: Text(
              AppStrings.skip.tr(),
              style: getMediumStyle(color: ColorManager.primary, fontSize: 16.sp),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingPage(model: _pages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: ColorManager.primary,
                    dotColor: ColorManager.lightGrey,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 4,
                    spacing: 8.w,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == _pages.length - 1) {
                      _finishOnBoarding();
                    } else {
                      _pageController.nextPage(duration: 300.ms, curve: Curves.easeInOut);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    (_currentIndex == _pages.length - 1 ? AppStrings.getStart : AppStrings.next)
                        .tr(),
                    style: getBoldStyle(color: ColorManager.white, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          model.image,
          height: 300.h,
        ).animate().fade(duration: 500.ms).scale(begin: const Offset(0.8, 0.8), duration: 500.ms),
        SizedBox(height: 40.h),
        Text(
          model.title.tr(),
          textAlign: TextAlign.center,
          style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
        ).animate().slideY(begin: 0.5, end: 0, duration: 400.ms).fadeIn(),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            model.body.tr(),
            textAlign: TextAlign.center,
            style: getRegularStyle(color: ColorManager.greyTextColor, fontSize: 16.sp),
          ).animate().slideY(begin: 0.5, end: 0, delay: 100.ms, duration: 400.ms).fadeIn(),
        ),
      ],
    );
  }
}

class OnBoardingModel {
  final String title;
  final String body;
  final String image;

  OnBoardingModel({required this.title, required this.body, required this.image});
}
