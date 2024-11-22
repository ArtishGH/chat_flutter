import 'package:chat_flutter/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/chat_bubble.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import '../themes/theme_provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  // scroll down
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn);
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      // clear the controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.receiverEmail),
        elevation: 0,
      ),
      body: Column(
        children: [
          // display messages
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data["message"],
              isCurrentUser: isCurrentUser,
            )
          ],
        ));
  }

  Widget _buildUserInput(context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 56.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            hintText: 'Type a message',
            obscureText: false,
            controller: _messageController,
            focusNode: myFocusNode,
          )),
          Container(
              decoration: BoxDecoration(
                color:
                    isDarkMode ? Colors.green.shade600 : Colors.green.shade500,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
