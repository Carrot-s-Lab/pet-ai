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

  Future<bool> _confirmDelete(ChatSession session) async {
    if (!mounted) return false;
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: AppColors.appWhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Delete conversation?', style: AppFonts.h3),
            content: Text('All messages in "${session.title}" will be lost.', style: AppFonts.bodyM.apply(color: AppColors.stone)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel', style: AppFonts.ctaSecondary.apply(color: AppColors.stone)),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Delete', style: AppFonts.ctaSecondary.apply(color: AppColors.urgent)),
              ),
            ],
          ),
    );
    return confirmed ?? false;
  }

  List<dynamic> _buildItems(List<ChatSession> sessions) {
    final now = DateTime.now();
    final today =
        sessions.where((s) {
          final d = s.lastMessageAt;
          return d.year == now.year && d.month == now.month && d.day == now.day;
        }).toList();
    final yesterday =
        sessions.where((s) {
          final d = s.lastMessageAt;
          final y = now.subtract(const Duration(days: 1));
          return d.year == y.year && d.month == y.month && d.day == y.day;
        }).toList();
    final earlier =
        sessions.where((s) {
          final y = now.subtract(const Duration(days: 1));
          return s.lastMessageAt.isBefore(DateTime(y.year, y.month, y.day));
        }).toList();

    return [
      if (today.isNotEmpty) ...['Today', ...today],
      if (yesterday.isNotEmpty) ...['Yesterday', ...yesterday],
      if (earlier.isNotEmpty) ...['Earlier', ...earlier],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: AppColors.appWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.mist,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('AI Consultant', style: AppFonts.h2.apply(color: AppColors.ink)),
            Text('Pet health consultations', style: AppFonts.captionM.apply(color: AppColors.stone)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Consumer<SessionListController>(
            builder: (_, controller, _) {
              if (controller.loading && controller.sessions.isEmpty) {
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.caramel)));
              }
              if (controller.sessions.isEmpty) {
                return SessionEmptyState(onCreate: _createAndOpenSession);
              }

              final items = _buildItems(controller.sessions);

              return RefreshIndicator(
                color: AppColors.caramel,
                onRefresh: controller.load,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 4, bottom: 120),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    if (item is String) {
                      return _SectionHeader(label: item);
                    }
                    final session = item as ChatSession;
                    return Dismissible(
                      key: Key(session.id),
                      direction: DismissDirection.endToStart,
                      background: const _DeleteBackground(),
                      confirmDismiss: (_) => _confirmDelete(session),
                      onDismissed: (_) {
                        context.read<SessionListController>().deleteSession(session.id);
                      },
                      child: SessionTile(session: session, onTap: () => _openSession(session)),
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            right: 0,
            bottom: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: _createAndOpenSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.caramel,
                  foregroundColor: AppColors.appWhite,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                child: Text('New Chat', style: AppFonts.ctaSecondary.apply(color: AppColors.appWhite)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 6), child: Text(label, style: AppFonts.captionL.apply(color: AppColors.stone)));
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(color: AppColors.urgent, borderRadius: BorderRadius.circular(14)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 22),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.appWhite, size: 22),
      ),
    );
  }
}
