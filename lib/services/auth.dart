import 'package:firebase_auth/firebase_auth.dart';

import './database.dart';
import '../model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((_userFromFirebaseUser));
  }

  Stream<User> get userData {
    return _auth.onAuthStateChanged.map((_userFromFirebaseUser));
  }

  //SignIn using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword({
    String email,
    String password,
    String firstName,
    String lastName,
    String gender,
    double height,
    double weight,
    DateTime dob,
    double activityFactor,
    double favoriteExcercise,
    int age,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseUser user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
        firstName: firstName,
        lastName: lastName,
        height: height,
        weight: weight,
        activityFactor: activityFactor,
        favoriteExcercise: favoriteExcercise,
        dob: dob,
        gender: gender,
        age: age,
      );

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
