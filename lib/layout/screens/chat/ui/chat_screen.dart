import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:provider/provider.dart';

import '../controller/chat_controller.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/chat_limit_banner.dart';
import 'widgets/chat_message_list.dart';
import 'widgets/chat_pending_images_bar.dart';
import 'widgets/chat_quick_tasks_row.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatController? _chatController;
  double? _savedMaxScrollExtent;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatController = context.read<ChatController>();
      _chatController!.addListener(_onControllerChanged);
      _chatController!.load().then((_) => _scrollToBottom(animate: false));
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _chatController?.removeListener(_onControllerChanged);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels <= 0) {
      _savedMaxScrollExtent = _scrollController.position.maxScrollExtent;
      _chatController?.loadMore().then((_) => _correctScrollAfterPrepend());
    }
  }

  void _correctScrollAfterPrepend() {
    final saved = _savedMaxScrollExtent;
    if (saved == null) return;
    _savedMaxScrollExtent = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      final delta = _scrollController.position.maxScrollExtent - saved;
      if (delta > 0) {
        _scrollController.jumpTo(_scrollController.position.pixels + delta);
      }
    });
  }

  void _onControllerChanged() {
    if (_chatController?.sending == true) _scrollToBottom();
  }

  void _scrollToBottom({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      final target = _scrollController.position.maxScrollExtent;
      if (animate) {
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(target);
      }
    });
  }

  void _handleSend() {
    final text = _textController.text;
    _textController.clear();
    context.read<ChatController>().sendMessage(text);
  }

  void _handleUpgrade() {
    // TODO: navigate to paywall screen once it exists
  }

  void _handleQuickTask(String task) {
    _textController.text = task;
    _textController.selection = TextSelection.fromPosition(
      TextPosition(offset: task.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.lavenderLight.withValues(alpha: 0.95),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.lavender,
        scrolledUnderElevation: 0.5,
        title: Consumer<ChatController>(
          builder: (_, controller, _) => Text(
            controller.session?.title ?? 'Conversation',
            style: AppFonts.h3.apply(color: AppColors.ink),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lavenderWash, AppColors.lavenderLight],
          ),
        ),
        child: SafeArea(
          child: Consumer<ChatController>(
            builder: (_, controller, _) {
              if (controller.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.lavenderDeep),
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ChatMessageList(
                      messages: controller.messages,
                      sending: controller.showTypingIndicator,
                      scrollController: _scrollController,
                      loadingMore: controller.loadingMore,
                    ),
                  ),
                  if (controller.errorMessage != null)
                    _ErrorBanner(message: controller.errorMessage!),
                  if (controller.isLimitReached)
                    ChatLimitBanner(onUpgrade: _handleUpgrade)
                  else ...[
                    const SizedBox(height: 8),
                    ChatQuickTasksRow(onSelect: _handleQuickTask),
                    const SizedBox(height: 6),
                    if (controller.pendingImagePaths.isNotEmpty)
                      ChatPendingImagesBar(
                        paths: controller.pendingImagePaths,
                        onRemove: controller.removePendingImage,
                      ),
                    ChatInputBar(
                      controller: _textController,
                      sending: controller.sending,
                      onPickImages: controller.pickImages,
                      onSend: _handleSend,
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFFF9E8E8),
      child: Text(
        message,
        style: AppFonts.captionL.apply(color: AppColors.urgent),
      ),
    );
  }
}
