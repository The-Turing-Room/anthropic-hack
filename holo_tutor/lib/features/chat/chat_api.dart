import 'dart:async';
import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:http/http.dart' as http;
import 'package:holo_tutor/features/chat/models.dart' as m;

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
    int? pdfPage,
  });
}

const CHAT_ENDPOINT = 'http://localhost:5000/chat/';

class BespokeChatApi extends ChatApi {
  String _formatHistory(List<ChatMessage> history) {
    /*  messages should be in the format:
    User: <message>
    Assistant: <message>
    User: <message>
    ...
    */

    final str = StringBuffer();
    for (final message in history) {
      str.write(
        message.role == ChatMessageRole.user ? 'User: ' : 'Assistant: ',
      );
      str.write(message.message);
      str.write('\n');
    }
    return str.toString();
  }

  @override
  Future<ChatResponse> nextMessage({
    required String message,
    required List<ChatMessage> history,
    int? pdfPage,
  }) async {
    final formatted = _formatHistory(history.sublist(history.length - 2));
    print('');
    print(formatted);
    print('');
    // messages, slide_number

    final response = await http.post(
      Uri.parse(CHAT_ENDPOINT),
      body: jsonEncode({
        'messages': formatted,
        'slide_number': pdfPage?.toString() ?? '1',
      }),
    );
    print('Got response with status: ${response.statusCode}');
    if (response.statusCode != 200) {
      return ChatResponse(
        message: 'Sorry, an error occured while processing your message.',
      );
    }

    print('Response body: ${response.body}');
    // replace all characters with a code unit < ' '.codeUnit with a dollar sign

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    // decoded['content'] = jsonDecode(decoded['content']) as List<dynamic>;
    var responseMessage = m.Response.fromJson(decoded);
    final content = responseMessage.content;

    // var responseMessage = response.body.replaceAllMapped(
    //   RegExp(r'[\x00-\x1F]'),
    //   (match) => '\$',
    // );

    // replace double line breaks with single line breaks
    // responseMessage = responseMessage.replaceAll(RegExp(r'\n\n'), '\n');

    // final json = jsonDecode(responseMessage);

    // final content = jsonDecode(json['content'])[0]['text'];
    // final responseData = jsonDecode([0]);
    // [0]['text'] as String;
    // print(responseMessage);
    return ChatResponse(message: content);
  }
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
    int? pdfPage,
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
