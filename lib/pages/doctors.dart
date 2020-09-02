import 'package:flutter/material.dart';
import 'package:medico/blocs/doctors.bloc.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/services/auth.dart';
import 'package:medico/services/doctor_use_case.dart';
import 'package:medico/widgets/doctorsWidget.dart';
import 'package:medico/widgets/searchWidget.dart';
import 'package:provider/provider.dart';

class DoctorsList extends StatelessWidget {
  final DoctorBloc bloc;
  final User user;
  DoctorsList(this.bloc, this.user);

  static Widget create(
      List<Doctor> doctorsList, User user, DoctorUseCase doctorUseCase) {
    return Provider<DoctorBloc>(
      create: (_) => DoctorBloc(doctorsList, doctorUseCase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<DoctorBloc>(
        builder: (context, bloc, _) {
          return DoctorsList(bloc, user);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Doctors',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 20,
                  padding:
                      const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 0.0, left: 12.0, right: 12.0),
                  child: SearchBarWidget(bloc.filterDoctors),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: StreamBuilder<List<Doctor>>(
                stream: bloc.filterStream,
                builder: (context, snapshot) {
                  final doctorsList = snapshot.data;
                  if (doctorsList == null || doctorsList.isEmpty) {
                    return Center(
                      child: Text('No Doctors found.'),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: doctorsList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 4.0);
                    },
                    itemBuilder: (context, index) {
                      return DoctorsCardWidget(
                        doctor: doctorsList[index],
                        bloc: bloc,
                        user: user,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
