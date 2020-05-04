import 'package:flutter/material.dart';
import 'package:jiitexpense/services/auth.dart';
import 'package:jiitexpense/shared/constants.dart';
import 'package:jiitexpense/widgets/email_text_input.dart';
import 'package:jiitexpense/shared/loading.dart';
import 'package:jiitexpense/widgets/password_text_input.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register ({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
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

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register in to JIIT expense'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
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
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  print(this.email);
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailPassword(name, email, password);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
