import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/language_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  late String _selectedLanguageCode;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguageCode = context.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.language.tr(),
          style: TextStyle(
            color: ColorManager.blackText,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.blackText),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.chooseLanguage.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.blackText,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                _buildLanguageCard(
                  title: AppStrings.arabic.tr(),
                  subtitle: AppStrings.arabicSubtitle.tr(),
                  flag: '🇸🇦',
                  locale: ARABIC_LOCALE,
                  isSelected: _selectedLanguageCode == ARABIC,
                ),
                SizedBox(height: 16.h),
                _buildLanguageCard(
                  title: AppStrings.english.tr(),
                  subtitle: AppStrings.englishSubtitle.tr(),
                  flag: '🇺🇸',
                  locale: ENGLISH_LOCALE,
                  isSelected: _selectedLanguageCode == ENGLISH,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required String subtitle,
    required String flag,
    required Locale locale,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? ColorManager.primary : Colors.transparent,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? ColorManager.primary.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          if (!isSelected && !_isLoading) {
            setState(() {
              _isLoading = true;
            });

            // Set locale for UI
            await context.setLocale(locale);
            // Sync with AppPreferences so Dio interceptor sends correct Accept-Language
            await instance<AppPreferences>().setAppLanguage(locale.languageCode);

            // Small delay for smooth transition
            await Future.delayed(const Duration(milliseconds: 500));

            // Navigate back to splash/root to refresh full app lifecycle
            if (mounted) {
              context.go(AppRouters.root);
            }
          }
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Row(
            children: [
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.primary.withValues(alpha: 0.1)
                      : ColorManager.bg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.blackText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorManager.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: ColorManager.primary,
                  size: 24.sp,
                )
              else
                Icon(
                  Icons.circle_outlined,
                  color: ColorManager.greyBorder,
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
