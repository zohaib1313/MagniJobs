import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/signin_model.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';

import '../routes.dart';

class SignInViewModel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _hidePassword = true;

  bool get hidePassword => _hidePassword;

  set hidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  signInCandidateUser(String type, {completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "email": userNameController.text,
      "password": userPasswordController.text,
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.loginUser,
              body: body,
            ),
            create: () => APIResponse<CandidateSignInModel>(
                create: () => CandidateSignInModel()),
            apiFunction: signInCandidateUser)
        .then((response) {
      AppPopUps().dissmissDialog();

      if (response.response?.data?.token != null) {
        UserDefaults.setApiToken(response.response?.data?.token ?? '');
        completion(response.response?.data);
      }
    }).catchError((error) {
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

  signInEmployerUser(String type, {completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "email": userNameController.text,
      "password": userPasswordController.text,
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.loginUser,
              body: body,
            ),
            create: () => APIResponse<EmployerSignInModel>(
                create: () => EmployerSignInModel()),
            apiFunction: signInEmployerUser)
        .then((response) {
      AppPopUps().dissmissDialog();

      if (response.response?.data?.token != null) {
        UserDefaults.setApiToken(response.response?.data?.token ?? '');
        completion(response.response?.data);
      }
    }).catchError((error) {
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

  signInTutorUser(String type, {completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "email": userNameController.text,
      "password": userPasswordController.text,
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.loginUser,
              body: body,
            ),
            create: () =>
                APIResponse<TutorSignInModel>(create: () => TutorSignInModel()),
            apiFunction: signInTutorUser)
        .then((response) {
      AppPopUps().dissmissDialog();

      if (response.response?.data?.token != null) {
        UserDefaults.setApiToken(response.response?.data?.token ?? '');
        completion(response.response?.data);
      }
    }).catchError((error) {
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
    userNameController.clear();
    userPasswordController.clear();
  }

  void sendForgotPassword({completion, required String mail}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {"email": mail};

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.sendMailForgotPassword,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: sendForgotPassword)
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
