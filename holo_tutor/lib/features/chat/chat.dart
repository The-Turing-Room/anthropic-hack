import 'package:flutter/material.dart';

class ChatPanel extends StatelessWidget {
  const ChatPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: MessageList()),
        ChatInput(),
      ],
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
