import 'package:coffee_app/auth/widgets/auth_header.dart';
import 'package:coffee_app/auth/widgets/sign_in_form.dart' show SignInForm;
import 'package:coffee_app/auth/widgets/sign_up_form.dart' show SignUpForm;
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isSignIn = true;

  void _toggleAuthMode() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      AuthHeader(isSignIn: _isSignIn),
                      const SizedBox(height: 40),
                      _isSignIn 
                        ? SignInForm(onToggleMode: _toggleAuthMode)
                        : SignUpForm(onToggleMode: _toggleAuthMode),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

