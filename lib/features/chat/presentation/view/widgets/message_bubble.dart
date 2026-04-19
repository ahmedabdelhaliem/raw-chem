import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/features/chat/domain/model/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF006B3E) : ColorManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              _formatTime(message.createdAt),
              style: TextStyle(
                fontSize: 10.sp,
                color: ColorManager.greyTextColor.withValues(alpha: 0.6),
              ),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  String _formatTime(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return intl.DateFormat('hh:mm a').format(dateTime);
    } catch (_) {
      return '';
    }
  }
}
