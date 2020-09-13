import 'package:flutter/material.dart';
import 'package:medico/blocs/profile_bloc.dart';
import 'package:medico/models/member.dart';
import 'package:medico/pages/detail_page.dart';
import 'package:medico/pages/my_appointments_page.dart';
import 'package:medico/pages/my_orders_page.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/member_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatelessWidget {
  final User user;
  final ProfileBloc bloc;
  AccountWidget(this.user, this.bloc);

  static Widget create(BuildContext context, User user) {
    return Provider(
      create: (_) =>
          ProfileBloc(MemberUserCase(Provider.of<ApiClient>(context))),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<ProfileBloc>(
        builder: (context, bloc, _) => AccountWidget(
          user,
          bloc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.getMemberDetail(
        mobileNumber: user.phoneNumber.substring(3), email: user.email);
    return StreamBuilder<ServerModel<Member>>(
        stream: bloc.memberStream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          final member = snapshot.data.data;
          final error = snapshot.data.getException;
          if (error != null)
            return Center(
              child: Text(error.getErrorMessage()),
            );
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 280.0,
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.only(top: 40.0, left: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.perm_identity,
                            size: 25, color: Theme.of(context).primaryColor),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ball("images/doctor-2.jpg", Colors.transparent),
                            Column(
                              children: <Widget>[
                                Text(
                                  "${member.name}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${member.mobile}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "25%",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  width: 70,
                                  height: 4,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.indigo,
                                    ),
                                    height: 4,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailPage([
                                        'Name',
                                        member.name,
                                        'Email',
                                        member.email,
                                        'Gender',
                                        member.gender,
                                        'Age',
                                        member.age.toString(),
                                        'PhoneNumber',
                                        member.mobile.toString(),
                                        'Relation',
                                        member.relation,
                                      ], null),
                                    ),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'My Profile',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.settings,
                            size: 25.0,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.2)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: <Widget>[
                      _dropDownList(
                          Icon(
                            Icons.bubble_chart,
                            color: Theme.of(context).accentColor,
                          ),
                          'My Doctors',
                          1,
                          '/mydoctors',
                          context),
                      _dropDownList(
                        Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).accentColor,
                        ),
                        'My Orders',
                        1,
                        null,
                        context,
                      ),
                      _dropDownList(
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).accentColor,
                          ),
                          'Appointments',
                          1,
                          '/appointment',
                          context),
                      _dropDownList(
                          Icon(
                            Icons.card_giftcard,
                            color: Theme.of(context).accentColor,
                          ),
                          'Health Interest',
                          1,
                          '/health',
                          context),
                      _dropDownList(
                          Icon(
                            Icons.payment,
                            color: Theme.of(context).accentColor,
                          ),
                          'My Payments',
                          1,
                          '',
                          context),
                      _dropDownList(
                          Icon(
                            Icons.local_offer,
                            color: Theme.of(context).accentColor,
                          ),
                          'Offers',
                          1,
                          '/offers',
                          context),
                      _dropDownList(
                          Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).accentColor,
                          ),
                          'Logout',
                          0,
                          '/logout',
                          context),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }

  Widget _dropDownList(Icon icon, String title, double borderWidth,
      String route, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: borderWidth, color: Colors.grey.withOpacity(0.2))),
      ),
      child: FlatButton(
        onPressed: () {
          if (route == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyOrders.create(context, user),
              ),
            );
          } else if (route == '/logout') {
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure to logout from this device'),
                actions: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<AuthBase>(context, listen: false).signOut();
                      Navigator.pop(context);
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          } else if (route == '/appointment') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyAppointmentsPage.create(context, user),
              ),
            );
          } else {
            Navigator.of(context).pushNamed(route);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 25.0),
                  child: icon,
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ball(String image, Color color) {
    return Container(
      height: 70,
      width: 70.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
