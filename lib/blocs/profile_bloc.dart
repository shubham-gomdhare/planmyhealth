import 'package:flutter/cupertino.dart';
import 'package:medico/models/member.dart';
import 'package:medico/services/member_use_case.dart';
import 'package:medico/util/server_model.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final MemberUserCase useCase;
  ProfileBloc(this.useCase);

  final _inAsyncCallController = BehaviorSubject<bool>();
  final _memberController = BehaviorSubject<ServerModel<Member>>();

  void getMemberDetail(
      {@required String mobileNumber, @required String email}) async {
    _memberController.add(
      await useCase.getMemberDetail(
        mobileNumber: mobileNumber,
        email: email,
      ),
    );
  }

  Stream<bool> get inAsyncCall => _inAsyncCallController.stream;
  Stream<ServerModel<Member>> get memberStream => _memberController.stream;

  void dispose() {
    _memberController.close();
    _inAsyncCallController.close();
  }
}
