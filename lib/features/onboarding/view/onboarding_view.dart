import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
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
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state.isSuccess) {
            final screens = state.items;
            if (screens.isEmpty) {
              return const Scaffold();
            }
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: screens.length,
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
                            if (_currentIndex == screens.length - 1) {
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
                            (_currentIndex == screens.length - 1
                                    ? AppStrings.getStart
                                    : AppStrings.next)
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
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.read<OnboardingCubit>().fetchWelcomeScreens(),
                child: const Text('Retry'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final WelcomeScreenModel model;
  const OnBoardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (model.image != null)
          Image.network(
            model.image!,
            height: 300.h,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ).animate().fade(duration: 500.ms).scale(begin: const Offset(0.8, 0.8), duration: 500.ms),
        SizedBox(height: 40.h),
        Text(
          (context.locale.languageCode == 'ar' ? model.titleAr : model.titleEn) ?? '',
          textAlign: TextAlign.center,
          style: getBoldStyle(color: ColorManager.textColor, fontSize: 24.sp),
        ).animate().slideY(begin: 0.5, end: 0, duration: 400.ms).fadeIn(),
        SizedBox(height: 15.h),
      ],
    );
  }
}
