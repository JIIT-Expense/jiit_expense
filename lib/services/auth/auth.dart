import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiitexpense/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String canteenUserDb = "CanteenUsers";

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, name: user.displayName, email: user.email) : null;
  }

  Future register(String name, String email, String password) async {
    try {
      // adding name to firebase user
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await result.user.updateProfile(userUpdateInfo);
      // up until here
      FirebaseUser user = result.user;
      await user.reload();
      user = await _auth.currentUser();
      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  isCanteenUser(userId) async {
    DocumentSnapshot doc = await Firestore.instance.collection(canteenUserDb).document(userId).get();
    if (doc == null || !doc.exists) {
      return false;
    }
    return true;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}