import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/check_phone_no.dart';
import 'package:magnijobs_rnr/models/verify_my_number.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../routes.dart';

class VerifyNumberViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool isVerificationSent = false;
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  bool timeEnd = false;
  setTimeEnd(bool value) {
    timeEnd = value;
    notifyListeners();
  }

  setIsVerificationSent(bool value) {
    isVerificationSent = value;
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  checkMyNumber({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};

    String url =
        ApiConstants.baseUrl + "check-number/${phonenumberController.text}";

    var client = APIClient(isCache: false, baseUrl: url);
    client
        .request(
            route: APIRoute(
              APIType.check_my_phone_number,
              body: body,
            ),
            create: () => APIResponse<User>(create: () => User()),
            apiFunction: checkMyNumber)
        .then((response) {
      printWrapped(response.response!.data.toString());
      AppPopUps().dissmissDialog();
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

  verifyMyNumber({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "otp": otpCodeController.text,
      "mobile": phonenumberController.text
    };
    var client = APIClient(
        isCache: false,
        baseUrl: ApiConstants.baseUrl,
        contentType: 'application/x-www-form-urlencoded');
    client
        .request(
            route: APIRoute(APIType.verify_my_phone_number, body: body),
            create: () => VerifyMyPhoneNumberModel(),
            apiFunction: verifyMyNumber)
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
    phonenumberController.clear();
    isVerificationSent = false;
    otpCodeController.clear();
  }
}
