class ChatSession {
  final String id;
  final String title;
  final String lastMessagePreview;
  final DateTime lastMessageAt;
  final int messageCount;
  final DateTime createdAt;

  const ChatSession({
    required this.id,
    required this.title,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    required this.messageCount,
    required this.createdAt,
  });

  ChatSession copyWith({
    String? title,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    int? messageCount,
  }) {
    return ChatSession(
      id: id,
      title: title ?? this.title,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      messageCount: messageCount ?? this.messageCount,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lastMessagePreview': lastMessagePreview,
      'lastMessageAt': lastMessageAt.toIso8601String(),
      'messageCount': messageCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      lastMessagePreview: json['lastMessagePreview'] as String? ?? '',
      lastMessageAt:
          DateTime.tryParse(json['lastMessageAt'] as String? ?? '') ??
              DateTime.now(),
      messageCount: json['messageCount'] as int? ?? 0,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
