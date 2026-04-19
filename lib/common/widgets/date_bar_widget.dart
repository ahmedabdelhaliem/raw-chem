import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final List<Map<String, String>> dates;
  final String selectedDate;
  final ValueChanged<String> onDateSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const DateBarWidget({
    super.key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(72.h);

  @override
  State<DateBarWidget> createState() => _DateBarWidgetState();
}

class _DateBarWidgetState extends State<DateBarWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void didUpdateWidget(covariant DateBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate || oldWidget.dates != widget.dates) {
      // Small delay to ensure maxScrollExtent is updated after list rebuild
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _scrollToSelected();
      });
    }
  }

  void _scrollToSelected() {
    if (!_scrollController.hasClients) return;

    final index = widget.dates.indexWhere((e) => e["fullDate"] == widget.selectedDate);
    if (index != -1) {
      const itemWidth = 60.0; // Fixed width for calculation
      const separatorWidth = 10.0;
      final screenWidth = MediaQuery.of(context).size.width;

      // Position = (width + gap) * index - (screen / 2) + (width / 2) + padding
      final position =
          (itemWidth.w + separatorWidth.w) * index - (screenWidth / 2) + (itemWidth.w / 2) + 12.w;

      _scrollController.animateTo(
        position.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: widget.dates.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = widget.dates[index];
          final isSelected = item["fullDate"] == widget.selectedDate;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => widget.onDateSelected(item["fullDate"]!),
            child: SizedBox(
              width: 60.w, // Fixed width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (widget.selectedColor ?? ColorManager.yellow)
                          : (widget.unselectedColor ?? Colors.white),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    (widget.selectedColor ?? ColorManager.yellow).withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        item["weekday"] ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? (widget.selectedTextColor ?? Colors.white)
                              : (widget.unselectedTextColor ?? Colors.grey[700]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item["day"] ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? (widget.selectedTextColor ?? Colors.white)
                          : (widget.unselectedTextColor ?? Colors.grey[800]),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      width: 4.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
