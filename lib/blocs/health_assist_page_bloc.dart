import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medico/models/physiotherapy_speciality.dart';
import 'package:medico/services/health_assist_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class HealthAssistPageBloc {
  final HealthAssistUseCase useCase;

  HealthAssistPageBloc(this.useCase);

  final _inAsyncCallController = BehaviorSubject<bool>();
  final _physiotherapySpecialitiesController =
      BehaviorSubject<ServerModel<List<PhysiotherapySpeciality>>>();

  void bookHealthAssist(
      {@required String type,
      @required String userId,
      String id = "",
      @required Function(String) onSuccess}) async {
    _inAsyncCallController.add(true);

    final result =
        await useCase.bookHealthAssist(userId: userId, type: type, id: id);

    onSuccess(result.data.message);

    _inAsyncCallController.add(false);
  }

  void getSpecialist() async {
    _physiotherapySpecialitiesController
        .add(await useCase.getPhysiotherapySpecialities());
  }

  Stream<bool> get inAsyncCall => _inAsyncCallController.stream;
  Stream<ServerModel<List<PhysiotherapySpeciality>>>
      get physiotherapySpecialitiesStream =>
          _physiotherapySpecialitiesController.stream;

  void dispose() {
    _physiotherapySpecialitiesController.close();
    _inAsyncCallController.close();
  }
}
