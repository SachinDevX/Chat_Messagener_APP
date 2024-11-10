import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender; // True if the message is from the sender, false if from the receiver.

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender, // Add this to determine sender or receiver
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(
        bottom: 8,
        left: isSender ? 50 : 10,
        right: isSender ? 10 : 50,
      ), // Adjust margin based on sender or receiver
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSender ? Colors.blue : Colors.grey, // Different colors for sender and receiver
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
