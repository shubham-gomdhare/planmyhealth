import 'package:flutter/material.dart';
import 'package:medico/util/cart_model.dart';

class CartList extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onItemRemovedFromCart;
  CartList(this.cartItem, this.onItemRemovedFromCart);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${cartItem.name}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Theme.of(context).focusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹ ${cartItem.price}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onItemRemovedFromCart,
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
