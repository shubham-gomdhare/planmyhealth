import 'package:flutter/material.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/models/insurance.dart';
import 'package:medico/pages/detail_page.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/util/server_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'order_success_page.dart';

class InsuranceClaimPage extends StatelessWidget {
  final HealthAssistPageBloc bloc;
  final User user;

  InsuranceClaimPage({this.bloc, this.user});

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
                'Insurance Claim',
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
                    final insuranceCompany = result[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage([
                              'Name',
                              insuranceCompany.insuranceCo,
                              'Insurance Code',
                              insuranceCompany.insCode,
                              'Insurance Type',
                              insuranceCompany.insType,
                              'Address',
                              insuranceCompany.address1,
                            ], () {
                              bloc.bookHealthAssist(
                                type: 'Insurance',
                                userId: user.uid,
                                id: result[index].mongoId,
                                onSuccess: (response) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          OrderSuccessPage(response),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        );
                      },
                      title: Text(
                        insuranceCompany.insuranceCo,
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
