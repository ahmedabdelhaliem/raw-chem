import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierBottomActions extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierBottomActions({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    onPressed: supplier.phone != null ? () => _openWhatsApp(supplier.phone!) : null,
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'WhatsApp',
                    color: const Color(0xFF25D366),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: _ActionButton(
                    onPressed: supplier.phone != null ? () => _makeCall(supplier.phone!) : null,
                    icon: Iconsax.call,
                    label: 'Call Now',
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makeCall(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  Future<void> _openWhatsApp(String phone) async {
    final String url = "https://wa.me/$phone";
    final Uri whatsappUri = Uri.parse(url);
    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {}
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20.sp),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          elevation: 0,
        ),
      ),
    );
  }
}
