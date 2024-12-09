/// Model class for chat users
class ChatUser {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;
  final String? lastSeen;

  ChatUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isOnline = false,
    this.lastSeen,
  });
} 