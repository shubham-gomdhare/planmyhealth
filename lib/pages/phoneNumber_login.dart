import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:medico/blocs/sign_in_bloc.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/widgets/common_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatelessWidget {
  final SignInBloc bloc;
  PhoneLogin({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: bloc.inAsyncCallStream,
      builder: (context, snapshot) {
        return ModalProgressHUD(
          inAsyncCall: snapshot.data,
          child: Scaffold(
            backgroundColor: Color(0xeeffffff),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup');
                },
              ),
            ),
            body: StreamBuilder<CurrentPage>(
              initialData: CurrentPage.REGISTRATION_PAGE,
              stream: bloc.currentPageStream,
              builder: (context, snapshot) {
                return snapshot.data == CurrentPage.REGISTRATION_PAGE
                    ? _registrationPage(context: context)
                    : _verificationPage(context: context);
              },
            ),
          ),
        );
      },
    );
  }

  Column _registrationPage({@required BuildContext context}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30.0),
          child: Image(
            image: AssetImage("images/verification.png"),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12.0),
          child: Text(
            "Enter your mobile number we will send \n you the OTP verify later",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        Container(
          height: 180.0,
          margin: EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Form(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: kMinFlingVelocity,
                      margin:
                          EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.0, color: Color(0xdddddddd)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: FormBuilderTextField(
                          attribute: 'CountryID',
                          controller: bloc.countryCodeTextController,
                          validators: [FormBuilderValidators.required()],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(right: 3, left: 3),
                            border: InputBorder.none,
                            prefixText: "+",
                            prefixStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40.0,
                        margin:
                            EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Color(0xdddddddd)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: FormBuilderTextField(
                            attribute: 'phoneNumber',
                            controller: bloc.phoneNumberTextController,
                            validators: [FormBuilderValidators.required()],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 6, left: 12, right: 12),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.verified_user),
                              prefixText: "",
                              prefixStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 50.0, bottom: 20.0, right: 30.0, left: 30.0),
                height: 40,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    bloc.requestOtp(
                      onLoginSuccess: () {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      },
                      onLoginFailure: (errMsg) {
                        showSnackBar(context: context, text: errMsg);
                      },
                      onVerificationFailed: (errMsg) {
                        showSnackBar(context: context, text: errMsg);
                      },
                      onCodeAutoRetrievalTimeout: () {
                        showSnackBar(
                            context: context,
                            text:
                                'Automatic verification time-out. Need to enter OTP manually.');
                      },
                    );
                    //Navigator.of(context).pushNamed('/verification');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _verificationPage({@required BuildContext context}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30.0),
          child: Text(
            "Enter Code",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12.0),
          child: Text(
            'we have sent you an SMS on your +${bloc.countryCodeTextController.text}  ${bloc.phoneNumberTextController.text} \n with 6 digit verification code.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          child: Center(
            child: Text(
              '* * * * * *',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
          ),
        ),
        Container(
          height: 180.0,
          margin: EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              _otpTextField(context),
              Container(
                margin: EdgeInsets.only(
                    top: 40.0, bottom: 20.0, right: 30.0, left: 30.0),
                height: 40,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    bloc.signInWithOtp(onLoginSuccess: () {
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                    }, onLoginFailure: (errMsg) {
                      showSnackBar(context: context, text: errMsg);
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30.0),
          child: Text(
            "Did not receive the code?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Re-send",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Get a call now",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otpTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: PinInputTextFormField(
        pinLength: 6,
        decoration: UnderlineDecoration(
          enteredColor: Colors.black,
          color: Colors.grey,
        ),
        controller: bloc.otpTextController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        onSubmit: (pin) {
          bloc.signInWithOtp(onLoginSuccess: () {
            Navigator.popUntil(context, ModalRoute.withName("/"));
          }, onLoginFailure: (errMsg) {
            showSnackBar(context: context, text: errMsg);
          });
        },
        validator: (pin) {
          if (pin.isEmpty) {
            return 'OTP cannot empty.';
          }
          if (pin.length < 6) {
            return 'Invalid OTP length.';
          }
          return null;
        },
      ),
    );
  }
}
