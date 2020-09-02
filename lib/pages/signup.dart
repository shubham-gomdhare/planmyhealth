import 'package:flutter/material.dart';
import 'package:medico/blocs/sign_in_bloc.dart';
import 'package:medico/models/user.dart';
import 'package:medico/pages/phoneNumber_login.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/widgets/common_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (context) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignUp(bloc: bloc),
      ),
    );
  }

  final SignInBloc bloc;
  SignUp({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: bloc.inAsyncCallStream,
      builder: (context, snapshot) => ModalProgressHUD(
        inAsyncCall: snapshot.data,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0)),
                  image: DecorationImage(
                    image: AssetImage('images/image-home.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0, right: 50.0, left: 50.0),
                height: 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.10),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                ),
                child: RaisedButton(
                  elevation: 0.2,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PhoneLogin(bloc: bloc),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('images/cellphone-line.png'),
                          ),
                          Text(
                            ' Phone Number',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).focusColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 20)
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 0.2,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      bloc.signWithFacebook(
                        onLoginSuccess: () {
                          Navigator.popUntil(context, ModalRoute.withName("/"));
                        },
                        onLoginFailure: (errMsg) {
                          showSnackBar(
                            context: context,
                            text: errMsg,
                          );
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/facebook-fill.png'),
                            ),
                            Text(
                              ' Facebook',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).focusColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 0.2,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      bloc.signWithGoogle(
                        onLoginSuccess: () {
                          Navigator.popUntil(context, ModalRoute.withName("/"));
                        },
                        onLoginFailure: (errMsg) {
                          showSnackBar(
                            context: context,
                            text: errMsg,
                          );
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/google-fill.png'),
                            ),
                            Text(
                              ' Google',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).focusColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    "By continuing, you agree to Terms & Conditions",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              /*Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Container(
                    height: 40.0,width: 70.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent.withOpacity(0.10), offset: Offset(0,4), blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(80.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                      color: Colors.transparent.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}
