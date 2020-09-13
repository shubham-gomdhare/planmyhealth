import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medico/blocs/my_appointments_bloc.dart';
import 'package:medico/models/order.dart';
import 'package:medico/pages/detail_page.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/shop_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyAppointmentsPage extends StatelessWidget {
  static Widget create(
    BuildContext context,
    User user,
  ) {
    return Provider(
      create: (_) =>
          MyAppointmentsBloc(ShopUseCase(Provider.of<ApiClient>(context))),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<MyAppointmentsBloc>(
        builder: (context, bloc, _) => MyAppointmentsPage(
          bloc: bloc,
          user: user,
        ),
      ),
    );
  }

  final User user;
  final MyAppointmentsBloc bloc;

  MyAppointmentsPage({this.bloc, this.user});

  @override
  Widget build(BuildContext context) {
    bloc.getAppointments(userId: user.uid);
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
                'My Appointments',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: StreamBuilder<ServerModel<List<Order>>>(
              stream: bloc.appointmentsStream,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                final error = snapshot.data.getException;
                final result = snapshot.data.data;
                if (error != null)
                  return Center(child: Text(error.getErrorMessage()));
                if (result.isEmpty)
                  return Center(
                      child: Text('No appointments has been placed yet'));
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
                                'BookingId',
                                order.mongoId,
                                'Doctor Name',
                                order.name,
                                'Price',
                                order.price.toString(),
                                'Appointment Date',
                                DateFormat('dd-MM-yy on hh:mm a').format(
                                  order.bookedAt.add(
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
                      leading: Icon(
                        Icons.perm_contact_calendar,
                        color: Theme.of(context).accentColor,
                      ),
                      title: Text('BookingId : ${order.mongoId}'),
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
