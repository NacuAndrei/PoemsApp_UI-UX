import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'Services/AuthService.dart';
import 'package:poetry_app/Auth/Widgets/TextInput.dart';
import 'package:poetry_app/Auth/Widgets/PasswordInput.dart';
import 'package:form_validator/form_validator.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final String? Function(String?) _userValidator = ValidationBuilder()
      .regExp(RegExp(r'^[a-zA-Z]'), 'Field must start with a letter')
      .minLength(3)
      .maxLength(255)
      .build();

  static final String? Function(String?) _emailValidator =
      ValidationBuilder().email().maxLength(255).build();

  static final String? Function(String?) _passwordValidator =
      ValidationBuilder().minLength(10).maxLength(255).build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          children: [
            TextInput(
                controller: _nameController,
                label: 'User',
                validator: _userValidator),
            const SizedBox(height: 20.0, width: null),
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
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? message = await GetIt.instance<AuthService>()
                        .signUpWithPassword(_nameController.text,
                            _emailController.text, _passwordController.text);
                    if (mounted && message != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                    }
                  }
                },
                child: const Text("Sign up")),
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
}
