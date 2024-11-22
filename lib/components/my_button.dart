import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  void Function()? onTap;

  MyButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(buttonText, style: TextStyle(color: isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary, fontSize: 16),),
        ),
      ),
    );
  }
}
