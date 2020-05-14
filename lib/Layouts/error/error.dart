import 'package:flutter/material.dart';

class ErrorScreenDisplay extends StatelessWidget {
  final String errorMessage;
  const ErrorScreenDisplay({Key key, this.errorMessage}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opps Something went wrong...'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$errorMessage'),
            Text('Go back and try again later')
          ],
        ),
      ),
    );
  }
}
