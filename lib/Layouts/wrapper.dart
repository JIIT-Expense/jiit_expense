import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/auth/auth.dart';
import 'package:jiitexpense/Layouts/canteen/canteenSelect.dart';

import 'package:jiitexpense/model/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    if (user == null) {
      return Auth();
    } else {
      return CanteenSelect();
    }
  }
}
