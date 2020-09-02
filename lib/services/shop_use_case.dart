import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:medico/models/cart.dart';
import 'package:medico/models/diagnolotic.dart';
import 'package:medico/models/medicines.dart';
import 'package:medico/models/server_success.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/util/server_model.dart';

class ShopUseCase {
  final ApiClient apiService;
  ShopUseCase(this.apiService);

  Future<ServerModel<List<Medicine>>> getMedicines() async {
    List<Medicine> response;
    try {
      response = await apiService.getMedicines();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<List<Diagnolotic>>> getDiagnolotics() async {
    List<Diagnolotic> response;
    try {
      response = await apiService.getDiagnolotics();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<Cart>> getCart({@required String userId}) async {
    Cart response;
    try {
      response = await apiService.getCart(userId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<ServerSuccess>> addToCart(
      {@required PostCart postCart}) async {
    ServerSuccess response;
    try {
      response = await apiService.addToCart(postCart);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<ServerSuccess>> removeFromCart(
      {@required String userId, @required String itemId}) async {
    ServerSuccess response;
    try {
      response = await apiService.removeFromCart(userId, itemId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<ServerSuccess>> checkout(
      {@required String userId, @required File imageFIle}) async {
    ServerSuccess response;
    try {
      response = await apiService.checkout(userId, imageFIle);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }
}
