enum MessageType {
  text,
  image,
  // Add other types as needed
}

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.isRead = false,
  });

  // Dummy data for testing
  static List<Message> getMockMessages(
    String currentUserId,
    String otherUserId,
  ) {
    return [
      Message(
        id: 'm1',
        senderId: otherUserId,
        receiverId: currentUserId,
        content: 'Hi, is your service available today?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Message(
        id: 'm2',
        senderId: currentUserId,
        receiverId: otherUserId,
        content: 'Yes, what time works for you?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Message(
        id: 'm3',
        senderId: otherUserId,
        receiverId: currentUserId,
        content: 'How about 3 PM?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        id: 'm4',
        senderId: currentUserId,
        receiverId: otherUserId,
        content: 'Sounds good! See you then.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isRead: true,
      ),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
      'isRead': isRead,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['type'] ?? 'text'),
        orElse: () => MessageType.text,
      ),
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}
