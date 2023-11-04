import 'dart:async';

import 'package:dart_openai/dart_openai.dart';

// TODO convert to freezed model
class ChatMessage {
  ChatMessage(
      {required this.createdAt, required this.role, required this.message});

  final ChatMessageRole role;
  final String message;
  final DateTime createdAt;
}

enum ChatMessageRole { user, assistant }

class ChatResponse {
  ChatResponse({required this.message});

  final String message;
}

abstract class ChatApi {
  Future<ChatResponse> nextMessage({
    required String message,
    required List<ChatMessage> history,
  });
}

class OpenAIChatApi extends ChatApi {
  OpenAIChatApi() {
    _init();
  }

  final _initCompleter = Completer();

  Future<void> _init() async {
    // init code here
    // OpenAI.apiKey = '';
    OpenAI.apiKey = const String.fromEnvironment("OPENAI_API_KEY");
    // print('API KEY: ${OpenAI.apiKey}'')
    print('DEV_BUILD:' + bool.fromEnvironment('DEV_BUILD').toString());
    print('OpenAI key:' + String.fromEnvironment('OPENAI_API_KEY').toString());
    _initCompleter.complete();
  }

  @override
  Future<ChatResponse> nextMessage({
    required String message,
    required List<ChatMessage> history,
  }) async {
    await _initCompleter.future;
    final response = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    return ChatResponse(message: response.choices.first.message.content);
  }
}
