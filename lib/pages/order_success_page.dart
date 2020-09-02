import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  final String message;
  OrderSuccessPage(this.message);

  @override
  Widget build(BuildContext context) {
    pop(context);
    return Scaffold(
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  void pop(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }
}
