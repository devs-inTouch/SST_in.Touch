import 'package:flutter/material.dart';
import 'package:flutter_basic/messages/application/message.dart';

class Conversation {
  final String name;
  final String? message;
  final bool isGroupChat;

  Conversation({required this.name, this.message, this.isGroupChat = false});
}

class MobileMessagesScaffold extends StatefulWidget {
  final Conversation? conversation; // Define the conversation parameter here

  const MobileMessagesScaffold({super.key, this.conversation});
  @override
  _MobileMessagesScaffold createState() => _MobileMessagesScaffold();
}

class _MobileMessagesScaffold extends State<MobileMessagesScaffold> {
  final List<Message> _messages = [];
  final List<Conversation> _conversations = [
    Conversation(name: 'Alice', message: 'Hi there!'),
    Conversation(name: 'Bob', message: 'What\'s up?'),
    Conversation(
        name: 'Group chat', message: 'Let\'s plan a party!', isGroupChat: true),
  ];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, Message('Me', text));
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationList() {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (_, int index) {
          final conversation = _conversations[index];
          return ListTile(
            title: Text(conversation.name),
            onTap: () {
              // Navigate to chat screen for this conversation
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MobileMessagesScaffold(conversation: conversation)),
              );
            },
          );
        },
        itemCount: _conversations.length,
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }

  Widget _buildCreateConversationButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String name = '';
              String email = '';
              return AlertDialog(
                title: const Text('Create a new conversation'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate the form values
                      if (name.isEmpty) {
                        return;
                      }

                      // Create the new conversation
                      final newConversation = Conversation(
                        name: name,
                        message: '',
                      );

                      // Navigate to the new conversation screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text('Conversation Screen'),
                              ),
                              body: Center(
                                child: Text(
                                    'Conversation: ${newConversation.toString()}'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text('Create a new conversation'),
      ),
    );
  }

  Widget _buildCreateGroupButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to create conversation screen
        },
        child: const Text('Create a new group'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation?.name ?? 'Chats'),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildConversationList(),
                  _buildCreateConversationButton(),
                  _buildCreateGroupButton(),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1.0),
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, int index) {
                        final message = _messages[index];
                        return ListTile(
                          title: Text(message.sender),
                          subtitle: Text(message.text),
                        );
                      },
                      itemCount: _messages.length,
                      reverse: true,
                    ),
                  ),
                  const Divider(height: 1.0),
                  Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).cardColor),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
