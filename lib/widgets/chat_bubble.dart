import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final Color color;
  const ChatBubble({super.key, required this.color});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: widget.color,
    );
  }
}
