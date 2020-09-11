import 'package:flutter/cupertino.dart';
import 'package:medico/services/health_assist_use_case.dart';
import 'package:rxdart/rxdart.dart';

class HealthAssistPageBloc {
  final HealthAssistUseCase useCase;

  HealthAssistPageBloc(this.useCase);

  final _inAsyncCallController = BehaviorSubject<bool>();

  void bookHomeHealthCare(
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

  Stream get inAsyncCall => _inAsyncCallController.stream;

  void dispose() {
    _inAsyncCallController.close();
  }
}
