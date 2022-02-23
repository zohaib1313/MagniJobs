import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/employer_model.dart';
import 'package:magnijobs_rnr/models/get_all_packges.dart';

import '../routes.dart';

class AllPackagesViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  registerUser({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    // Map<String, dynamic> body = {
    //   "first_name": firstnameContoller.text,
    //   "last_name": lastNameController.text,
    //   "email": emailController.text,
    //   "mobile": mobileController.text,
    //   "password": passwordController.text,
    //   "password_confirmation": confirmPasswordController.text,
    //   "utype": "Employer",
    //   "status": 0,
    //   "address": addressController.text,
    //   "location": locationController.text,
    //   "company_name": companyNameController.text,
    //   "contact_number": contactNumberController.text,
    //   "contact_email": contactEmailController.text,
    //   "marital_status": martialStatusController.text,
    // };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_packages,
              // body: body,
            ),
            create: () => GetAllPackges(),
            apiFunction: registerUser)
        .then((response) {
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
}
