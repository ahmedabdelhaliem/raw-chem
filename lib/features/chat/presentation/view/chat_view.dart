import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/resources/strings_manager.dart';
import 'package:raw_chem/common/widgets/default_error_widget.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/chat_input_field.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/chat_shimmer.dart';
import 'package:raw_chem/features/chat/presentation/view/widgets/message_bubble.dart';

class ChatView extends StatefulWidget {
  final int chatId;
  final String supplierName;

  const ChatView({super.key, required this.chatId, required this.supplierName});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.white.withValues(alpha: 0.8),
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        leading: const BackButton(color: ColorManager.black),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
              child: Icon(Icons.person_rounded, color: ColorManager.primary, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.supplierName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Pattern (Subtle Local Alternative or Fallback)
          Positioned.fill(
            child: Container(
              color: ColorManager.bg,
              child: Opacity(
                opacity: 0.02,
                child: Icon(Icons.grid_4x4, size: 400.sp, color: ColorManager.primary),
              ),
            ),
          ),

          BlocConsumer<ChatCubit, BaseState<MessageModel>>(
            listener: (context, state) {
              // Only auto-scroll if the scroll controller is near the bottom (index 0 in reverse)
              // or if we just initialized the chat
              if (_scrollController.hasClients && _scrollController.offset < 100) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
              }
            },
            builder: (context, state) {
              if (state.status == Status.loading && state.items.isEmpty) {
                return const ChatShimmer();
              }
              if (state.status == Status.error && state.items.isEmpty) {
                return DefaultErrorWidget(
                  errorMessage: state.failure?.message ?? AppStrings.unknownError.tr(),
                  buttonTitle: AppStrings.retry.tr(),
                  onPressed: () => context.read<ChatCubit>().initChat(widget.chatId),
                );
              }

              final messages = state.items;

              if (messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30.r),
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.primary.withValues(alpha: 0.03),
                              blurRadius: 20,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.forum_rounded,
                          size: 50.sp,
                          color: ColorManager.primary.withValues(alpha: 0.4),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppStrings.noMessagesYet.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primary.withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Start a conversation now',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: ColorManager.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return PaginatedListWrapper(
                scrollController: _scrollController,
                paginationHandler: context.read<ChatCubit>().paginationHandler,
                fetchFunction: (page, limit, [params]) =>
                    context.read<ChatCubit>().getChatMessages(chatId: widget.chatId, page: page),
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.fromLTRB(16.w, 100.h, 16.w, 110.h),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      message: message, 
                      isMe: message.senderType == 'user',
                    ).animate(key: ValueKey(message.id))
                     .fadeIn(duration: 300.ms)
                     .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
                  },
                ),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ChatInputField(
              onSend: (text, imagePath) {
                context.read<ChatCubit>().sendMessage(widget.chatId, text, imagePath: imagePath);
                // Force scroll to bottom when user sends a message
                _scrollToBottom();
              },
            ),
          ),
        ],
      ),
    );
  }
}
