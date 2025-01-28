import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/l10n/app_localizations.dart';
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
    final localizations = AppLocalizations.of(context);

    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: localizations!.createAnAccount,
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _register();
                    }
                  },
                  child: Text(localizations.register),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.alreadyHaveAnAccount,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: Text(localizations.login),
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
    final localizations = AppLocalizations.of(context);

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
          errorMessage = localizations!.emailAlreadyInUse;
        case 'invalid-email':
          errorMessage = localizations!.invalidEmail;
        case 'weak-password':
          errorMessage = localizations!.weakPassword;
        case 'operation-not-allowed':
          errorMessage = localizations!.operationNotAllowed;
        default:
          errorMessage = localizations!.registrationFailed;
      }

      showMessage(context, errorMessage);
    } catch (err) {
      if (!mounted) {
        return;
      }
      showMessage(context, localizations!.unexpectedError);
    }
  }
}
