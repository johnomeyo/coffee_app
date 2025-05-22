// Auth Header Component
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final bool isSignIn;

  const AuthHeader({super.key, required this.isSignIn});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.lock_outline, size: 40, color: theme.primaryColor),
        ),
        const SizedBox(height: 24),
        Text(
          isSignIn ? 'Welcome Back' : 'Create Account',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isSignIn
              ? 'Sign in to your account to continue'
              : 'Join us and start your journey today',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
