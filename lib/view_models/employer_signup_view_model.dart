import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/employer_model.dart';

import '../routes.dart';

class EmployerSignUpViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstnameContoller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
  bool _hidePassword = true;

  bool termsConditionAccepted = false;

  bool get hidePassword => _hidePassword;

  set hidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  bool _hidePassword2 = true;

  bool get hidePassword2 => _hidePassword2;

  set hidePassword2(bool value) {
    _hidePassword2 = value;
    notifyListeners();
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  registerUser({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "first_name": firstnameContoller.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "utype": "Employer",
      "status": 0,
      "address": addressController.text,
      "location": locationController.text,
      //"location": 5,

      "company_name": companyNameController.text,
      "contact_number": contactNumberController.text,
      "contact_email": contactEmailController.text,
      "marital_status": 'Male',
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.register_new_employer,
              body: body,
            ),
            create: () => APIResponse<EmployerSignUpModel>(
                create: () => EmployerSignUpModel()),
            apiFunction: registerUser)
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
    formKey = GlobalKey<FormState>();
    firstnameContoller.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
    locationController.clear();
    companyNameController.clear();
    contactNumberController.clear();
    contactEmailController.clear();
    martialStatusController.clear();
    webSiteController.clear();
  }
}
