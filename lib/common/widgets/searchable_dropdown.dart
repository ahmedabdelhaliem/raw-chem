import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String label;
  final IconData icon;
  final bool enabled;

  const SearchableDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    required this.label,
    required this.icon,
    this.enabled = true,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: GestureDetector(
        onTap: () => _showSearchDialog(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: Icon(widget.icon,
                color: widget.enabled ? ColorManager.primary : Colors.grey, size: 20.sp),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: ColorManager.primary)),
            filled: !widget.enabled,
            fillColor: widget.enabled ? Colors.transparent : Colors.grey.shade50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.items.any((item) => item.value == widget.value)
                    ? (widget.items.firstWhere((item) => item.value == widget.value).child as Text)
                        .data!
                    : widget.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: widget.value != null ? Colors.black : Colors.grey,
                  fontFamily: 'Cairo',
                ),
              ),
              Icon(Icons.keyboard_arrow_down,
                  color: widget.enabled ? Colors.grey[600] : Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _SearchDialog<T>(
          items: widget.items,
          initialValue: widget.value,
          label: widget.label,
          onSelected: (value) {
            widget.onChanged?.call(value);
          },
        );
      },
    );
  }
}

class _SearchDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? initialValue;
  final String label;
  final ValueChanged<T> onSelected;

  const _SearchDialog({
    required this.items,
    this.initialValue,
    required this.label,
    required this.onSelected,
  });

  @override
  State<_SearchDialog<T>> createState() => _SearchDialogState<T>();
}

class _SearchDialogState<T> extends State<_SearchDialog<T>> {
  late List<DropdownMenuItem<T>> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = widget.items.where((item) {
        final text = (item.child as Text).data!.toLowerCase();
        return text.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: AppStrings.search.tr(),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              onChanged: _filterItems,
            ),
            SizedBox(height: 10.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return ListTile(
                    title: item.child,
                    onTap: () {
                      widget.onSelected(item.value as T);
                      Navigator.pop(context);
                    },
                    selected: item.value == widget.initialValue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
