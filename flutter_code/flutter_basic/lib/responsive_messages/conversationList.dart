import 'package:flutter/material.dart';

import 'chatScreen.dart';

class ConversationList extends StatelessWidget {
  final List<Conversation> conversations;
  final Function(Conversation) onConversationSelected; // Add a new property here

  const ConversationList({super.key, required this.conversations, required this.onConversationSelected});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (_, int index) {
          final conversation = conversations[index];
          return ListTile(
            title: Text(conversation.name),
            onTap: () {
              // Call the onConversationSelected callback with the selected conversation
              onConversationSelected(conversation);
            },
          );
        },
        itemCount: conversations.length,
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}