import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void registerHandler(BuildContext context) {
    final _auth = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hey there! ",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          // email
          MyTextField(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(
            height: 12,
          ),

          // password
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(
            height: 12,
          ),

          // confirm password
          MyTextField(
            hintText: 'Confirm password',
            obscureText: true,
            controller: _confirmPasswordController,
          ),

          const SizedBox(
            height: 20,
          ),

          // button
          MyButton(
            buttonText: 'Register',
            onTap: () => registerHandler(context),
          ),

          const SizedBox(
            height: 20,
          ),

          // not a member?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Login now',
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
