import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:pet_ai_project/router/route_paths.dart';
import 'package:pet_ai_project/router/router.dart';
import 'package:provider/provider.dart';

import '../controller/session_list_controller.dart';
import 'widgets/session_empty_state.dart';
import 'widgets/session_tile.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionListController>().load();
    });
  }

  Future<void> _createAndOpenSession() async {
    final session = await context.read<SessionListController>().createSession();
    if (!mounted) return;
    await appRouter.push(
      context,
      RoutePaths.chat,
      params: {'sessionId': session.id},
    );
    if (!mounted) return;
    context.read<SessionListController>().load();
  }

  Future<void> _openSession(ChatSession session) async {
    await appRouter.push(
      context,
      RoutePaths.chat,
      params: {'sessionId': session.id},
    );
    if (!mounted) return;
    context.read<SessionListController>().load();
  }

  Future<void> _confirmDelete(ChatSession session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete conversation?'),
        content:
            Text('All messages in "${session.title}" will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await context.read<SessionListController>().deleteSession(session.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Consultant', style: AppFonts.f18s),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Consumer<SessionListController>(
        builder: (_, controller, _) {
          if (controller.loading && controller.sessions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.sessions.isEmpty) {
            return SessionEmptyState(onCreate: _createAndOpenSession);
          }
          return RefreshIndicator(
            onRefresh: controller.load,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.sessions.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: AppColors.borderPrimary),
              itemBuilder: (_, index) {
                final session = controller.sessions[index];
                return SessionTile(
                  session: session,
                  onTap: () => _openSession(session),
                  onDelete: () => _confirmDelete(session),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createAndOpenSession,
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'New Chat',
          style: AppFonts.f14s.apply(color: Colors.white),
        ),
      ),
    );
  }
}
