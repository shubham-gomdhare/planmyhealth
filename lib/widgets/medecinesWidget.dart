import 'package:flutter/material.dart';
import 'package:medico/models/medicines.dart';
import 'package:medico/pages/detail_page.dart';

class MedicinesWidget extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onAddedToCart;
  MedicinesWidget(this.medicine, this.onAddedToCart);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  [
                    'Name',
                    medicine.drugName,
                    'Price',
                    medicine.price.toString(),
                    'Description',
                    medicine.introduction,
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${medicine.drugName}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '₹${medicine.price}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                    ],
                  ),
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
