import 'package:flutter/material.dart';
import 'package:medico/pages/getStarted.dart';
import 'package:medico/pages/on_boarding.dart';
import 'package:medico/services/auth.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: Provider.of<AuthBase>(context).onAuthStateChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data == null) {
            return Scaffold(
              body: PageView(
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GetStarted(),
                  OnBoardingWidget(),
                ],
              ),
            );
          } else {
            return Home.create(context, snapshot.data);
          }
        }
      },
    );
  }
}
