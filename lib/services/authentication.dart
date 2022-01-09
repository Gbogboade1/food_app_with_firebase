import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_rest/model/user_model.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyPhone(String phoneNu) async {
    final PhoneCodeAutoRetrievalTimeout autoRetieve = (String verid) {};

    final PhoneCodeSent smsCodeSent = (String verid, [int forceCodeResend]) {};

    final PhoneVerificationCompleted verifSuccess = (AuthCredential user) {
      print("object");
    };
    final PhoneVerificationFailed verifFailed = (AuthException ex) {};

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNu,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifSuccess,
        verificationFailed: verifFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetieve);
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> userPhoneNo() async {
    FirebaseUser user = await getCurrentUser();
    return user.phoneNumber;
  }

  Future<User> getUserDetails() async {
    String phoneNumber = await userPhoneNo();
    await Firestore.instance
        .collection('users')
        .document('$phoneNumber')
        .get()
        .then((DocumentSnapshot ds) async {
      // use ds as a snapshot
      if (ds != null && ds.data != null) {
        return User.fromMap(ds.data);
      } else {
        return User();
      }
    });
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> changeEmail(String email) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updateEmail(email).then((_) {
      print("Succesfull changed email");
    }).catchError((error) {
      print("email can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> changePassword(String password) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }
}
