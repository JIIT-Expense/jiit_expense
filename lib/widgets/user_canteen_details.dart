import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/models/user.dart';
import 'package:jiitexpense/models/user_Canteen.dart';
import 'package:jiitexpense/shared/loading.dart';

class UserCanteenDetails extends StatelessWidget {
  final Canteen canteen;
  final User user;
  UserCanteenDetails({this.canteen, this.user});

  @override
  Widget build(BuildContext context) {
    UserCanteen userCanteen = user.getUserCanteenWithUid(canteen.uid);
    return user != null ? Text(userCanteen.balance as String) : Loading();
  }
}
