import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machinfy_agent/features/chat_agent/models/chat_message.dart';
import 'package:machinfy_agent/features/chat_agent/presentation/widget/chat_repository.dart';
import 'package:machinfy_agent/features/chat_agent/services/openai_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final OpenAIService openAIService;
  final String userId; // New field for user ID

  ChatCubit({required this.openAIService, required this.userId})
    : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final userMessage = ChatMessage(
      content: message.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    final currentMessages = state.messages;

    emit(ChatLoading([...currentMessages, userMessage]));

    try {
      /// save user message under userId
      await ChatRepository().saveMessage(
        content: userMessage.content,
        role: MessageRole.user,
        userId: userId,
      );

      final response = await openAIService.sendMessage(
        message: message.trim(),
        conversationHistory: currentMessages,
      );

      final assistantMessage = ChatMessage(
        content: response,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      /// save assistant message under userId
      await ChatRepository().saveMessage(
        content: assistantMessage.content,
        role: MessageRole.assistant,
        userId: userId,
      );

      emit(ChatSuccess([...currentMessages, userMessage, assistantMessage]));
    } catch (e) {
      emit(ChatError([...currentMessages, userMessage], e.toString()));
    }
  }
}
