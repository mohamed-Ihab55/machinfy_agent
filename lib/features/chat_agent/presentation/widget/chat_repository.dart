import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';

class ChatRepository {
  final _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  User? get _user => FirebaseAuth.instance.currentUser;

  Stream<List<ChatMessage>> getMessages() {
    return _messagesRef
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        final safe = {
          ...data,
          'timestamp': data['timestamp'] ?? Timestamp.now(),
        };

        return ChatMessage.fromJson(safe);
      }).toList();
    });
  }

  Future<void> saveMessage({
    required String content,
    required MessageRole role,
  }) async {
    await _messagesRef.add({
      'content': content.trim(),
      'role': role.name,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': _user?.uid,
      'email': _user?.email,
    });
  }
}