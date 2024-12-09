/// Model class for chat messages
class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    this.isRead = false,
  });
} 