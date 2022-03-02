import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/country_and_job_model.dart';
import 'package:magnijobs_rnr/models/get_jobseeker_profile.dart';
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
      completion(countryAndJobModel);
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
  Candidate? candidate;

  void getJobSeekerProfile({required int id, completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    String url = ApiConstants.baseUrl + "jobseeker-profile/${id}";
    var client = APIClient(isCache: false, baseUrl: url);
    client
        .request(
            route: APIRoute(
              APIType.get_jobseeker_profile,
              body: {},
            ),
            create: () => GetJobSeekerProfile(),
            apiFunction: getJobSeekerProfile)
        .then((response) {
      if ((response.response?.status ?? false)) {
        candidate = response.response?.data?.candidate;
        if (candidate != null) {
          printWrapped(countryAndJobModel.toString());
          AppPopUps().dissmissDialog();
          completion(candidate);
        }
      }
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
