import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medico/blocs/health_assist_page_bloc.dart';
import 'package:medico/pages/hospitalization_assistance_page.dart';
import 'package:medico/pages/insurance_page.dart';
import 'package:medico/pages/order_success_page.dart';
import 'package:medico/pages/physiotherapy_speciality_page.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/health_assist_use_case.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

const titles = [
  'I want Hospitalization',
  'Find Me a Specialist',
  'Health Insurance claim',
  'I want health at home',
];

const icons = [
  Icons.local_hospital,
  Icons.people,
  Icons.healing,
  Icons.home,
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
              body: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, pos) => Card(
                      elevation: 5.0,
                      child: ListTile(
                        onTap: () {
                          if (pos == 0) {
                            // hospitalization
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HospitalizationAssistancePage(
                                  bloc: bloc,
                                  user: user,
                                ),
                              ),
                            );
                          } else if (pos == 1) {
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
                          } else if (pos == 2) {
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
                          } else {
                            // home health

                          }
                        },
                        leading: Icon(
                          icons[pos],
                          color: Theme.of(context).accentColor,
                        ),
                        title: Text(
                          titles[pos],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
