enum ChatMessageRole { user, assistant }

enum ChatMessageStatus { pending, sent, failed }

class ChatMessage {
  final String id;
  final String sessionId;
  final ChatMessageRole role;
  final String content;
  final List<String> imagePaths;
  final ChatMessageStatus status;
  final String? errorMessage;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.imagePaths = const [],
    this.status = ChatMessageStatus.sent,
    this.errorMessage,
  });

  ChatMessage copyWith({
    String? content,
    List<String>? imagePaths,
    ChatMessageStatus? status,
    String? errorMessage,
  }) {
    return ChatMessage(
      id: id,
      sessionId: sessionId,
      role: role,
      content: content ?? this.content,
      imagePaths: imagePaths ?? this.imagePaths,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionId': sessionId,
      'role': role.name,
      'content': content,
      'imagePaths': imagePaths,
      'status': status.name,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      role: ChatMessageRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => ChatMessageRole.user,
      ),
      content: json['content'] as String? ?? '',
      imagePaths:
          (json['imagePaths'] as List?)?.map((e) => e.toString()).toList() ??
              const [],
      status: ChatMessageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ChatMessageStatus.sent,
      ),
      errorMessage: json['errorMessage'] as String?,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
