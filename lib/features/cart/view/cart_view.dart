// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:raw_chem/common/resources/color_manager.dart';
// import 'package:raw_chem/common/widgets/default_app_bar.dart';
// import 'package:raw_chem/common/widgets/default_button_widget.dart';
// import 'package:raw_chem/features/cart/view/widgets/cart_item_widget.dart';
// import 'package:raw_chem/features/cart/view/widgets/checkout_bottom_sheet.dart';

// class CartView extends StatefulWidget {
//   const CartView({super.key});

//   @override
//   State<CartView> createState() => _CartViewState();
// }

// class _CartViewState extends State<CartView> {
//   final List<Map<String, dynamic>> _mockItems = [
//     {
//       'imageUrl': '',
//       'company': 'شركة الحلول الكيميائية',
//       'title': 'حمض ألكيل بنزين السلفونيك الخطي (LABSA)',
//       'category': 'مادة فعالة سطحياً',
//       'price': 1100,
//       'quantity': 1,
//     },
//     {
//       'imageUrl': '',
//       'company': 'شركة الحلول الكيميائية',
//       'title': 'حمض ألكيل بنزين السلفونيك الخطي (LABSA)',
//       'category': 'مادة فعالة سطحياً',
//       'price': 1180,
//       'quantity': 1,
//     },
//   ];

//   int get _totalPrice {
//     return _mockItems.fold(0, (sum, item) => sum + ((item['price'] as int) * (item['quantity'] as int)));
//   }

//   void _incrementQuantity(int index) {
//     setState(() {
//       _mockItems[index]['quantity'] = (_mockItems[index]['quantity'] as int) + 1;
//     });
//   }

//   void _decrementQuantity(int index) {
//     setState(() {
//       if (_mockItems[index]['quantity'] > 1) {
//         _mockItems[index]['quantity'] = (_mockItems[index]['quantity'] as int) - 1;
//       }
//     });
//   }

//   void _removeItem(int index) {
//     setState(() {
//       _mockItems.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.bg,
//       appBar: DefaultAppBar(
//         text: 'السلة',
//         backgroundColor: ColorManager.bg,
//         titleColor: ColorManager.black,
//         withLeading: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _mockItems.isEmpty
//                 ? Center(
//                     child: Text(
//                       'السلة فارغة',
//                       style: TextStyle(fontSize: 16.sp, color: ColorManager.greyTextColor),
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
//                     itemCount: _mockItems.length,
//                     itemBuilder: (context, index) {
//                       final item = _mockItems[index];
//                       return CartItemWidget(
//                         imageUrl: item['imageUrl'],
//                         title: item['title'],
//                         company: item['company'],
//                         category: item['category'],
//                         price: item['price'].toString(),
//                         quantity: item['quantity'],
//                         onAdd: () => _incrementQuantity(index),
//                         onRemove: () => _decrementQuantity(index),
//                         onDelete: () => _removeItem(index),
//                       );
//                     },
//                   ),
//           ),
          
//           // Checkout Bottom Container
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//             decoration: BoxDecoration(
//               color: ColorManager.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24.r),
//                 topRight: Radius.circular(24.r),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: ColorManager.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, -4),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: DefaultButtonWidget(
//                 text: 'انتقل إلى الدفع - EGP $_totalPrice',
//                 onPressed: _mockItems.isEmpty
//                     ? null
//                     : () {
//                         CheckoutBottomSheet.show(context, totalCost: _totalPrice);
//                       },
//                 color: const Color(0xFF006B3E),
//                 textColor: Colors.white,
//                 radius: 14.r,
//                 height: 55.h,
//                 fontSize: 14.sp,
//                 isIcon: true,
//                 textFirst: true, // Icon on left side for RTL
//                 iconBuilder: Container(
//                   padding: EdgeInsets.all(6.w),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 16.sp),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
