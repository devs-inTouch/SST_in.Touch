import 'package:flutter/material.dart';
import 'chatScreen.dart';
import 'message.dart';

class ChatScreenState extends StatefulWidget {
  const ChatScreenState({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenState> {
  final List<Message> _messages = [];

  void _handleConversationSelected(Conversation conversation) {
    setState(() {
      _messages.clear();
      _messages.addAll(conversation.messages! as Iterable<Message>);
    });
  }

  void _handleMessageSent(String text) {
    //  final newMessage = Message(text: text);
    setState(() {
      //    _messages.add(newMessage);
      //    _selectedConversation!.messages!.add(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                );
              },
            ),
          ),
          //    ConversationList(
          //      onConversationSelected: _handleConversationSelected,
          //  ),
          //NewMessageForm(
          //onMessageSent: _handleMessageSent,
          //),
        ],
      ),
    );
  }
}
