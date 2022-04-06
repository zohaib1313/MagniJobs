import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/country_and_job_model.dart';
import 'package:magnijobs_rnr/models/get_jobseeker_profile.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/job_sub_type_model.dart';
import '../models/job_type_model.dart';
import '../routes.dart';
import 'company_profile_view_model.dart';

class CountryAndJobViewModel extends ChangeNotifier {
  List<Candidates> _allCandidatesList = [];
  List<Candidates> showingListOfCandidates = [];

  TextEditingController searchTextController = TextEditingController();

  List<Jobtypes?> jobTypeList = [];

  bool isVerifiedFiltered = true;
  bool isSortFiltered = false;

  TextEditingController filterLocation = TextEditingController();

  Jobtypes? selectedJobType;

  Jobsubtypes? selectedJobSubType;

  void filterJobsOnSort() {
    AppPopUps().showProgressDialog(context: myContext);

    showingListOfCandidates.sort((a, b) {
      String aName = a.firstName ?? '';
      String bName = b.firstName ?? '';

      return isSortFiltered ? aName.compareTo(bName) : bName.compareTo(aName);
    });
    isSortFiltered = !isSortFiltered;
    AppPopUps().dissmissDialog();

    notifyListeners();
  }

  void filterOnLocation() {
    AppPopUps().showProgressDialog(context: myContext);
    printWrapped("filtering ");

    if (filterLocation.text.isNotEmpty) {
      print(filterLocation.text);

      showingListOfCandidates = _allCandidatesList.where((i) {
        print("xxxxx ${i.location}");
        return (((i.location ?? 0).toString()) == filterLocation.text);
      }).toList();
    } else {
      showingListOfCandidates = _allCandidatesList;
    }

    AppPopUps().dissmissDialog();
    notifyListeners();
  }

  void filterOnJobSubType() {
    AppPopUps().showProgressDialog(context: myContext);
    printWrapped("filtering ");

    if (selectedJobSubType != null) {
      showingListOfCandidates = _allCandidatesList.where((i) {
        return (((i.subtype ?? "-1").toString()) ==
            (selectedJobSubType?.id ?? 0).toString());
      }).toList();
    } else {
      showingListOfCandidates = _allCandidatesList;
    }

    AppPopUps().dissmissDialog();
    notifyListeners();
  }

  void filterOnVerified() {
    AppPopUps().showProgressDialog(context: myContext);
    printWrapped("filtering ");
    showingListOfCandidates.sort((a, b) {
      return isVerifiedFiltered
          ? (a.verified ?? "0").compareTo(b.verified ?? "0")
          : (b.verified ?? "0").compareTo(a.verified ?? "0");
    });

    /*   showingListOfCandidates =
        showingListOfCandidates.where((i) => ((i.verified ?? 0) == 1)).toList();*/
    isVerifiedFiltered = !isVerifiedFiltered;
    AppPopUps().dissmissDialog();
    notifyListeners();
  }

  StreamController<List<Jobtypes?>> jobTypeStreamController =
      StreamController.broadcast();

  Stream<List<Jobtypes?>> getJobTypes() {
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.all_job_types,
              body: {},
            ),
            create: () =>
                APIResponse<JobTypeModel>(create: () => JobTypeModel()),
            apiFunction: getJobTypes)
        .then((response) {
      if (response.response?.data != null) {
        JobTypeModel? jobTypeModel = response.response!.data;

        jobTypeStreamController.sink.add(jobTypeModel!.jobtypes!);
        jobTypeList = jobTypeModel.jobtypes ?? [];
      }
    }).catchError((error) {});
    return jobTypeStreamController.stream;
  }

  String getNameOfJobTypeFromId({required String? id}) {
    String name = 'N/A';
    if (id != null) {
      for (final job in jobTypeList) {
        if (job!.id.toString() == id) {
          name = job.jobType ?? '';
        }
      }
    }

    return name;
  }

  void getAllCandidates({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      'country': Provider.of<CompanyProfileViewModel>(myContext!, listen: false)
          .selectedCountryId
      //  'country': '4'
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
      showingListOfCandidates.clear();
      _allCandidatesList = response.response?.data?.candidates ?? [];
      showingListOfCandidates.addAll(_allCandidatesList);
      filterOnVerified();
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
    filterLocation.clear();
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

  StreamController<List<Jobsubtypes?>> jobSubTypeStreamController =
      StreamController.broadcast();

  List<Jobsubtypes?>? jobSubTypeList;

  Stream<List<Jobsubtypes?>> getJobSubTypes() {
    if (selectedJobType != null) {
      String url = ApiConstants.baseUrl +
          ApiConstants.all_job_subtypes +
          "/" +
          selectedJobType!.id!.toString();

      var client = APIClient(isCache: false, baseUrl: url);
      client
          .request(
              route: APIRoute(
                APIType.all_job_subtypes,
                body: {},
              ),
              create: () =>
                  APIResponse<JobSubTypeModel>(create: () => JobSubTypeModel()),
              apiFunction: getJobSubTypes)
          .then((response) {
        if (response.response?.data != null) {
          JobSubTypeModel? jobSubTypeModel = response.response!.data;
          printWrapped(jobSubTypeModel.toString());
          jobSubTypeStreamController.sink.add(jobSubTypeModel!.jobsubtypes!);
          jobSubTypeList = jobSubTypeModel.jobsubtypes ?? [];
        }
      }).catchError((error) {});
    }

    return jobSubTypeStreamController.stream;
  }

  void clearFilter() {
    filterLocation.clear();
    selectedJobSubType = null;
    showingListOfCandidates = _allCandidatesList;
    notifyListeners();
  }

  void checkChatsFromFirebase({onComplete}) {
    onComplete(true);
  }
}
