import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:chat_flutter/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text('U S E R S'),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Container(child: _buildUserList()),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList());
        });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData,
      BuildContext context) {
    // Skip the currently logged-in user
    if (userData["email"] == _authService.getCurrentUser()!.email) {
      return Container();
    }

    return StreamBuilder<String?>(
      stream: _chatService.getLastMessage(userData["uid"]),
      builder: (context, snapshot) {
        String lastMessage = snapshot.connectionState == ConnectionState.waiting
            ? "Loading..."
            : snapshot.data ?? "No messages yet";
        bool noMessagesYet = snapshot.data == null;

        return StreamBuilder<String?>(
          stream: _chatService.getLastMessageUser(userData["uid"]),
          builder: (context, snapshot) {
            String lastMessageUserID = snapshot.connectionState ==
                ConnectionState.done ? 'Loading...' : snapshot.data ??
                "Unknown";
            bool isYou = lastMessageUserID == userData["uid"];

          return UserTile(
        text: userData["email"],
          subtitle: lastMessage,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData["uid"],
                    ),
              ),
            );
          },
          isYou: isYou,
          noMessagesYet: noMessagesYet,
        );
      },
    );
  }

  ,

  );
}}
