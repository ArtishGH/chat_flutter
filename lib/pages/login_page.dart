import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void loginHandler(BuildContext context) async {
    // auth service
    final _auth = AuthService();

    // try logging in
    try {
      await _auth.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(
            height: 56,
          ),

          // welcome back message
          Text(
            "Welcome back, you've been missed",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),

          const SizedBox(
            height: 20,
          ),

          // email
          MyTextField(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(
            height: 20,
          ),

          // password
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(
            height: 20,
          ),

          // button
          MyButton(
            buttonText: 'Login',
            onTap: () => loginHandler(context),
          ),

          const SizedBox(
            height: 20,
          ),

          // not a member?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Register now',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
