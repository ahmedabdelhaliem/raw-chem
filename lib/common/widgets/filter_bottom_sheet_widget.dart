import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';

class FilterItem {
  final int id;
  final String title;

  FilterItem({required this.id, required this.title});
}

class FilterBottomSheetWidget extends StatefulWidget {
  final List<FilterItem> items;
  final List<int> initialSelectedIds;
  final String title;
  final String sectionTitle;
  
  const FilterBottomSheetWidget({
    super.key, 
    required this.items, 
    this.initialSelectedIds = const [],
    this.title = 'فلتر',
    this.sectionTitle = 'الفئات',
  });

  static Future<List<int>?> show({
    required BuildContext context,
    required List<FilterItem> items,
    List<int> initialSelectedIds = const [],
    String title = 'فلتر',
    String sectionTitle = 'الفئات',
  }) {
    return showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FilterBottomSheetWidget(
          items: items, 
          initialSelectedIds: initialSelectedIds,
          title: title,
          sectionTitle: sectionTitle,
        ),
      ),
    );
  }

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late List<int> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.initialSelectedIds);
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
                widget.title,
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
          if (widget.items.isNotEmpty)
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sectionTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ...widget.items.map((item) => _buildFilterItem(item)),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(20.w),
              alignment: Alignment.center,
              child: Text(
                'لا توجد فلاتر متاحة',
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
            ),
          SizedBox(height: 30.h),

          // Apply Button
          DefaultButtonWidget(
            text: 'تطبيق الفلتر',
            onPressed: () => Navigator.pop(context, _selectedIds),
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

  Widget _buildFilterItem(FilterItem item) {
    bool isSelected = _selectedIds.contains(item.id);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIds.remove(item.id);
          } else {
            _selectedIds.add(item.id);
          }
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
                item.title,
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

