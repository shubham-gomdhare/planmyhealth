import 'package:flutter/material.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/models/treatment_medicine.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/util/server_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'detail_page.dart';
import 'order_success_page.dart';

class HospitalizationAssistancePage extends StatelessWidget {
  final HealthAssistPageBloc bloc;
  final User user;

  HospitalizationAssistancePage({this.bloc, this.user});

  @override
  Widget build(BuildContext context) {
    bloc.getHospitalizationAssistance();
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
                'Hospitalization Assistance',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            body: StreamBuilder<ServerModel<List<TreatmentMedicine>>>(
              stream: bloc.treatmentMedicineStream,
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
                    final healthAssist = result[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage([
                              'Name',
                              healthAssist.procedureName,
                              'Min Cost',
                              healthAssist.minCost,
                              'Max Cost',
                              healthAssist.maxCost,
                              'Duration',
                              healthAssist.duration,
                              'Provider Type Code',
                              healthAssist.providerTypeCode,
                              'Pre-Procedure Details',
                              healthAssist.preProcedureDetails,
                              'Post-Procedure Details',
                              healthAssist.postProcedureDetails,
                              'Speciality',
                              healthAssist.speciality,
                              'Status',
                              healthAssist.status,
                              'Test Details',
                              healthAssist.testDetails,
                              'Qualification Needed',
                              healthAssist.qualificationNeeded,
                            ], () {
                              bloc.bookHealthAssist(
                                type: 'Hospitalization Assistance',
                                userId: user.uid,
                                id: healthAssist.mongoId,
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
                        healthAssist.procedureName,
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
