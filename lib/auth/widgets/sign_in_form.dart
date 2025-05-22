
// Sign In Form Component
import 'package:coffee_app/auth/widgets/custom_btn.dart';
import 'package:coffee_app/auth/widgets/custom_checkbox.dart';
import 'package:coffee_app/auth/widgets/custom_textfield.dart';
import 'package:coffee_app/auth/widgets/divider_with_text.dart';
import 'package:coffee_app/auth/widgets/social_sign_in_btn.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final VoidCallback onToggleMode;

  const SignInForm({
    super.key,
    required this.onToggleMode,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in successful!')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    
    // Simulate Google Sign In
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign in successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            isPassword: true,
            prefixIcon: Icons.lock_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value ?? false),
                label: 'Remember me',
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Forgot password clicked')),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Sign In',
            onPressed: _signInWithEmail,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 20),
          const DividerWithText(text: 'OR'),
          const SizedBox(height: 20),
          SocialSignInButton(
            text: 'Continue with Google',
            icon: Icons.apple,
            onPressed: _signInWithGoogle,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: widget.onToggleMode,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

