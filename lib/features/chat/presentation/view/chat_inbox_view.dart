import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/app_router.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/features/chat/domain/model/chat_model.dart';
import 'package:raw_chem/features/chat/presentation/cubit/chat_inbox_cubit.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/chat_inbox_item.dart';
import 'package:raw_chem/core/state/base_state.dart';

class ChatInboxView extends StatefulWidget {
  const ChatInboxView({super.key});

  @override
  State<ChatInboxView> createState() => _ChatInboxViewState();
}

class _ChatInboxViewState extends State<ChatInboxView> {
  @override
  void initState() {
    super.initState();
    context.read<ChatInboxCubit>().getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: AppStrings.chatInbox.tr(),
        backgroundColor: ColorManager.white,
        titleColor: ColorManager.black,
        withLeading: true,
      ),
      body: BlocBuilder<ChatInboxCubit, BaseState<ChatModel>>(
        builder: (context, state) {
          if (state.status == Status.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == Status.error && state.items.isEmpty) {
            return Center(child: Text(state.failure?.message ?? 'Error'));
          }
          
          final chats = state.items;

          if (chats.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64.sp,
                    color: ColorManager.lightGrey,
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
            padding: EdgeInsets.all(20.w),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ChatInboxItem(
                chat: chat,
                onTap: () {
                  context.push(
                    AppRouters.chatView,
                    extra: {
                      'chatId': chat.id,
                      'supplierName': chat.supplier.name ?? 'Chat',
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
