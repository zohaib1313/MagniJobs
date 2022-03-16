import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/routes.dart';

import '../models/all_jobs_model.dart';
import '../models/all_lessons_model.dart';
import '../models/my_applications.dart';

class AttendieProfileViewModel extends ChangeNotifier {
  TextEditingController searchJobPostedController = TextEditingController();
  List<Applications> myApplicaitons = [];

  List<Jobs> allJobs = [];

  void getMyApplications({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.getMyJobs,
              body: {},
            ),
            create: () =>
                APIResponse<JobHistoryModel>(create: () => JobHistoryModel()),
            apiFunction: getMyApplications)
        .then((response) {
      AppPopUps().dissmissDialog();
      myApplicaitons = response.response?.data?.applications ?? [];
      completion(myApplicaitons);
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

  void cancelApplication({required int id, completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    String url = ApiConstants.baseUrl +
        ApiConstants.cancelApplication +
        "/" +
        id.toString();
    var client = APIClient(isCache: false, baseUrl: url);
    client
        .request(
            route: APIRoute(
              APIType.cancelApplication,
              body: {},
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: cancelApplication)
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

  List<Lessons>? allLessonsList;

  void getAllLessions({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.allLessons,
              body: {},
            ),
            create: () =>
                APIResponse<AllLessonsModel>(create: () => AllLessonsModel()),
            apiFunction: getAllLessions)
        .then((response) {
      AppPopUps().dissmissDialog();
      allLessonsList = response.response?.data?.lessons ?? [];
      completion(allLessonsList);
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

  void bookLesson({required int id, completion}) {
    AppPopUps().showProgressDialog(context: myContext);

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.bookWithTutor,
              body: {"lesson_id": id},
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: bookLesson)
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
