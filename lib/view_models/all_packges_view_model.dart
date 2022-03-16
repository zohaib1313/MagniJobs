import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/get_all_packges.dart';

import '../routes.dart';

class AllPackagesViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;
  PackagesModel? allPackages;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

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
