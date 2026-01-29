import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';

class OpenAIService {
  final String apiKey;
  final String baseUrl = 'https://api.openai.com/v1/chat/completions';
  final String model = 'gpt-3.5-turbo';

  OpenAIService({required this.apiKey});

  Future<String> sendMessage({
    required String message,
    required List<ChatMessage> conversationHistory,
  }) async {
    try {
      // Convert conversation history to OpenAI format
      final messages = conversationHistory.map((msg) {
        return {
          'role': msg.role == MessageRole.user ? 'user' : 'assistant',
          'content': msg.content,
        };
      }).toList();

      // Add the current message
      messages.add({
        'role': 'user',
        'content': message,
      });

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] as String;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['error']?['message'] ?? 'Failed to get response from OpenAI',
        );
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
