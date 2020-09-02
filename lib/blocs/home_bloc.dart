import 'dart:async';

import 'package:medico/models/doctors.dart';
import 'package:medico/services/doctor_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final DoctorUseCase doctorUseCase;
  HomeBloc(this.doctorUseCase);

  final StreamController<ServerModel<List<Doctor>>> _doctorsController =
      BehaviorSubject();

  void getDoctorsList() async {
    doctorUseCase
        .getDoctors()
        .then((serverModel) => _doctorsController.sink.add(serverModel))
        .catchError((serverModel) => _doctorsController.sink.add(serverModel));
  }

  Stream<ServerModel<List<Doctor>>> get doctorStream =>
      _doctorsController.stream;

  void dispose() {
    _doctorsController.close();
  }
}
