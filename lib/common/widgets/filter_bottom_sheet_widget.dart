import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final int initialIndex;

  const FilterBottomSheetWidget({super.key, this.initialIndex = 0});

  static Future<int?> show(BuildContext context, {int initialIndex = 0}) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FilterBottomSheetWidget(initialIndex: initialIndex),
      ),
    );
  }

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late int _selectedIndex;

  final List<String> _filters = [
    'الأكثر مبيعاً',
    'العروض',
    'السعر: من الأقل للأعلى',
    'السعر: من الأعلى للأقل',
    'الأحدث',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'فلتر',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 48.w), // Empty space to center the title
            ],
          ),
          SizedBox(height: 20.h),

          // Filters Container
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الفئات',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15.h),
                ...List.generate(_filters.length, (index) {
                  return _buildFilterItem(index, _filters[index]);
                }),
              ],
            ),
          ),
          SizedBox(height: 30.h),

          // Apply Button
          DefaultButtonWidget(
            text: 'تطبيق الفلتر',
            onPressed: () => Navigator.pop(context, _selectedIndex),
            color: const Color(0xFF006B3E),
            textColor: Colors.white,
            radius: 12.r,
            height: 50.h,
            isIcon: true,
            textFirst: true, // Text first, icon after (so icon is on the left in RTL)
            iconBuilder: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: const Color(0xFF006B3E), size: 16.sp),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
        ],
      ),
    );
  }

  Widget _buildFilterItem(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: isSelected ? const Color(0xFF006B3E) : Colors.grey.shade400,
                  width: 1.5,
                ),
                color: isSelected ? const Color(0xFF006B3E) : Colors.transparent,
              ),
              child: isSelected ? Icon(Icons.check, size: 12.sp, color: Colors.white) : null,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isSelected ? Colors.black : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
