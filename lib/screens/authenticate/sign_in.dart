import 'package:flutter/material.dart';
import 'package:jiitexpense/services/auth.dart';
import 'package:jiitexpense/shared/constants.dart';
import 'package:jiitexpense/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading =  false;

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to JIIT expense'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (email) => email.isEmpty ? 'Enter an Email' : null,
                onChanged: (email) {
                  setState(() {
                    this.email = email;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (password) => password.length < 6 ? 'Enter a password more than 6 character' : null,
                obscureText: true,
                onChanged: (password) {
                  setState(() {
                    this.password = password;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailPassword(email, password);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
