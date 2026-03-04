import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final OpenAI _openAI;

  final ChatUser _user = ChatUser(id: '1', firstName: 'You');
  final ChatUser _bot = ChatUser(id: '2', firstName: 'AI');

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    const apiKey = String.fromEnvironment('OPENAI_API_KEY');

    _openAI = OpenAI.instance.build(
      token: apiKey,
      enableLog: !kReleaseMode,
    );
  }

  Future<void> _sendMessage(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });

    final request = ChatCompleteText(
      messages: [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": message.text
        }
      ],
      maxToken: 200,
      model: GptTurboChatModel(),
    );

    final response = await _openAI.onChatCompletion(request: request);

    final reply = response?.choices.last.message?.content ?? "No response";

    final aiMessage = ChatMessage(
      user: _bot,
      createdAt: DateTime.now(),
      text: reply,
    );

    setState(() {
      _messages.insert(0, aiMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple AI Chat")),
      body: DashChat(
        currentUser: _user,
        onSend: _sendMessage,
        messages: _messages,
      ),
    );
  }
}