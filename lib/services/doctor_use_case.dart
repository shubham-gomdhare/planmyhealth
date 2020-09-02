import 'package:flutter/cupertino.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/models/server_success.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/util/server_model.dart';

class DoctorUseCase {
  final ApiClient _apiClient;

  DoctorUseCase(this._apiClient);

  Future<ServerModel<List<Doctor>>> getDoctors() async {
    List<Doctor> response;
    try {
      response = await _apiClient.getDoctors();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }

  Future<ServerModel<ServerSuccess>> bookDoctor({
    @required String userId,
    @required String doctorId,
    @required int bookedAt,
  }) async {
    ServerSuccess response;
    try {
      response = await _apiClient.bookDoctor(userId, doctorId, bookedAt);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }
}
