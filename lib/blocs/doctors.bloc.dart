import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/models/server_success.dart';
import 'package:medico/services/doctor_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class DoctorBloc {
  List<Doctor> doctorsList;
  DoctorUseCase doctorUseCase;

  final _now = DateTime.now();
  DateTime _currSelectedDay;
  DateTime _bookingDateTime;

  final StreamController<List<Doctor>> _filterStreamController =
      StreamController();

  final StreamController<String> _dateStreamController = BehaviorSubject();
  final StreamController<String> _timeStreamController = BehaviorSubject();

  final _inAsyncCallController = BehaviorSubject<bool>();

  DoctorBloc(
    List<Doctor> doctorsList,
    DoctorUseCase doctorUseCase,
  ) {
    this.doctorsList = doctorsList;
    this.doctorUseCase = doctorUseCase;
    _filterStreamController.sink.add(doctorsList);
    _currSelectedDay = _now.add(Duration(days: 1));
    _dateStreamController.sink
        .add('Tomorrow, ${DateFormat('MMM d').format(_currSelectedDay)}');
    _bookingDateTime = DateTime(_now.year, _now.month, _now.day + 1);
  }

  void filterDoctors(String doctorName) {
    final List<Doctor> filteredDoctors = [];
    doctorsList.forEach((doctor) {
      if (doctor.name.toLowerCase().contains(doctorName.toLowerCase())) {
        filteredDoctors.add(doctor);
      }
    });

    if (doctorName.isEmpty) {
      _filterStreamController.sink.add(doctorsList);
    } else {
      _filterStreamController.sink.add(filteredDoctors);
    }
  }

  void changeDate(bool isIncreasing) {
    String dateToShow;
    bool canChange = true;
    DateFormat dateFormat = DateFormat('EEE, MMM d');
    if (isIncreasing) {
      final nextDay = _currSelectedDay.add(Duration(days: 1));
      dateToShow = dateFormat.format(nextDay);
      _currSelectedDay = nextDay;
      _bookingDateTime = _bookingDateTime.add(Duration(days: 1));
    } else {
      final prevDay = _currSelectedDay.add(Duration(days: -1));
      if (prevDay.day == _now.day &&
          prevDay.month == _now.month &&
          prevDay.year == _now.year) {
        canChange = false;
      } else if (prevDay == _now.add(Duration(days: 1))) {
        // tomorrow
        dateToShow = 'Tomorrow, ${DateFormat('MMM d').format(prevDay)}';
        _currSelectedDay = prevDay;
        _bookingDateTime = _bookingDateTime.add(Duration(days: -1));
      } else {
        dateToShow = dateFormat.format(prevDay);
        _currSelectedDay = prevDay;
        _bookingDateTime = _bookingDateTime.add(Duration(days: -1));
      }
    }

    if (canChange) {
      _dateStreamController.sink.add(dateToShow);
    }
  }

  void selectTime(String time) {
    _timeStreamController.sink.add(time);
    int hour = int.parse(time.substring(0, 2));
    _bookingDateTime = DateTime(_bookingDateTime.year, _bookingDateTime.month,
        _bookingDateTime.day, hour);
  }

  void bookDoctor(
      {@required String userId,
      @required String doctorId,
      @required Function(String) onCheckoutCompleted}) async {
    _inAsyncCallController.add(true);

    print(_bookingDateTime.millisecondsSinceEpoch);
    ServerModel<ServerSuccess> serverModel = await doctorUseCase.bookDoctor(
      userId: userId,
      doctorId: doctorId,
      bookedAt: _bookingDateTime.millisecondsSinceEpoch,
    );
    _inAsyncCallController.add(false);
    onCheckoutCompleted(serverModel.data.message);
  }

  Stream<List<Doctor>> get filterStream => _filterStreamController.stream;
  Stream<String> get dateStream => _dateStreamController.stream;
  Stream<String> get timeStream => _timeStreamController.stream;
  Stream<bool> get inAsyncCall => _inAsyncCallController.stream;
  DateTime get bookedDateTime => _bookingDateTime;

  void dispose() {
    _filterStreamController.close();
    _dateStreamController.close();
    _timeStreamController.close();
    _inAsyncCallController.close();
  }
}
