import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          // Improved clipboard access (considering potential null safety)
          final clipboard = ClipboardData(text: message.message);
          Clipboard.setData(clipboard).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Message copied!'),
                duration: const Duration(seconds: 2),
              ),
            );
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: Colors.black45,
          ),
          child: Text(
            message.message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Improved clipboard access (considering potential null safety)
          final clipboard = ClipboardData(text: message.message);
          Clipboard.setData(clipboard).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Message copied!'),
                duration: const Duration(seconds: 2),
              ),
            );
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Colors.white54,
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
