import 'package:flutter/foundation.dart';
import 'package:medico/models/member.dart';
import 'package:medico/services/api_client.dart';
import 'package:medico/util/server_model.dart';

class MemberUserCase {
  final ApiClient apiService;
  MemberUserCase(this.apiService);

  Future<ServerModel<Member>> getMemberDetail(
      {@required String email, @required String mobileNumber}) async {
    Member response;
    try {
      response = await apiService.getMemberDetail(mobileNumber, email);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ServerModel()..setException(ServerError.withError(error: error));
    }
    return ServerModel()..data = response;
  }
}
