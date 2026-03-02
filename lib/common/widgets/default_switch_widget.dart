import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultSwitchWidget extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const DefaultSwitchWidget({
    super.key,
    required this.text,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4EA085),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
