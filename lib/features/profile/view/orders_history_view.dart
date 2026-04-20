import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/common/widgets/order_card_widget.dart';
import 'package:raw_chem/core/constants/order_statuses.dart';

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
    _tabController = TabController(length: 3, vsync: this);
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
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
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
              labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: AppStrings.tabPending.tr()),
                Tab(text: AppStrings.tabAccepted.tr()),
                Tab(text: AppStrings.tabRejected.tr()),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrdersListTab(key: const PageStorageKey('pending'), status: OrderStatuses.pendingTab),
          OrdersListTab(key: const PageStorageKey('accepted'), status: OrderStatuses.acceptedTab),
          OrdersListTab(key: const PageStorageKey('rejected'), status: OrderStatuses.rejectedTab),
        ],
      ),
    );
  }
}

class OrdersListTab extends StatefulWidget {
  final List<String> status;
  const OrdersListTab({super.key, required this.status});

  @override
  State<OrdersListTab> createState() => _OrdersListTabState();
}

class _OrdersListTabState extends State<OrdersListTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<PurchaseOrdersHistoryCubit>()..getPurchaseOrders(status: null),
      child: BlocBuilder<PurchaseOrdersHistoryCubit, BaseState<PurchaseOrderModel>>(
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return _buildOrdersHistoryShimmer();
          }

          if (state.isError && state.items.isEmpty) {
            return DefaultErrorWidget(
              errorMessage: state.errorMessage ?? AppStrings.unknownError.tr(),
              onPressed: () =>
                  context.read<PurchaseOrdersHistoryCubit>().getPurchaseOrders(status: null),
            );
          }

          // Client-side filtering based on tab status
          final filteredOrders = state.items.where((order) => widget.status.contains(order.status)).toList();

          if (filteredOrders.isEmpty && !state.isLoading) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<PurchaseOrdersHistoryCubit>().getPurchaseOrders(status: null),
            child: PaginatedListWrapper(
              scrollController: _scrollController,
              paginationHandler: context.read<PurchaseOrdersHistoryCubit>().paginationHandler,
              fetchFunction: (page, limit, [params]) => instance<RawMaterialsRepo>().getPurchaseOrders(page: page),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];

                  // Determine status label and color
                  String statusLabel = '';
                  Color statusColor = Colors.grey;

                  if (order.status == OrderStatuses.accepted ||
                      order.status == OrderStatuses.awaitingPayment ||
                      order.status == OrderStatuses.completed) {
                    statusLabel = AppStrings.statusAccepted.tr();
                    statusColor = ColorManager.primary;
                  } else if (order.status == OrderStatuses.rejected ||
                      order.status == OrderStatuses.cancelled ||
                      order.status == OrderStatuses.failed) {
                    statusLabel = AppStrings.statusRejected.tr();
                    statusColor = Colors.red;
                  } else if (order.status == OrderStatuses.pending ||
                      order.status == 'pending_supplier') {
                    statusLabel = AppStrings.statusPending.tr();
                    statusColor = Colors.amber.shade900;
                  } else {
                    statusLabel = AppStrings.status.tr();
                  }

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: OrderCardWidget(
                      orderNumber: order.invoice?.invoiceNumber ?? '#PO-${order.id}',
                      date: order.createdAt?.split('T').first ?? '',
                      amount:
                          '${order.invoice?.grandTotal ?? order.supplierQuote?.grandTotal ?? order.estimatedSubtotal} ${AppStrings.egp.tr()}',
                      status: statusLabel,
                      statusColor: statusColor,
                      onTapDetails: () {
                        context.push(AppRouters.orderDetailsView, extra: order);
                      },
                    ),
                  );
                },
              ),
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
              AppStrings.ordersEmptyMessage.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: ColorManager.greyTextColor, height: 1.5),
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
            padding: EdgeInsets.only(bottom: 12.h),
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
