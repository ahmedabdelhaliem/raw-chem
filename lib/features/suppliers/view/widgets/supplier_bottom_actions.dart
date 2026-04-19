import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class SupplierBottomActions extends StatefulWidget {
  final SupplierModel supplier;

  const SupplierBottomActions({super.key, required this.supplier});

  @override
  State<SupplierBottomActions> createState() => _SupplierBottomActionsState();
}

class _SupplierBottomActionsState extends State<SupplierBottomActions> {
  int? _chatId;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                if (_chatId == null)
                  Expanded(
                    flex: 3,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _ActionButton(
                            onPressed: () => _handleStartChat(context),
                            icon: Icons.link_rounded,
                            label: AppStrings.contactSupplier.tr(),
                            color: ColorManager.primary,
                          ),
                  )
                else
                  _ActionButton(
                    onPressed: () => _navigateToChat(context),
                    icon: Icons.chat_bubble_outline_rounded,
                    label: '',
                    color: const Color(0xFF25D366),
                    isCompact: true,
                  ),
                SizedBox(width: 14.w),
                Expanded(
                  flex: 2,
                  child: _ActionButton(
                    onPressed: widget.supplier.phone != null ? () => _makeCall(widget.supplier.phone!) : null,
                    icon: Iconsax.call,
                    label: AppStrings.callUsAt.tr(),
                    color: const Color(0xFF1B3D2F),
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

  Future<void> _handleStartChat(BuildContext context) async {
    setState(() => _isLoading = true);

    final result = await instance<ChatRepo>().createChat(widget.supplier.id);

    result.fold(
      (failure) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (response) {
        setState(() {
          _isLoading = false;
          _chatId = response.chatId;
        });

        _navigateToChat(context);
      },
    );
  }

  void _navigateToChat(BuildContext context) {
    if (_chatId == null) return;
    context.push(
      AppRouters.chatView,
      extra: {
        'chatId': _chatId,
        'supplierName': widget.supplier.name ?? 'Chat',
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final bool isCompact;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isCompact
          ? InkWell(
              onTap: onPressed,
              child: Container(
                width: 55.h,
                height: 55.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: Colors.white, size: 24.sp),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.white, size: 20.sp),
              label: label.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
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
