import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/utils/input_decoration.dart';

import 'base_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BaseScreen(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: localizations!.signInToContinue,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: formInputDecoration(
                        label: localizations.email,
                        context: context,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.pleaseEnterAnEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: formInputDecoration(
                        label: localizations.password,
                        context: context,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.pleaseEnterAPassword;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _login,
                        child: Text(localizations.login),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.dontHaveAnAccount,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: Text(localizations.register),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final localizations = AppLocalizations.of(context);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null && userId.isNotEmpty) {
        if (!mounted) {
          return;
        }
        final projectCubit = context.read<ProjectCubit>();
        await projectCubit.fetchProjects(userId);
      }

      if (!mounted) {
        return;
      }
      context.go('/projects');
    } catch (err) {
      if (!mounted) {
        return;
      }
      _showErrorDialog(localizations!.loginFailed);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    final localizations = AppLocalizations.of(context);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.ok),
          ),
        ],
      ),
    );
  }
}
