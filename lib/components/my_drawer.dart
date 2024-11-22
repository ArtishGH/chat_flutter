import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';
import '../themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logoutHandler() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme:
                  const DividerThemeData(color: Colors.transparent),
                ),
                child: DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.source_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 80,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  title: Text('H O M E', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                  leading: Icon(
                    Icons.home_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  title: Text('S E T T I N G S', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                  leading: Icon(
                    Icons.settings_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage(),));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, bottom: 24.0),
            child: ListTile(
              title: Text('L O G O U T', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
              leading: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: logoutHandler,
            ),
          ),
        ],
      ),
    );
  }
}
