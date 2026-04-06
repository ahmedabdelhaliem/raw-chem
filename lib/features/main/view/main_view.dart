import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/features/categories/view/categories_view.dart';
import 'package:raw_chem/features/home/view/home_view.dart';
import 'package:raw_chem/features/price_tracker/view/price_tracker_view.dart';
import 'package:raw_chem/features/profile/view/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/app/imports.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorManager.white,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Rubik',
            ),
            unselectedLabelStyle: TextStyle(fontSize: 10.sp, fontFamily: 'Rubik'),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 24.sp),
                activeIcon: Icon(Icons.home_rounded, size: 24.sp),
                label: AppStrings.home.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined, size: 24.sp),
                activeIcon: Icon(Icons.grid_view_rounded, size: 24.sp),
                label: AppStrings.categories.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_outlined, size: 24.sp),
                activeIcon: Icon(Icons.trending_up_rounded, size: 24.sp),
                label: AppStrings.priceTracker.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 24.sp),
                activeIcon: Icon(Icons.person_rounded, size: 24.sp),
                label: AppStrings.account.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
