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
  List<Candidates> _allCandidatesList = [];
  List<Candidates> showingListOfCandidates = [];

  TextEditingController searchTextController = TextEditingController();

  void getAllCandidates({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      /*    'country': Provider.of<CompanyProfileViewModel>(myContext!, listen: false)
          .selectedCountryId*/
      'country': '4'
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.candidateByCountry,
              body: body,
            ),
            create: () => APIResponse<CountryAndJobModel>(
                create: () => CountryAndJobModel()),
            apiFunction: getAllCandidates)
        .then((response) {
      _allCandidatesList = response.response?.data?.candidates ?? [];
      showingListOfCandidates.addAll(_allCandidatesList);

      printWrapped(_allCandidatesList.length.toString());
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

  void resetState() {
    searchTextController.clear();
  }

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

  void searchFromList() {
    printWrapped(_allCandidatesList.length.toString());
    if (searchTextController.text.isEmpty) {
      printWrapped("empty");
      showingListOfCandidates.clear();
      showingListOfCandidates.addAll(_allCandidatesList);
    } else {
      printWrapped(searchTextController.text);
      showingListOfCandidates.clear();

      String text = searchTextController.text;
      for (var candidate in _allCandidatesList) {
        if ((candidate.firstName?.toLowerCase() ?? '')
                .contains(text.toLowerCase()) ||
            (candidate.lastName?.toLowerCase() ?? '')
                .contains(text.toLowerCase())) {
          showingListOfCandidates.add(candidate);
        }
      }
    }
    notifyListeners();
  }
}
