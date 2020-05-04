import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiitexpense/models/user.dart';
import 'package:jiitexpense/models/user_Canteen.dart';
import 'package:jiitexpense/services/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserService();

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, name: user.displayName, userCanteen: getUserCanteen(user.uid)) : null;
  }

  Future registerWithEmailPassword(String name, String email, String password) async {
    try {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await result.user.updateProfile(userUpdateInfo);
      FirebaseUser user = result.user;
      await user.reload();
      user = await _auth.currentUser();
      UserService().createNewUser(user.uid);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  List<UserCanteen>getUserCanteen(String uid) {
    return UserService().getAllCanteens(uid);
  }

}