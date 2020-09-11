import 'package:flutter/cupertino.dart';
import 'package:medico/models/order.dart';
import 'package:medico/services/shop_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class MyOrderBloc {
  final ShopUseCase useCase;
  MyOrderBloc(this.useCase);

  final _inAsyncCallController = BehaviorSubject<bool>();
  final _ordersController = BehaviorSubject<ServerModel<List<Order>>>();

  void getOrders({@required String userId}) async {
    _ordersController.add(
      await useCase.getOrders(
        userId: userId,
      ),
    );
  }

  Stream<bool> get inAsyncCall => _inAsyncCallController.stream;
  Stream<ServerModel<List<Order>>> get ordersStream => _ordersController.stream;

  void dispose() {
    _ordersController.close();
    _inAsyncCallController.close();
  }
}
