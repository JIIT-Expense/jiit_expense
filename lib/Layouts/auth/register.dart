import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:jiitexpense/shared/constants/text_input_decoration.dart';
import 'package:jiitexpense/shared/widgets/email_text_input.dart';
import 'package:jiitexpense/shared/widgets/password_text_input.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String name = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    updateEmail(String email) {
      setState(() {
        this.email = email;
      });
    }

    updatePassword(String password) {
      setState(() {
        this.password = password;
      });
    }
    return loading ? Loading() : Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (name) => name.length == 0 ? 'Name must be entered' : null,
              onChanged: (name) {
                setState(() {
                  this.name = name;
                });
              },
            ),
            SizedBox(height: 20.0),
            EmailTextInput(updateEmail: updateEmail),
            SizedBox(height: 20.0),
            PasswordTextInput(updatePassword: updatePassword),
            SizedBox(height: 50.0),
            RaisedButton(
              child: Text('Register'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await authService.register(name, email, password);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Please supply a valid email';
                    });
                  }
                }
              },
            ),
            SizedBox(height: 12.0),
            Center(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.red[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
