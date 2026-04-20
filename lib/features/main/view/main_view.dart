import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/features/categories/view/categories_view.dart';
import 'package:raw_chem/features/home/view/home_view.dart';
import 'package:raw_chem/features/price_tracker/view/price_tracker_view.dart';
import 'package:raw_chem/features/profile/view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  late PageController _pageController;

  late final List<Widget> _pages = [
    const HomeView(),
    const CategoriesView(),
    BlocProvider(
      create: (context) => instance<PriceTrackerCubit>(),
      child: const PriceTrackerView(),
    ),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: ColorManager.bg,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: 0.08),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: ColorManager.primary.withValues(alpha: 0.15), width: 1.2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, AppStrings.home.tr()),
                  _buildNavItem(
                    1,
                    Icons.grid_view_outlined,
                    Icons.grid_view_rounded,
                    AppStrings.categories.tr(),
                  ),
                  _buildNavItem(
                    2,
                    Icons.trending_up_outlined,
                    Icons.trending_up_rounded,
                    AppStrings.priceTracker.tr(),
                  ),
                  _buildNavItem(
                    3,
                    Icons.person_outline_rounded,
                    Icons.person_rounded,
                    AppStrings.account.tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          HapticFeedback.lightImpact();
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuart,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.greyTextColor.withValues(alpha: 0.8),
                size: 24.sp,
              ),
            ),
            if (isSelected) ...[
              SizedBox(height: 2.h),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w900,
                      color: ColorManager.primary,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
