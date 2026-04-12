import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/chat_input_field.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/message_bubble.dart';

class ChatView extends StatefulWidget {
  final int chatId;
  final String supplierName;

  const ChatView({
    super.key,
    required this.chatId,
    required this.supplierName,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final String _myId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _myId = instance<AppPreferences>().getUserId();
    context.read<ChatCubit>().initChat(widget.chatId);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: widget.supplierName,
        backgroundColor: ColorManager.white,
        titleColor: ColorManager.black,
        withLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, BaseState<MessageModel>>(
              listener: (context, state) {
                if (state.status == Status.success || state.items.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                }
              },
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == Status.error) {
                  return Center(child: Text(state.failure?.message ?? 'Error'));
                }

                final messages = state.items;

                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64.sp,
                          color: ColorManager.lightGrey.withOpacity(0.5),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          AppStrings.noMessagesYet.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorManager.greyTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      message: message,
                      isMe: message.senderId == _myId,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(
            onSend: (text) {
              context.read<ChatCubit>().sendMessage(widget.chatId, text);
            },
          ),
        ],
      ),
    );
  }
}
