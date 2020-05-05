import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:jiitexpense/shared/widgets/email_text_input.dart';
import 'package:jiitexpense/shared/widgets/password_text_input.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
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
            EmailTextInput(updateEmail: updateEmail),
            SizedBox(height: 20.0),
            PasswordTextInput(updatePassword: updatePassword),
            SizedBox(height: 50.0),
            RaisedButton(
              child: Text('Login'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await authService.login(email, password);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'could not sign in with those credentials';
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
