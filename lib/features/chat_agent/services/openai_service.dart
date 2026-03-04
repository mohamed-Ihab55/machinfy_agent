import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';
import 'package:machinfy_agent/features/chat_agent/services/api_exception.dart';

import '../../../core/config.dart';

class OpenAIService {
  final String model = 'gpt-4o-mini';

  static const Duration _timeout = Duration(seconds: 30);

  Future<String> sendMessage({
    required String message,
    required List<ChatMessage> conversationHistory,
  }) async {
    if (ApiConfig.apiKey.isEmpty) {
      throw OpenAIException(
        message: 'API key not found. Check your .env file.',
        type: OpenAIErrorType.invalidApiKey,
      );
    }

    final messages = _buildMessages(conversationHistory, message);

    final response = await http
        .post(
          Uri.parse(ApiConfig.chatCompletions),
          headers: ApiConfig.headers,
          body: jsonEncode({
            'model': model,
            'messages': messages,
            'temperature': 0.7,
            'max_tokens': 800,
          }),
        )
        .timeout(_timeout);

    return _handleResponse(response);
  }

  String _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].toString().trim();
    } else {
      throw OpenAIException(
        message: 'Error ${response.statusCode}: ${response.body}',
        type: OpenAIErrorType.unknown,
        statusCode: response.statusCode,
      );
    }
  }

  List<Map<String, String>> _buildMessages(
    List<ChatMessage> history,
    String currentMessage,
  ) {
    final messages = <Map<String, String>>[];

    messages.add({
      'role': 'system',
      'content': 'You are a helpful AI course advisor for Machinfy Academy.',
    });

    for (final msg in history) {
      if (msg.isError) continue;

      messages.add({
        'role': msg.role == MessageRole.user ? 'user' : 'assistant',
        'content': msg.content,
      });
    }

    messages.add({'role': 'user', 'content': currentMessage});

    return messages;
  }
}
