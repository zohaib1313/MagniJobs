import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/country_and_job_model.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../routes.dart';

class CountryAndJobViewModel extends ChangeNotifier {
  CountryAndJobModel? countryAndJobModel;

  void getAllCandidates({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.all_candidates,
              body: body,
            ),
            create: () => APIResponse<CountryAndJobModel>(
                create: () => CountryAndJobModel()),
            apiFunction: getAllCandidates)
        .then((response) {
      countryAndJobModel = response.response!.data;
      printWrapped(countryAndJobModel.toString());
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

  void resetState() {}
}
