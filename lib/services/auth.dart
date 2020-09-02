import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  final String name;
  final String phoneNumber;

  User({
    @required this.uid,
    @required this.name,
    @required this.phoneNumber,
  });
}

abstract class AuthBase {
  Stream<User> onAuthStateChanged();
  Future<User> currentUser();
  void verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration timeout,
    @required Function(AuthCredential) onVerificationCompleted,
    @required Function(String) onVerificationFailed,
    @required Function(String, [int]) onCodeSent,
    @required Function(String) onCodeAutoRetrievalTimeout,
    @required int forceResendingToken,
  });
  Future<Either<String, User>> signInWithAuthCredential({
    @required AuthCredential authCredential,
  });
  Future<Either<String, User>> signInWithGoogle();
  Future<Either<String, User>> signInWithFacebook();
  void signOut();
}

class Auth implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;
    return User(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  @override
  Stream<User> onAuthStateChanged() {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final firebaseUser = await _firebaseAuth.currentUser();
    return _userFromFirebase(firebaseUser);
  }

  @override
  void verifyPhoneNumber({
    @required String phoneNumber,
    @required Duration timeout,
    @required Function(AuthCredential) onVerificationCompleted,
    @required Function(String) onVerificationFailed,
    @required Function(String, [int]) onCodeSent,
    @required Function(String) onCodeAutoRetrievalTimeout,
    @required int forceResendingToken,
  }) {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: (authException) {
        if (authException.code == 'firebaseAuth') {
          onVerificationFailed(
            'SignIn has been disabled temporarily for testing purpose you can comeback later, ThankYou.',
          );
        } else if (authException.code == 'invalidCredential') {
          onVerificationFailed('Invalid phone number entered.');
        } else {
          onVerificationFailed(authException.message);
        }
      },
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  @override
  Future<Either<String, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final authResult =
          await _firebaseAuth.signInWithCredential(authCredential);
      return Right(_userFromFirebase(authResult.user));
    } on PlatformException {
      return Left('Invalid credentials has been entered.');
    } on NoSuchMethodError {
      return Left('Sign-in has been cancelled');
    } catch (err) {
      print(
          'Exception => Type: ${err.runtimeType}, Code: ${err.code} Message: ${err.message}');
      return Left(err.message);
    }
  }

  @override
  Future<Either<String, User>> signInWithFacebook() async {
    final res = await FacebookLogin().logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.Success:
        final accessToken = res.accessToken.token;
        try {
          final authResult = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.getCredential(
              accessToken: accessToken.toString(),
            ),
          );
          return Right(_userFromFirebase(authResult.user));
        } catch (err) {
          print(
              'Exception => Type: ${err.runtimeType}, Code: ${err.code} Message: ${err.message}');
          return Left(err.message);
        }
        break;
      case FacebookLoginStatus.Cancel:
        return Left('Facebook sign-in cancelled.');
      case FacebookLoginStatus.Error:
        print('Error while log in: ${res.error}');
        return Left('Facebook sign-in error.');
    }
    return Left('Unable to use facebook login.');
  }

  @override
  Future<Either<String, User>> signInWithAuthCredential(
      {@required AuthCredential authCredential}) async {
    try {
      final authResult =
          await _firebaseAuth.signInWithCredential(authCredential);
      return Right(_userFromFirebase(authResult.user));
    } on PlatformException {
      return Left('Invalid OTP has been entered.');
    } catch (err) {
      print(
          'Exception => Type: ${err.runtimeType}, Code: ${err.code} Message: ${err.message}');
      return Left(err.message);
    }
  }

  @override
  void signOut() {
    _firebaseAuth.signOut();
  }
}
