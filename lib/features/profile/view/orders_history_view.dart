import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/order_card_widget.dart';
import 'package:raw_chem/app/imports.dart';

class OrdersHistoryView extends StatefulWidget {
  const OrdersHistoryView({super.key});

  @override
  State<OrdersHistoryView> createState() => _OrdersHistoryViewState();
}

class _OrdersHistoryViewState extends State<OrdersHistoryView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: AppBar(
        title: Text(
          AppStrings.ordersHistory.tr(),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: ColorManager.white,
              unselectedLabelColor: ColorManager.greyTextColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorManager.primary,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              dividerColor: Colors.transparent,
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: AppStrings.currentOrders.tr()),
                Tab(text: AppStrings.previousOrders.tr()),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersListTab(status: ['pending_supplier', 'accepted']),
          _buildOrdersListTab(status: 'rejected'),
        ],
      ),
    );
  }

  Widget _buildOrdersListTab({required dynamic status}) {
    return BlocProvider(
      create: (context) => instance<PurchaseOrdersHistoryCubit>()..getPurchaseOrders(status: status),
      child: BlocBuilder<PurchaseOrdersHistoryCubit, BaseState<PaginatedResponse<PurchaseOrderModel>>>(
        builder: (context, state) {
          if (state.isLoading && (state.data?.data.isEmpty ?? true)) {
            return _buildOrdersHistoryShimmer();
          }

          if (state.isError && (state.data?.data.isEmpty ?? true)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? AppStrings.unknownError.tr()),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context.read<PurchaseOrdersHistoryCubit>().getPurchaseOrders(status: status),
                    child: Text(AppStrings.retry.tr()),
                  ),
                ],
              ),
            );
          }

          final orders = state.data?.data ?? [];
          if (orders.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<PurchaseOrdersHistoryCubit>().getPurchaseOrders(status: status),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                
                // Determine status label and color
                String statusLabel = '';
                Color statusColor = Colors.grey;
                
                if (order.status == 'accepted' || order.status == 'awaiting_payment') {
                    statusLabel = AppStrings.statusAccepted.tr();
                    statusColor = ColorManager.primary;
                } else if (order.status == 'rejected') {
                    statusLabel = AppStrings.statusRejected.tr();
                    statusColor = Colors.red;
                } else if (order.status == 'pending_supplier') {
                    statusLabel = AppStrings.statusPending.tr();
                    statusColor = Colors.amber.shade900;
                } else {
                    statusLabel = AppStrings.status.tr();
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: OrderCardWidget(
                    orderNumber: order.invoice?.invoiceNumber ?? '#PO-${order.id}',
                    date: order.createdAt?.split('T').first ?? '',
                    amount: '${order.invoice?.grandTotal ?? order.supplierQuote?.grandTotal ?? order.estimatedSubtotal} ${AppStrings.egp.tr()}',
                    status: statusLabel,
                    statusColor: statusColor,
                    onTapDetails: () {
                      context.push(AppRouters.orderDetailsView, extra: order);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 80.sp,
              color: ColorManager.primary.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            AppStrings.noDataFound.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.blackText,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'لا توجد طلبات في هذا القسم حالياً. ابدأ استكشاف المواد الخام الآن!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorManager.greyTextColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
    );
  }

  Widget _buildOrdersHistoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          );
        },
      ),
    );
  }
}
