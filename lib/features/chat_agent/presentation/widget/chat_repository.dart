import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';

class ChatRepository {
  final _messagesRef = FirebaseFirestore.instance.collection('messages');

  User? get _currentUser => FirebaseAuth.instance.currentUser;

  /// Get messages for a specific user (or current user if userId is null)
  Stream<List<ChatMessage>> getMessages({String? userId}) {
    final uid = userId ?? _currentUser?.uid;

    if (uid == null) {
      return const Stream.empty();
    }

    return _messagesRef
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatMessage.fromJson({
              ...data,
              'timestamp': data['timestamp'] ?? Timestamp.now(),
            });
          }).toList();
        });
  }

  /// Save message for a specific user (or current user if userId is null)
  Future<void> saveMessage({
    required String content,
    required MessageRole role,
    String? userId,
  }) async {
    final uid = userId ?? _currentUser?.uid;
    final email = _currentUser?.email;

    if (uid == null) return;

    await _messagesRef.add({
      'content': content.trim(),
      'role': role.name,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': uid,
      'email': email,
    });
  }
}