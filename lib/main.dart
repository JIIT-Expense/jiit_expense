import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/wrapper.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/passCodeScreen.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: PassCodeScreen(),

      ),
    );
  }
}
