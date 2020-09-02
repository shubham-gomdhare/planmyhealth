import 'package:flutter/material.dart';
import 'package:medico/blocs/shop_bloc.dart';
import 'package:medico/models/cart.dart';
import 'package:medico/pages/prescription_upload_page.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/util/cart_model.dart';
import 'package:medico/util/server_model.dart';
import 'package:medico/widgets/medecinesSlected.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatelessWidget {
  final ShopBloc bloc;
  final User user;
  final String toolbarTitle;
  final String buttonTitle;
  CartPage(
    this.bloc,
    this.user,
    this.toolbarTitle,
    this.buttonTitle,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: bloc.inAsyncCall,
      builder: (context, snapshot) {
        return ModalProgressHUD(
          inAsyncCall: snapshot.data,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                toolbarTitle,
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 12.0, right: 12.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 12.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: StreamBuilder<ServerModel<Cart>>(
                            stream: bloc.cartStream,
                            initialData: null,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return CircularProgressIndicator();
                              }
                              final cartModel = CartModel.extractDataFromCart(
                                  snapshot.data.data);
                              return cartModel.quantity == 0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: Center(
                                        child: Text(
                                          'No medicines has been added to cart.',
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: <Widget>[
                                        ListView.separated(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: cartModel.quantity,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 7,
                                            );
                                          },
                                          itemBuilder: (context, index) {
                                            return CartList(
                                              cartModel.cartItems[index],
                                              () {
                                                bloc.removeItemFromCart(
                                                  user.uid,
                                                  cartModel.cartItems[index].id,
                                                  cartModel
                                                      .cartItems[index].type,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 12.0, right: 17.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Total',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '₹ ${cartModel.price}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16.0,
                                                  color: Colors.grey,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          right: 0.0, left: 0.0, bottom: 0.0, top: 0),
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 1, color: Colors.grey.withOpacity(0.6)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Colors.transparent,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 45.0, right: 45.0, top: 12, bottom: 12),
                              child: Text(
                                '+ $buttonTitle',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    color: Theme.of(context).focusColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(
                    right: 0.0, left: 40.0, bottom: 0.0, top: 0),
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border:
                      Border.all(width: 1, color: Colors.grey.withOpacity(0.6)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StreamBuilder<ServerModel<Cart>>(
                      stream: bloc.cartStream,
                      initialData: null,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        }
                        final cartModel =
                            CartModel.extractDataFromCart(snapshot.data.data);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              snapshot.data.data == null
                                  ? '0 items added'
                                  : '${cartModel.quantity} items added',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Colors.grey),
                            ),
                            Text(
                              snapshot.data.data == null
                                  ? '₹ 0'
                                  : '₹ ${cartModel.price}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                    RaisedButton(
                      elevation: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        if (toolbarTitle == 'Tests') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PrescriptionUploadPage(
                                bloc: bloc,
                                user: user,
                              ),
                            ),
                          );
                        } else {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Theme.of(context).accentColor,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 35.0, right: 35.0, top: 12, bottom: 12),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
