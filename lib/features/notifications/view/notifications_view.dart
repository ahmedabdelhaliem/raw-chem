import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/shimmer_container_widget.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      context.read<NotificationsCubit>().loadMoreNotifications();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.notifications.tr(),
        backgroundColor: ColorManager.white,
        titleColor: ColorManager.blackText,
        withLeading: true,
      ),
      body: BlocBuilder<NotificationsCubit, BaseState<NotificationModel>>(
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return _buildLoadingState();
          }

          if (state.isFailure && state.items.isEmpty) {
            return _buildErrorState(context, state.errorMessage);
          }

          final notifications = state.items;

          if (notifications.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () => context.read<NotificationsCubit>().fetchNotifications(isReload: true),
            color: ColorManager.primary,
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: notifications.length + (state.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                if (index < notifications.length) {
                  return _buildNotificationCard(context, notifications[index]);
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationModel notification) {
    final DateTime? date = DateTime.tryParse(notification.createdAt ?? '');
    final String timeAgo = date != null ? DateFormat('MMM dd, hh:mm a').format(date) : '';

    return GestureDetector(
      onTap: () => _handleNotificationTap(context, notification),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(notification.metadata?.type),
                color: ColorManager.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.blackText,
                          ),
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorManager.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notification.body ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorManager.lightGreyTextColor2,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  void _handleNotificationTap(BuildContext context, NotificationModel notification) {
    final metadata = notification.metadata;
    if (metadata == null) return;

    if (metadata.type == 'supplier_material_purchase_order') {
       // If we have an order ID, we can try to navigate.
       if (metadata.purchaseOrderId != null) {
         // Create a skeleton PurchaseOrderModel to pass, or fetch it.
         // For now, based on current AppRouter, it expects a full model.
         // We might need to modify the router to accept ID and fetch, but here is a workaround:
         final skeletonOrder = PurchaseOrderModel(
           id: metadata.purchaseOrderId!,
           status: metadata.status ?? 'pending',
           quantity: 0,
           listedUnitPrice: '0.0',
           estimatedSubtotal: '0.0',
           supplierMaterial: null, // This might cause issues if view uses it immediately
         );
         context.push(AppRouters.orderDetailsView, extra: skeletonOrder);
       }
    }
  }

  IconData _getNotificationIcon(String? type) {
    switch (type) {
      case 'supplier_material_purchase_order':
        return Icons.shopping_bag_outlined;
      case 'chat_message':
        return Icons.chat_bubble_outline;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Widget _buildLoadingState() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemCount: 8,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => ShimmerContainerWidget(
        height: 80.h,
        radios: 16.r,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80.sp, color: ColorManager.lightGreyTextColor),
          SizedBox(height: 16.h),
          Text(
            AppStrings.noNotifications.tr(),
            style: TextStyle(fontSize: 16.sp, color: ColorManager.greyTextColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message ?? AppStrings.unknownError.tr(), textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.read<NotificationsCubit>().fetchNotifications(isReload: true),
              child: Text(AppStrings.retry.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
