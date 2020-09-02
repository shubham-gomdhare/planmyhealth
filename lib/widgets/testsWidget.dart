import 'package:flutter/material.dart';
import 'package:medico/models/diagnolotic.dart';

class Tests extends StatelessWidget {
  final Diagnolotic diagnolotic;
  final VoidCallback onAddedToCart;
  Tests(this.diagnolotic, this.onAddedToCart);
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
                onPressed: onAddedToCart,
                icon: Icon(Icons.add_circle_outline),
                color: Theme.of(context).accentColor.withOpacity(0.8),
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
