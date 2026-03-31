import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/order_card_widget.dart';

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
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorManager.primary,
          unselectedLabelColor: ColorManager.greyTextColor,
          indicatorColor: ColorManager.primary,
          indicatorWeight: 3.h,
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: AppStrings.currentOrders.tr()),
            Tab(text: AppStrings.previousOrders.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(isCurrent: true),
          _buildOrdersList(isCurrent: false),
        ],
      ),
    );
  }

  Widget _buildOrdersList({required bool isCurrent}) {
    // Mock Data based on the UI screenshot
    final List<Map<String, String>> orders = isCurrent
        ? [
            {
              'orderNumber': '016440693 - EGY',
              'date': '24/10/2026',
              'amount': '1500.00 جنية',
              'status': 'قيد المراجعة',
            },
            {
              'orderNumber': '012948635 - EGY',
              'date': '12/10/2026',
              'amount': '250.00 جنية',
              'status': 'جاري التوصيل',
            },
          ]
        : [
            {
              'orderNumber': '016440693 - EGY',
              'date': '01/09/2026',
              'amount': '1900.00 جنية',
              'status': 'مكتمل',
            },
            {
              'orderNumber': '012948635 - EGY',
              'date': '15/08/2026',
              'amount': '1000.00 جنية',
              'status': 'ملغي',
            },
          ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCardWidget(
          orderNumber: order['orderNumber']!,
          date: order['date']!,
          amount: order['amount']!,
          status: order['status']!,
          onTapDetails: () {
            context.push(AppRouters.orderDetailsView);
          },
        );
      },
    );
  }
}
