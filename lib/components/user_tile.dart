import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String subtitle;
  final void Function()? onTap;
  final bool isYou;
  final bool noMessagesYet;
  final int unreadCount;

  const UserTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.subtitle,
      required this.isYou,
      required this.noMessagesYet,
      required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    bool isUnread = unreadCount > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: isDarkMode
                  ? Colors.grey[200]
                  : Theme.of(context).colorScheme.primary,
              size: 40,
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18),
                ),
                Text(
                  noMessagesYet
                      ? 'No messages yet'
                      : (isYou ? (isUnread ? '» $subtitle' : subtitle) : 'You: $subtitle'),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: isUnread ? FontWeight.w800 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
            _buildNotification(context, unreadCount)
          ],
        ),
      ),
    );
  }

  Widget _buildNotification(BuildContext context, int unreadCount) {
    bool isUnread = unreadCount > 0;

    return Row(
      children: [
        if (isUnread)
          Icon(
            Icons.notifications_rounded,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        if (isUnread && unreadCount > 1)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              unreadCount.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
