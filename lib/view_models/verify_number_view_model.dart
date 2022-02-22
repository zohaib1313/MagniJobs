import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/employer_model.dart';
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
    Map<String, dynamic> body = {
      "first_name": phonenumberController.text,
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
      route: APIRoute(APIType.check_my_phone_number,
          routeParams: phonenumberController.text
          //  body: body,
          ),
      create: () => CheckMyPhoneNumber(),
    )
        //     apiFunction: checkmynumber())
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
            apiFunction: checkmynumber())
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
