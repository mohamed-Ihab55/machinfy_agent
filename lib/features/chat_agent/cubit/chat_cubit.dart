import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';
import 'package:machinfy_agent/features/chat_agent/services/openai_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final OpenAIService openAIService;

  ChatCubit({required this.openAIService}) : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message to the list
    final userMessage = ChatMessage(
      content: message.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    final currentMessages = state.messages;
    emit(ChatLoading([...currentMessages, userMessage]));

    try {
      // Send message to OpenAI
      final response = await openAIService.sendMessage(
        message: message.trim(),
        conversationHistory: currentMessages,
      );

      // Add assistant response
      final assistantMessage = ChatMessage(
        content: response,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      emit(ChatSuccess([...currentMessages, userMessage, assistantMessage]));
    } catch (e) {
      emit(ChatError([...currentMessages, userMessage], e.toString()));
    }
  }

  void clearChat() {
    emit(ChatInitial());
  }
}
