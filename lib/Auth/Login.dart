import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final AuthService _authService = AuthService();

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
                // TO DO: Process forgot password
              },
            ),
            const SizedBox(height: 20.0, width: null),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TO DO: send data to firebase
                  }
                },
                child: const Text("Log in")),
            const SizedBox(height: 20.0, width: null),
            OutlinedButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              onPressed: () {
                var message = _authService.signInWithGoogle();
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
