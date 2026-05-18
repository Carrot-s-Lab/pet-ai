import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:provider/provider.dart';

import '../controller/chat_controller.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/chat_message_list.dart';
import 'widgets/chat_pending_images_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().load().then((_) => _scrollToBottom());
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _handleSend() async {
    final text = _textController.text;
    _textController.clear();
    await context.read<ChatController>().sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Consumer<ChatController>(
          builder: (_, controller, _) => Text(
            controller.session?.title ?? 'Conversation',
            style: AppFonts.f16s,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<ChatController>(
          builder: (_, controller, _) {
            if (controller.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: ChatMessageList(
                    messages: controller.messages,
                    sending: controller.sending,
                    scrollController: _scrollController,
                  ),
                ),
                if (controller.errorMessage != null)
                  _ErrorBanner(message: controller.errorMessage!),
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
            );
          },
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
      padding: const EdgeInsets.all(12),
      color: AppColors.redLighter,
      child: Text(
        message,
        style: AppFonts.f12r.apply(color: AppColors.red),
      ),
    );
  }
}
