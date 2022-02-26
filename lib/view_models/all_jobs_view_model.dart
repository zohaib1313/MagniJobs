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
  List<Jobs> filteredJobsOnEmployerId = [];
  bool isRecentFilterd = false;
  bool isSortFiltered = false;
  void getFilterJobsOnEmployerId({completion, required String id}) {
    filteredJobsOnEmployerId.clear();
    for (var job in alJobs) {
      if ((job.employer ?? "") == id) {
        filteredJobsOnEmployerId.add(job);
      }
    }
    completion(filteredJobsOnEmployerId);
  }

  void filterJobsOnDate() {
    AppPopUps().showProgressDialog(context: myContext);

    printWrapped("filtering ");
    filteredJobsOnEmployerId.sort((a, b) {
      int aDate = DateTime.parse(a.createdAt ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(b.createdAt ?? '').microsecondsSinceEpoch;
      printWrapped(aDate.toString());
      return aDate.compareTo(bDate);
    });
    isRecentFilterd = !isRecentFilterd;
    AppPopUps().dissmissDialog();

    notifyListeners();
  }

  void filterJobsOnSort() {
    AppPopUps().showProgressDialog(context: myContext);
    filteredJobsOnEmployerId.sortedBy((e) => e.salary ?? "");
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
}
