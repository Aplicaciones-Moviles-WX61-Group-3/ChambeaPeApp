class ChatMessage {
  final String message;
  final String user;
  final String timestamp;

  ChatMessage({
    required this.message,
    required this.user,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'],
      user: json['user'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user,
    };
  }
}
