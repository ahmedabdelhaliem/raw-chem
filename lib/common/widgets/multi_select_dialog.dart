import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<int> selectedIds;
  final bool isSingle;
  final String title;
  final String Function(T) nameSelector;
  final int Function(T) idSelector;

  const MultiSelectDialog({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.title,
    required this.nameSelector,
    required this.idSelector,
    this.isSingle = false,
  });

  @override
  State<MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  late List<int> _tempSelectedIds;

  @override
  void initState() {
    super.initState();
    _tempSelectedIds = List.from(widget.selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            final id = widget.idSelector(item);
            final name = widget.nameSelector(item);
            final isSelected = _tempSelectedIds.contains(id);

            return CheckboxListTile(
              value: isSelected,
              title: Text(name),
              activeColor: ColorManager.primary,
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    if (widget.isSingle) {
                      _tempSelectedIds = [id];
                    } else {
                      _tempSelectedIds.add(id);
                    }
                  } else {
                    _tempSelectedIds.remove(id);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel.tr(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _tempSelectedIds);
          },
          child: Text(
            AppStrings.confirm.tr(),
            style: const TextStyle(color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}
