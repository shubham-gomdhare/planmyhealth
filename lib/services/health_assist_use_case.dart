import 'package:flutter/foundation.dart';
import 'package:medico/models/insurance.dart';
import 'package:medico/models/physiotherapy_speciality.dart';
import 'package:medico/models/server_success.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/util/server_model.dart';

class HealthAssistUseCase {
  final ApiClient _apiClient;

  HealthAssistUseCase(this._apiClient);

  Future<ServerModel<ServerSuccess>> bookHealthAssist({
    @required String userId,
    String id,
    @required String type,
  }) async {
    ServerSuccess response;
    try {
      response = await _apiClient.bookHealthAssist(userId, id, type);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<List<PhysiotherapySpeciality>>>
      getPhysiotherapySpecialities() async {
    List<PhysiotherapySpeciality> response;
    try {
      response = await _apiClient.getPhysiotherapySpecialities();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<List<Insurance>>> getInsurances() async {
    List<Insurance> response;
    try {
      response = await _apiClient.getInsurances();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }
}
