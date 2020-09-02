import 'package:flutter/material.dart';

void showSnackBar({@required BuildContext context, @required String text}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
