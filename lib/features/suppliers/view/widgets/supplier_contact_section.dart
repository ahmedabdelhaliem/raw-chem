import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierContactSection extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierContactSection({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ModernContactCard(
          icon: Iconsax.location,
          title: AppStrings.address.tr(),
          value: supplier.address ?? AppStrings.notProvided.tr(),
          color: const Color(0xFF6366F1), // Indigo
        ),
        _ModernContactCard(
          icon: Iconsax.call,
          title: AppStrings.phone.tr(),
          value: supplier.phone ?? AppStrings.notProvided.tr(),
          color: const Color(0xFF10B981), // Emerald
          onTap: supplier.phone != null ? () => _makeCall(supplier.phone!) : null,
        ),
        _ModernContactCard(
          icon: Iconsax.sms,
          title: AppStrings.email.tr(),
          value: supplier.email ?? AppStrings.notProvided.tr(),
          color: const Color(0xFFF59E0B), // Amber
          onTap: supplier.email != null ? () => _sendEmail(supplier.email!) : null,
        ),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: 0.05);
  }

  Future<void> _makeCall(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(launchUri);
  }
}

class _ModernContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _ModernContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, size: 22.sp, color: color),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.greyTextColor.withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.blackText,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(Iconsax.arrow_right_3, size: 18.sp, color: color.withValues(alpha: 0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
