import 'package:flutter/material.dart';
import 'package:jiitexpense/shared/constants/text_input_decoration.dart';

class PasswordTextInput extends StatelessWidget {

  Function updatePassword;

  PasswordTextInput({ this.updatePassword });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: 'Password'),
      validator: (password) => password.length < 6 ? 'Enter a password more than 6 character' : null,
      obscureText: true,
      onChanged: (password) {
        updatePassword(password);
      },
    );
  }
}