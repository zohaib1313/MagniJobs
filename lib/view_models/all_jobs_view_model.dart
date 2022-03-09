import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

class AllJobsViewModel extends ChangeNotifier {
  List<Jobs> alJobs = [];
  List<Jobs> filteredJobs = [];
  bool isRecentFilterd = false;
  bool isSortFiltered = false;

  bool _toogle = true;

  bool get toogle => _toogle;

  TextEditingController searchJobPostedController = TextEditingController();

  set toogle(bool value) {
    _toogle = value;
    notifyListeners();
  }

  void filterJobsOnDate() {
    AppPopUps().showProgressDialog(context: myContext);
    /* filteredJobsOnEmployerId.clear();
    for (var element in alJobs) {
      int aDate = DateTime.parse(element.createdAt ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(element.createdAt ?? '').microsecondsSinceEpoch;

      aDate.compareTo(bDate)

    }*/

    printWrapped("filtering ");
    filteredJobs.sort((a, b) {
      num aDate = DateTime.parse(a.createdAt ?? '').microsecondsSinceEpoch;
      num bDate = DateTime.parse(b.createdAt ?? '').microsecondsSinceEpoch;
      printWrapped(aDate.toString());
      return isRecentFilterd ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });
    isRecentFilterd = !isRecentFilterd;
    AppPopUps().dissmissDialog();

    notifyListeners();
  }

  void filterJobsOnSort() {
    AppPopUps().showProgressDialog(context: myContext);

    filteredJobs.sort((a, b) {
      num aDate = num.parse(a.salary ?? '0');
      num bDate = num.parse(b.salary ?? '0');

      return isSortFiltered ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });
    isSortFiltered = !isSortFiltered;
    AppPopUps().dissmissDialog();

    notifyListeners();
  }

  void getAllJobs({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_jobs,
              body: body,
            ),
            create: () =>
                APIResponse<AllJobsModel>(create: () => AllJobsModel()),
            apiFunction: getAllJobs)
        .then((response) {
      AppPopUps().dissmissDialog();
      alJobs = response.response?.data?.jobs?.jobs ?? [];
      filteredJobs.addAll(alJobs);
      completion(alJobs);
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

  void applyForJob({required int id, required completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "job_id": id,
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.applyForJob,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: applyForJob)
        .then((response) {
      AppPopUps().dissmissDialog();
      completion();
      print(response);
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

  void searchJobPosted() {
    printWrapped(alJobs.length.toString());
    filteredJobs.clear();
    if (searchJobPostedController.text.isEmpty) {
      printWrapped("empty");
      filteredJobs.addAll(alJobs);
    } else {
      for (var element in alJobs) {
        if (searchJobPostedController.text
                .toLowerCase()
                .contains(element.employer ?? "".toLowerCase()) ||
            searchJobPostedController.text
                .toLowerCase()
                .contains(element.job ?? "".toLowerCase()) ||
            searchJobPostedController.text
                .toLowerCase()
                .contains(element.jobDescription ?? "".toLowerCase()) ||
            searchJobPostedController.text
                .toLowerCase()
                .contains(element.poster ?? "".toLowerCase())) {
          filteredJobs.add(element);
        }
      }
    }
    notifyListeners();
  }
}
