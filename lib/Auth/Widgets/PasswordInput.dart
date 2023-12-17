import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poetry_app/Auth/Widgets/TextInput.dart';

class PasswordInput extends TextInput {
  const PasswordInput(
      {Key? key,
      required TextEditingController controller,
      required String label,
      required String? Function(String?)? validator})
      : super(
            key: key,
            controller: controller,
            label: label,
            validator: validator);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isPasswordHidden = true;
  static const IconData _passwordShowIcon = FontAwesomeIcons.eye;
  static const IconData _passwordHideIcon = FontAwesomeIcons.eyeSlash;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isPasswordHidden,
      enableSuggestions: false,
      autocorrect: false,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
          icon: Icon(_isPasswordHidden ? _passwordShowIcon : _passwordHideIcon),
        ),
      ),
    );
  }
}
