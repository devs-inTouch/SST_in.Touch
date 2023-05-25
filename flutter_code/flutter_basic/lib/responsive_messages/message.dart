import 'package:flutter/material.dart';

class Message {
  final String sender;
  final String text;

  Message(this.sender, this.text);
}

class ChatMessage extends StatelessWidget {
  final Message message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(message.sender[0])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.sender,
                  style: Theme.of(context).textTheme.titleLarge),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(message.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}