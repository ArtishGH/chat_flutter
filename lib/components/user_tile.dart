import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String subtitle;
  final void Function()? onTap;
  final bool isYou;
  final bool noMessagesYet;

  const UserTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.subtitle,
      required this.isYou,
      required this.noMessagesYet});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

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
                  noMessagesYet ? 'No messages yet' : (isYou ? subtitle : 'You: $subtitle'),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.7),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
