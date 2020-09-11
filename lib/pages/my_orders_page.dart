import 'package:flutter/material.dart';
import 'package:medico/blocs/my_orders_bloc.dart';
import 'package:medico/models/order.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/shop_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatelessWidget {
  static Widget create(
    BuildContext context,
    User user,
  ) {
    return Provider(
      create: (_) => MyOrderBloc(ShopUseCase(Provider.of<ApiClient>(context))),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<MyOrderBloc>(
        builder: (context, bloc, _) => MyOrders(
          bloc: bloc,
          user: user,
        ),
      ),
    );
  }

  final User user;
  final MyOrderBloc bloc;

  MyOrders({this.bloc, this.user});

  @override
  Widget build(BuildContext context) {
    bloc.getOrders(userId: user.uid);
    return StreamBuilder<bool>(
      stream: bloc.inAsyncCall,
      initialData: false,
      builder: (context, snapshot) {
        return ModalProgressHUD(
          inAsyncCall: snapshot.data,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: StreamBuilder<ServerModel<List<Order>>>(
              stream: bloc.ordersStream,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                final error = snapshot.data.getException;
                final result = snapshot.data.data;
                if (error != null)
                  return Center(child: Text(error.getErrorMessage()));
                if (result.isEmpty)
                  return Center(child: Text('No Orders has been placed yet'));
                return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, pos) => ListTile(
                    onTap: () {},
                    title: Text(
                      result[pos].mongoId,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
