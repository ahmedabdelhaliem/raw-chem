import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
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

  @override
  void initState() {
    super.initState();
    _myId = instance<AppPreferences>().getUserId();
    context.read<ChatCubit>().initChat(widget.chatId);
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
            child: BlocBuilder<ChatCubit, BaseState<MessageModel>>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == Status.error) {
                  return Center(child: Text(state.failure?.message ?? 'Error'));
                }

                final messages = state.items;

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
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
