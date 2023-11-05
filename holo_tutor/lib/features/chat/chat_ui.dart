import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holo_tutor/core/state.dart';
import 'package:holo_tutor/features/chat/chat_api.dart';

class ChatNotifier extends ChangeNotifier {
  final List<ChatMessage> history = [];
  final ChatApi chatApi = BespokeChatApi();

  Future<void> sendMessage(String message, int? pdfPage) async {
    history.add(ChatMessage(
      role: ChatMessageRole.user,
      message: message,
      createdAt: DateTime.now(),
    ));
    notifyListeners();

    ChatResponse? response;

    try {
      response = await chatApi.nextMessage(
        message: message,
        history: history,
        pdfPage: pdfPage,
      );
    } finally {
      response ??= ChatResponse(
        message: 'Sorry, an error occured while processing your message.',
      );
    }

    history.add(ChatMessage(
      role: ChatMessageRole.assistant,
      message: response.message,
      createdAt: DateTime.now(),
    ));

    notifyListeners();
  }
}

final chatProvider = ChangeNotifierProvider((ref) => ChatNotifier());

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPanel extends ConsumerWidget {
  const ChatPanel({super.key});
  final _user = const types.User(id: 'user');
  final _assistant = const types.User(id: 'assistant');

  List<types.Message> getMessages(List<ChatMessage> history) {
    return history
        .map((m) => types.TextMessage(
              author: m.role == ChatMessageRole.user ? _user : _assistant,
              id: m.createdAt.millisecondsSinceEpoch.toString(),
              text: m.message,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatProvider);
    final state = ref.watch(stateProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Chat(
          messages: getMessages(chatNotifier.history.reversed.toList()),

          // [
          //   types.TextMessage(
          //     author: _assistant,
          //     createdAt: DateTime.now().millisecondsSinceEpoch,
          //     id: randomString(),
          //     text:
          //         'Hello! How can I assist you today? If you have any questions or need assistance with something, feel free to ask.',
          //   ),
          //   types.TextMessage(
          //     author: _user,
          //     createdAt: DateTime.now().millisecondsSinceEpoch -
          //         const Duration(minutes: 1).inMilliseconds,
          //     id: randomString(),
          //     text: 'Hello World!',
          //   ),
          // ],
          onSendPressed: (text) {
            chatNotifier.sendMessage(text.text, state.pdfPage);
          },
          user: _user,
        ),
        // child: Column(
        //   children: [
        //     // Expanded(child: MessageList()),
        //     // ChatInput(),
        //   ],
        // ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
