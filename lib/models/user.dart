import 'package:jiitexpense/models/user_Canteen.dart';

class User {

  final String uid;
  final String email;
  final String name;
  List<UserCanteen> userCanteen;

  User({ this.uid , this.email, this.name, this.userCanteen});

  UserCanteen getUserCanteenWithUid(String uid) {
    return this.userCanteen.where((userCanteen) => userCanteen.uid == uid).first;
  }
}
