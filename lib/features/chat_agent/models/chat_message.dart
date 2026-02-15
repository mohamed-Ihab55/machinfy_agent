import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum MessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String content;
  final MessageRole role;
  final DateTime timestamp;

  const ChatMessage({
    required this.content,
    required this.role,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'content': content,
    'role': role.name, // 'user' | 'assistant'
    'timestamp': Timestamp.fromDate(timestamp),
  };

  static ChatMessage fromMap(Map<String, dynamic> map) {
    final roleStr = (map['role'] ?? 'user') as String;
    final ts = map['timestamp'];

    DateTime time;
    if (ts is Timestamp) {
      time = ts.toDate();
    } else if (ts is DateTime) {
      time = ts;
    } else {
      time = DateTime.now();
    }

    return ChatMessage(
      content: (map['content'] ?? '') as String,
      role: roleStr == 'assistant' ? MessageRole.assistant : MessageRole.user,
      timestamp: time,
    );
  }

  @override
  List<Object?> get props => [content, role, timestamp];
}
