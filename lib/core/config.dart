import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = "https://api.openai.com/v1";

  static String get apiKey {
    final key = dotenv.env['OPENAI_API_KEY'] ?? '';
    return key.trim();
  }

  static Map<String, String> get headers => {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey",
  };

  static String get chatCompletions => "$baseUrl/chat/completions";
}
