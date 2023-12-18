import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Auth/Widgets/TextInput.dart';
import 'package:poetry_app/Auth/Widgets/PasswordInput.dart';
import 'package:form_validator/form_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetPasswordEmailController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetPasswordFormKey = GlobalKey<FormState>();

  static final String? Function(String?) _emailValidator =
      ValidationBuilder().email().maxLength(255).build();

  static final String? Function(String?) _passwordValidator =
      ValidationBuilder().minLength(10).maxLength(255).build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          children: [
            TextInput(
                controller: _emailController,
                label: 'Email',
                validator: _emailValidator),
            const SizedBox(height: 20.0, width: null),
            PasswordInput(
                controller: _passwordController,
                label: 'Password',
                validator: _passwordValidator),
            const SizedBox(height: 20.0, width: null),
            InkWell(
              child: const Text(
                "Forgot your password?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _forgotPasswordDialog(context);
              },
            ),
            const SizedBox(height: 20.0, width: null),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? message = await GetIt.instance<AuthService>()
                        .signInWithPassword(
                            _emailController.text, _passwordController.text);

                    if (mounted && message != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                    }
                  }
                },
                child: const Text("Log in")),
            const SizedBox(height: 20.0, width: null),
            OutlinedButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              onPressed: () async {
                String? message =
                    await GetIt.instance<AuthService>().signInWithGoogle();
                if (mounted && message != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
              },
              label: const Text("Sign in with Google"),
              icon: const Icon(FontAwesomeIcons.google),
            ),
          ],
        ),
      ),
    );
  }

  void _forgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? firebaseErrorMessage;
        bool buttonEnabled = true;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Center(child: Text("Password reset")),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _resetPasswordFormKey,
                    child: TextInput(
                        controller: _resetPasswordEmailController,
                        label: "Email",
                        validator: (String? str) {
                          String? message = _emailValidator(str);
                          if (message != null) {
                            return message;
                          }
                          return firebaseErrorMessage;
                        }),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: buttonEnabled
                    ? () async {
                        if (_resetPasswordFormKey.currentState!.validate()) {
                          setState(() {
                            buttonEnabled = false;
                          });

                          String? message = await GetIt.instance<AuthService>()
                              .resetPassword(
                                  _resetPasswordEmailController.text);

                          if (mounted) {
                            setState(() {
                              firebaseErrorMessage = message;
                              _resetPasswordFormKey.currentState!.validate();
                              firebaseErrorMessage = null;
                              buttonEnabled = true;
                            });

                            if (message == null) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Email has been sent")));
                            }
                          }
                        }
                      }
                    : null,
                child: const Text("Send password reset link"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
            ],
          );
        });
      },
    );
  }
}
