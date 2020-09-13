import 'package:flutter/material.dart';
import 'package:medico/models/diagnostic.dart';

class TestsSelected extends StatelessWidget {
  final Diagnostic diagnolotic;
  final VoidCallback onRemovedFromCart;
  TestsSelected(this.diagnolotic, this.onRemovedFromCart);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${diagnolotic.name}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${diagnolotic.rate}',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.grey),
                  ),
                ],
              ),
              IconButton(
                onPressed: onRemovedFromCart,

                //icon: Icon(UiIcons.trash),
                icon: Icon(Icons.remove_circle_outline),
                color: Colors.red.withOpacity(0.8),
                iconSize: 30,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
          child: Center(
            child: Container(
              height: 1.0,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }
}
