import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medico/blocs/my_orders_bloc.dart';
import 'package:medico/models/order.dart';
import 'package:medico/pages/detail_page.dart';
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
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: result.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5.0,
                      child: Center(
                        child: Container(
                          height: 1.0,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final order = result[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              [
                                'OrderId',
                                order.mongoId,
                                'Name',
                                order.name,
                                'Price',
                                order.price.toString(),
                                'Order on',
                                DateFormat('dd-MM-yy on hh:mm a').format(
                                  order.createdAt.add(
                                    Duration(
                                      hours: 5,
                                      minutes: 30,
                                    ),
                                  ),
                                ),
                                'Order Type',
                                order.type,
                              ],
                              null,
                            ),
                          ),
                        );
                      },
                      leading: Icon(Icons.calendar_today),
                      title: Text('Order Id : ${order.mongoId}'),
                      subtitle: Text(
                        'Order placed at ${DateFormat('dd-MM-yy on hh:mm a').format(
                          order.createdAt.add(
                            Duration(
                              hours: 5,
                              minutes: 30,
                            ),
                          ),
                        )}',
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
