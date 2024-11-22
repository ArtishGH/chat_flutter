import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
          borderRadius: isCurrentUser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12))
              : const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
              : (isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.secondary)),
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: isCurrentUser ? Colors.white : (isDarkMode ? Colors.white : Colors.black)),
      ),
    );
  }
}
