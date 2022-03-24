import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/get_all_packges.dart';

import '../routes.dart';

class AllPackagesAndPaymentViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  Packages? selectedPaymentMethod;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController nameUsedOnCardController = TextEditingController();

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  bool get rememberMe => _rememberMe;
  PackagesModel? allPackages;

  getAllPackages({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_packages,
              // body: body,
            ),
            create: () =>
                APIResponse<PackagesModel>(create: () => PackagesModel()),
            apiFunction: getAllPackages)
        .then((response) {
      allPackages = response.response!.data;
      selectedPaymentMethod = allPackages?.packages?[0];
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

  void resetState() {
    cardNumberController.clear();
    dueDateController.clear();
    nameUsedOnCardController.clear();
  }

  ///todo  ///in progress
  void subscribeToPlan({completion}) {
    var body = {
      "expires_on": "2022-04-20",
      "employer": "Oral Kings",
      "package_id": "2",
      "amount": "144",
      "pay_method": "Stripe",
      "payment_reference": "py_97438564756",
      "notes": ""
    };
    AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.subScribeToPlan,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: subscribeToPlan)
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
