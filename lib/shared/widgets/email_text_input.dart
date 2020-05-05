import 'package:flutter/material.dart';
import 'package:jiitexpense/shared/constants/text_input_decoration.dart';

class EmailTextInput extends StatelessWidget {

  Function updateEmail;

  EmailTextInput({ this.updateEmail });

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: textInputDecoration.copyWith(hintText: 'Email'),
        validator: emailValidator,
        onChanged: (email) {
          updateEmail(email);
        }
    );
  }
}