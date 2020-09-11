import 'package:flutter/material.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/models/insurance.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/util/server_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'order_success_page.dart';

class InsurancePage extends StatelessWidget {
  final HealthAssistPageBloc bloc;
  final User user;

  InsurancePage({this.bloc, this.user});

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
                  'Insurances',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              body: StreamBuilder<ServerModel<List<Insurance>>>(
                  stream: bloc.insurancesStream,
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return Center(child: CircularProgressIndicator());
                    final error = snapshot.data.getException;
                    final result = snapshot.data.data;
                    if (error != null) return Text(error.getErrorMessage());
                    return ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, pos) => ListTile(
                        onTap: () {
                          bloc.bookHealthAssist(
                            type: 'Insurance',
                            userId: user.uid,
                            id: result[pos].mongoId,
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
                          result[pos].insuranceCo,
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
