import 'package:flutter/material.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'order_success_page.dart';

const titles = [
  'Physiotherapy',
  'Nurse',
  'Paramedic',
  'Aaya',
];

class HomeHealthPage extends StatelessWidget {
  final HealthAssistPageBloc bloc;
  final User user;

  HomeHealthPage({this.bloc, this.user});

  @override
  Widget build(BuildContext context) {
    bloc.getInsurances();
    return StreamBuilder<bool>(
      stream: bloc.inAsyncCall,
      initialData: false,
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
                'Health at home',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15),
              shrinkWrap: true,
              primary: false,
              itemCount: titles.length,
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
                final String title = titles[index];
                return ListTile(
                  onTap: () {
                    bloc.bookHealthAssist(
                      type: title,
                      userId: user.uid,
                      onSuccess: (response) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderSuccessPage(response),
                          ),
                        );
                      },
                    );
                  },
                  title: Text(
                    title,
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
