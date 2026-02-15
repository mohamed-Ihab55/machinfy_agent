import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';

class OpenAIService {
  /// لو هتستعمليه من dart-define مؤقتًا:
  /// flutter run --dart-define=OPENAI_API_KEY=sk-xxxx
  static const String _envKey = String.fromEnvironment('OPENAI_API_KEY');

  final String apiKey;

  // Endpoint الصحيح
  final String baseUrl = 'https://api.openai.com/v1/chat/completions';

  // نموذج أنسب حاليًا
  final String model = 'gpt-4o-mini';

  OpenAIService({String? apiKey}) : apiKey = (apiKey ?? _envKey).trim();

  Future<String> sendMessage({
    required String message,
    required List<ChatMessage> conversationHistory,
  }) async {
    final trimmedMsg = message.trim();
    if (trimmedMsg.isEmpty) return '';

    // ✅ تحقق واضح من المفتاح قبل أي طلب
    if (apiKey.isEmpty ||
        apiKey.startsWith('YOUR_') ||
        apiKey.contains('HERE')) {
      throw Exception(
        'Missing/invalid OpenAI API key. '
        'Provide a real key or run with --dart-define=OPENAI_API_KEY=sk-...',
      );
    }

    // Convert conversation history to OpenAI format
    final messages = conversationHistory.map((msg) {
      return {
        'role': msg.role == MessageRole.user ? 'user' : 'assistant',
        'content': msg.content,
      };
    }).toList();

    // Add the current message
    messages.add({'role': 'user', 'content': trimmedMsg});

    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': messages,
        'temperature': 0.7,
        'max_tokens': 600,
      }),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final choices = data['choices'] as List<dynamic>;
      final content = choices.first['message']['content'] as String;
      return content.trim();
    } else {
      // ✅ خلي الخطأ واضح (status + body) علشان التشخيص
      String serverMsg = 'Failed to get response from OpenAI';
      try {
        final errorData = jsonDecode(res.body) as Map<String, dynamic>;
        serverMsg = errorData['error']?['message']?.toString() ?? serverMsg;
      } catch (_) {
        // ignore: no-op
      }
      throw Exception('OpenAI ${res.statusCode}: $serverMsg');
    }
  }
}
