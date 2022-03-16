import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';

import '../routes.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool _hidePassword1 = true;
  bool _hidePassword2 = true;

  bool get hidePassword1 => _hidePassword1;

  set hidePassword1(bool value) {
    _hidePassword1 = value;
    notifyListeners();
  }

  bool get hidePassword2 => _hidePassword2;

  set hidePassword2(bool value) {
    _hidePassword2 = value;
    notifyListeners();
  }

  void resetState() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
  }

  void resetPassword({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "otp": otpController.text,
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.forgotPassword,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: resetPassword)
        .then((response) {
      AppPopUps().dissmissDialog();
      //UserDefaults.saveUserSession(SignInModel());
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
}
