import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/auth/login.dart';
import 'package:jiitexpense/Layouts/auth/register.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
  bool isLogin = true;
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isLogin ? Text('Login') : Text('Register'),
        actions: <Widget>[
          FlatButton(
            child: widget.isLogin ? Text('Register') : Text('Login'),
            onPressed: () {
              setState(() {
                widget.isLogin = !widget.isLogin;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: widget.isLogin ? Login() : Register(),
      ),
    );
  }
}
