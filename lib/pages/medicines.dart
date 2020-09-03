import 'package:flutter/material.dart';
import 'package:medico/blocs/shop_bloc.dart';
import 'package:medico/models/cart.dart';
import 'package:medico/models/medicines.dart';
import 'package:medico/pages/cart_page.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/shop_use_case.dart';
import 'package:medico/util/cart_model.dart';
import 'package:medico/util/server_model.dart';
import 'package:medico/widgets/medecinesWidget.dart';
import 'package:medico/widgets/searchWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';

class Medicines extends StatelessWidget {
  final ShopBloc bloc;
  final User user;
  Medicines(this.bloc, this.user);
  static Widget create(BuildContext context, User user) {
    return Provider(
      create: (_) => ShopBloc(ShopUseCase(Provider.of<ApiClient>(context))),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<ShopBloc>(
        builder: (context, bloc, _) => Medicines(bloc, user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.getCart(userId: user.uid);
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
                'Medicines',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 20,
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
                          child: SearchBarWidget(bloc.filterMedicines),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 12.0, right: 12.0, left: 12.0, bottom: 12.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Medecines :',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<bool>(
                    stream: bloc.isSearch,
                    initialData: false,
                    builder: (context, snapshot) {
                      if (snapshot.data) {
                        return StreamBuilder<ServerModel<List<Medicine>>>(
                          stream: bloc.medicineStream,
                          initialData: null,
                          builder: (context, snapshot) {
                            if (snapshot.data == null)
                              return Center(child: CircularProgressIndicator());
                            final medicineList = snapshot.data.data;
                            return Container(
                              padding: EdgeInsets.only(
                                  right: 12.0, left: 12.0, bottom: 12.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: medicineList.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 7,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return MedicinesWidget(
                                    medicineList.elementAt(index),
                                    () {
                                      bloc.addMedicineToCart(
                                        user.uid,
                                        medicineList.elementAt(index),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                      return PaginationView<ServerModel<List<Medicine>>>(
                        key: key,
                        itemBuilder: (BuildContext context,
                                ServerModel<List<Medicine>> snapshot,
                                int index) =>
                            Container(
                          padding: EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 12.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 7,
                              );
                            },
                            itemBuilder: (context, index) {
                              return MedicinesWidget(
                                snapshot.data.elementAt(index),
                                () {
                                  bloc.addMedicineToCart(
                                    user.uid,
                                    snapshot.data.elementAt(index),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        pageFetch: bloc.getMedicines,
                        onError: (dynamic error) => Center(
                          child: Text(error.getException.getErrorMessage()),
                        ),
                        onEmpty: Center(
                          child: Text('Sorry! This is empty'),
                        ),
                        bottomLoader: Center(
                          child: CircularProgressIndicator(),
                        ),
                        initialLoader: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.only(
                      right: 0.0, left: 30.0, bottom: 0.0, top: 0),
                  margin: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StreamBuilder<ServerModel<Cart>>(
                        stream: bloc.cartStream,
                        initialData: null,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              width: 0.0,
                              height: 0.0,
                            );
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                bloc,
                                user,
                                'Medicines',
                                'Add more medicines',
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Theme.of(context).accentColor,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 45.0, right: 45.0, top: 12, bottom: 12),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
