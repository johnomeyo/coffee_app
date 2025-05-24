// // Sign In Form Component
// import 'package:coffee_app/auth/widgets/custom_btn.dart';
// import 'package:coffee_app/auth/widgets/custom_checkbox.dart';
// import 'package:coffee_app/auth/widgets/custom_textfield.dart';
// import 'package:coffee_app/auth/widgets/divider_with_text.dart';
// import 'package:coffee_app/auth/widgets/social_sign_in_btn.dart';
// import 'package:coffee_app/homepage/home_page.dart';
// import 'package:flutter/material.dart';

// class SignInForm extends StatefulWidget {
//   final VoidCallback onToggleMode;

//   const SignInForm({super.key, required this.onToggleMode});

//   @override
//   State<SignInForm> createState() => _SignInFormState();
// }

// class _SignInFormState extends State<SignInForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _rememberMe = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signInWithEmail(BuildContext context) async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() => _isLoading = false);

//     if (mounted) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Sign in successful!')));
//     }
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const FarmersHomePage()),
//     );
//   }

//   Future<void> _signInWithGoogle() async {
//     setState(() => _isLoading = true);

//     // Simulate Google Sign In
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() => _isLoading = false);

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Google sign in successful!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           CustomTextField(
//             controller: _emailController,
//             label: 'Email',
//             hint: 'Enter your email',
//             keyboardType: TextInputType.emailAddress,
//             prefixIcon: Icons.email_outlined,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               if (!RegExp(
//                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//               ).hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//           CustomTextField(
//             controller: _passwordController,
//             label: 'Password',
//             hint: 'Enter your password',
//             isPassword: true,
//             prefixIcon: Icons.lock_outline,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               if (value.length < 6) {
//                 return 'Password must be at least 6 characters';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomCheckbox(
//                 value: _rememberMe,
//                 onChanged:
//                     (value) => setState(() => _rememberMe = value ?? false),
//                 label: 'Remember me',
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                     // color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           CustomButton(
//             text: 'Sign In',
//             onPressed: () => _signInWithEmail(context),
//             isLoading: _isLoading,
//           ),
//           const SizedBox(height: 20),
//           const DividerWithText(text: 'OR'),
//           const SizedBox(height: 20),
//           SocialSignInButton(
//             text: 'Continue with Google',
//             onPressed: _signInWithGoogle,
//             isLoading: _isLoading,
//           ),
//           const SizedBox(height: 40),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Don\'t have an account? ',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               TextButton(
//                 onPressed: widget.onToggleMode,
//                 child: Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// Sign In Form Component
import 'package:coffee_app/auth/widgets/custom_btn.dart';
import 'package:coffee_app/auth/widgets/custom_checkbox.dart';
import 'package:coffee_app/auth/widgets/custom_textfield.dart';
import 'package:coffee_app/auth/widgets/divider_with_text.dart';
import 'package:coffee_app/auth/widgets/social_sign_in_btn.dart';
import 'package:coffee_app/homepage/home_page.dart';
import 'package:coffee_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for User type

class SignInForm extends StatefulWidget {
  final VoidCallback onToggleMode;

  const SignInForm({super.key, required this.onToggleMode});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  // Instantiate your AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    User? user = await _authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (user != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in successful!')),
        );
        Navigator.pushReplacement( // Use pushReplacement to prevent going back to sign-in
          context,
          MaterialPageRoute(builder: (context) => const FarmersHomePage()),
        );
      }
    } else {
      // Handle the error (e.g., show a SnackBar)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to sign in. Check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    User? user = await _authService.signInWithGoogle();

    setState(() => _isLoading = false);

    if (user != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign in successful!')),
        );
        Navigator.pushReplacement( // Use pushReplacement
          context,
          MaterialPageRoute(builder: (context) => const FarmersHomePage()),
        );
      }
    } else {
      // Handle the error (e.g., show a SnackBar)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google sign in failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
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
                onChanged:
                    (value) => setState(() => _rememberMe = value ?? false),
                label: 'Remember me',
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement forgot password logic
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
            onPressed: () => _signInWithEmail(context),
            isLoading: _isLoading,
          ),
          const SizedBox(height: 20),
          const DividerWithText(text: 'OR'),
          const SizedBox(height: 20),
          SocialSignInButton(
            text: 'Continue with Google',
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