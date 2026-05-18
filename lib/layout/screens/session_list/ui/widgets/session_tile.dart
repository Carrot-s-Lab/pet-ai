import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/chat_session.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
    required this.onTap,
    required this.onDelete,
  });

  final ChatSession session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      onTap: onTap,
      title: Text(
        session.title,
        style: AppFonts.f16s,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          session.lastMessagePreview.isEmpty
              ? 'No messages yet'
              : session.lastMessagePreview,
          style: AppFonts.f14r.apply(color: AppColors.textTertiary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: AppColors.textTertiary),
        onPressed: onDelete,
      ),
    );
  }
}
