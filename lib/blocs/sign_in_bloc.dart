import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:medico/services/auth.dart';
import 'package:rxdart/rxdart.dart';

enum CurrentPage {
  REGISTRATION_PAGE,
  VERIFICATION_PAGE,
}

class SignInBloc {
  final Auth auth;
  SignInBloc({@required this.auth});

  final TextEditingController _countryCodeTextController =
      TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final TextEditingController _otpTextController = TextEditingController();

  final StreamController<CurrentPage> _currentPageStreamController =
      StreamController();

  final StreamController<bool> _inAsyncCallStreamController = BehaviorSubject();

  String verId;
  int _forceResendingToken;

  void requestOtp({
    @required VoidCallback onLoginSuccess,
    @required Function(String) onLoginFailure,
    @required Function(String) onVerificationFailed,
    @required VoidCallback onCodeAutoRetrievalTimeout,
  }) {
    _inAsyncCallStreamController.add(true);
    auth.verifyPhoneNumber(
      phoneNumber:
          '+${_countryCodeTextController.text.trim()}${_phoneNumberTextController.text.trim()}',
      timeout: new Duration(minutes: 2),
      onVerificationCompleted: (authCredential) {
        _signInWithAuthCredential(
          authCredential: authCredential,
          onLoginSuccess: onLoginSuccess,
          onLoginFailure: onLoginFailure,
        );
      },
      onVerificationFailed: (errMsg) {
        _inAsyncCallStreamController.add(false);
        onVerificationFailed(errMsg);
      },
      onCodeSent: (verId, [token]) {
        this.verId = verId;
        _forceResendingToken = token;
        _inAsyncCallStreamController.add(false);
        _currentPageStreamController.add(CurrentPage.VERIFICATION_PAGE);
      },
      onCodeAutoRetrievalTimeout: (verId) {
        this.verId = verId;
        onCodeAutoRetrievalTimeout();
      },
      forceResendingToken: _forceResendingToken,
    );
  }

  void signWithGoogle({
    @required VoidCallback onLoginSuccess,
    @required Function(String) onLoginFailure,
  }) async {
    _inAsyncCallStreamController.add(true);
    final result = await auth.signInWithGoogle();
    result.fold(
      (errMsg) {
        _inAsyncCallStreamController.add(false);
        onLoginFailure(errMsg);
      },
      (user) {
        print('Log in Successful ${user.uid}');
        onLoginSuccess();
      },
    );
  }

  void signWithFacebook({
    @required VoidCallback onLoginSuccess,
    @required Function(String) onLoginFailure,
  }) async {
    _inAsyncCallStreamController.add(true);
    final result = await auth.signInWithFacebook();
    result.fold(
      (errMsg) {
        _inAsyncCallStreamController.add(false);
        onLoginFailure(errMsg);
      },
      (user) {
        print('Log in Successful ${user.uid}');
        onLoginSuccess();
      },
    );
  }

  void signInWithOtp({
    @required VoidCallback onLoginSuccess,
    @required Function(String) onLoginFailure,
  }) {
    _signInWithAuthCredential(
      authCredential: PhoneAuthProvider.getCredential(
          verificationId: verId, smsCode: _otpTextController.text.trim()),
      onLoginSuccess: onLoginSuccess,
      onLoginFailure: onLoginFailure,
    );
  }

  void _signInWithAuthCredential({
    @required AuthCredential authCredential,
    @required VoidCallback onLoginSuccess,
    @required Function(String) onLoginFailure,
  }) async {
    _inAsyncCallStreamController.add(true);
    final result =
        await auth.signInWithAuthCredential(authCredential: authCredential);
    result.fold(
      (errMsg) {
        _inAsyncCallStreamController.add(false);
        onLoginFailure(errMsg);
      },
      (user) {
        print('Log in Successful ${user.uid}');
        onLoginSuccess();
      },
    );
  }

  void dispose() {
    _countryCodeTextController.dispose();
    _phoneNumberTextController.dispose();
    _otpTextController.dispose();
    _inAsyncCallStreamController.close();
    _currentPageStreamController.close();
  }

  TextEditingController get countryCodeTextController =>
      _countryCodeTextController;
  TextEditingController get phoneNumberTextController =>
      _phoneNumberTextController;
  TextEditingController get otpTextController => _otpTextController;
  Stream get currentPageStream => _currentPageStreamController.stream;
  Stream<bool> get inAsyncCallStream => _inAsyncCallStreamController.stream;
}
