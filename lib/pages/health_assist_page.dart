import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/pages/insurance_page.dart';
import 'package:medico/pages/order_success_page.dart';
import 'package:medico/pages/physiotherapy_speciality_page.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/health_assist_use_case.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

const titles = [
  'Home Healthcare',
  'Hospitalization Assistance',
  'Specialist',
  'Health Insurance claim assistance',
];

const subTitles = [
  'Physiotherapy',
  'Nurse',
  'Paramedic',
  'Aaya',
];

class HealthAssistPage extends StatelessWidget {
  final HealthAssistPageBloc bloc;
  final User user;

  HealthAssistPage({this.bloc, this.user});

  static Widget create(
    BuildContext context,
    User user,
  ) {
    return Provider(
      create: (_) => HealthAssistPageBloc(
          HealthAssistUseCase(Provider.of<ApiClient>(context))),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<HealthAssistPageBloc>(
        builder: (context, bloc, _) => HealthAssistPage(
          bloc: bloc,
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'Health Assist',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              body: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, pos) => pos == 0
                    ? ExpansionTile(
                        title: Text(titles[pos]),
                        children: subTitles
                            .map(
                              (e) => GestureDetector(
                                onTap: () => bloc.bookHealthAssist(
                                  type: e,
                                  userId: user.uid,
                                  onSuccess: (response) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OrderSuccessPage(response),
                                      ),
                                    );
                                  },
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    e,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : ListTile(
                        onTap: () {
                          if (pos == 1) {
                            // assistance
                          } else if (pos == 2) {
                            // specialist
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PhysiotherapySpecialistPage(
                                  bloc: bloc,
                                  user: user,
                                ),
                              ),
                            );
                          } else {
                            // insurance
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InsurancePage(
                                  bloc: bloc,
                                  user: user,
                                ),
                              ),
                            );
                          }
                        },
                        title: Text(
                          titles[pos],
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
