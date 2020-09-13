import 'package:flutter/cupertino.dart';
import 'package:medico/models/order.dart';
import 'package:medico/services/shop_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class MyAppointmentsBloc {
  final ShopUseCase useCase;
  MyAppointmentsBloc(this.useCase);

  final _inAsyncCallController = BehaviorSubject<bool>();
  final _appointmentsController = BehaviorSubject<ServerModel<List<Order>>>();

  void getAppointments({@required String userId}) async {
    _appointmentsController.add(
      await useCase.getDoctorAppointments(
        userId: userId,
      ),
    );
  }

  Stream<bool> get inAsyncCall => _inAsyncCallController.stream;
  Stream<ServerModel<List<Order>>> get appointmentsStream =>
      _appointmentsController.stream;

  void dispose() {
    _appointmentsController.close();
    _inAsyncCallController.close();
  }
}
