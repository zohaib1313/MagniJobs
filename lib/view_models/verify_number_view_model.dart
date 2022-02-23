import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/check_phone_no.dart';
import 'package:magnijobs_rnr/models/verify_my_number.dart';

import '../routes.dart';

class VerifyNumberViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController phonenumberController = TextEditingController();

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  checkmynumber({completion}) async {
    print("method is called");
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};

    String url =
        ApiConstants.baseUrl + "check-number/${phonenumberController.text}";

    var client = APIClient(isCache: false, baseUrl: url);
    client
        .request(
      route: APIRoute(
        APIType.check_my_phone_number,
        headers: {
          "token":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTI1MzM0N2Y2ODFmNTRlZTdhZDBkZjYzNmQxMmQzZmQ2ZjcwMTgwNDJiNjE5OTVlZGVhZjZkZWNjOWU3YzEzZjU1NGI5YzBjYmE5MDI1ZjkiLCJpYXQiOjE2NDQ4NTU0MjguMDA4NjA0LCJuYmYiOjE2NDQ4NTU0MjguMDA4NjA2LCJleHAiOjE2NjA0OTM4MjguMDAwNzc0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.mwSj2JzSnws9nmSXQssN8DeLOCash-HMMZVy4xc5BnkVM2R1XQfAi9s5eZ_bowcNEafrIpwZwvRnMDtydYtI_-VyyzBXeuK4Hlw4Mdq1H0Aiboe_8_qeEYKSUFAixpJfjwHUTGYmUG3nRvHqDlKV35IbuG2etbdJFn0XHcxwRcHPPQgwKsMSAt0ly3EKUojgeHGm0RkWb1zJ1ZeTYBHENsCmq3fG4p8IYr6cewK7iF7SdrnFAxxc2TcVPir3Jtzsn7VRNwZYKOmVr0G0HMtQLvfRwKqL_CD_W9jT7QgCFbXKOV719pVx8Ev5uRN7ficPXhjK-bGzlofvEAHJGt2XKWSXLGn3xeTrFZX2JnLn_flLZR4RXNpYeohFsSJbCDBn4i8PZC12FaIlR5TSt99VLL9lvFL6HwI39_z9wyfXFuZ-uV7b__nAxRboK3vGx2co9kLNgp2oIHhtS4WP4CJTVls42Z5zSgd0qlloVz6LIA0JQu9WdU7esXTqnbhX6I1_7cNNB2Jw93wj5f6aBm7HwnAVDyuJivF4Zp3I9S1tYN_Ex3KGT6hVXhkzUMrTul3VsacXig9CpuD8fUa_9AY_T5NgyNPgNK8PCZxvB76A3Mc-bCiDmPBKSuoOAoLyTvxIcO9aq_RO2yI6T5fQ87XBTGVZ-Rw0F7nbcUWF5qlsBco"
        },
        body: body,
      ),
      create: () =>
          APIResponse<CheckMyPhoneNumber>(create: () => CheckMyPhoneNumber()),
    )
        .then((response) {
      AppPopUps().dissmissDialog();
      resetState();
      completion();
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
      return Future.value(null);
    });
  }

  verifymynumber({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "first_name": phonenumberController.text,
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.verify_my_phone_number,
              body: body,
            ),
            create: () => VerifyMyPhoneNumber(),
            apiFunction: verifymynumber())
        .then((response) {
      AppPopUps().dissmissDialog();

      resetState();
      completion();
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
      return Future.value(null);
    });
  }

  resetState() {
    phonenumberController = TextEditingController();
  }
}
