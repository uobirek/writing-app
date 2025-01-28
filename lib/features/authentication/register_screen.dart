import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/utils/input_decoration.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';

import 'base_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Register Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Create an account',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration:
                      formInputDecoration(label: 'Email', context: context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:
                      formInputDecoration(label: 'Password', context: context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _register();
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _register() async {
    if (!mounted) {
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await userCredential.user?.updateDisplayName(_nameController.text);

      if (!mounted) {
        return;
      }
      context.go('/projects');
    } on FirebaseAuthException catch (err) {
      if (!mounted) {
        return;
      }

      String errorMessage;
      switch (err.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use. Try logging in.';
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
        case 'weak-password':
          errorMessage = 'Your password is too weak. Use a stronger one.';
        case 'operation-not-allowed':
          errorMessage = 'Account creation is currently disabled.';
        default:
          errorMessage = 'Registration failed. Please try again later.';
      }

      showMessage(context, errorMessage);
    } catch (err) {
      if (!mounted) {
        return;
      }
      showMessage(context, 'An unexpected error occurred.');
    }
  }
}
