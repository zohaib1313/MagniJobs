import 'package:flutter/material.dart';

import '../common_widgets/app_popups.dart';
import '../dio_network/APis.dart';
import '../dio_network/api_client.dart';
import '../dio_network/api_response.dart';
import '../dio_network/api_route.dart';
import '../routes.dart';

class TutorCreateNewLessonViewModel extends ChangeNotifier {
  TextEditingController categoryController = TextEditingController();
  TextEditingController lessonNameController = TextEditingController();
  TextEditingController lessonDescription = TextEditingController();
  TextEditingController lessonLinkController = TextEditingController();
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController selectedTimeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void resetDate() {
    categoryController.clear();
    lessonNameController.clear();
    lessonDescription.clear();
    lessonLinkController.clear();
    selectedDateController.clear();
    selectedTimeController.clear();
  }

  createLesson({required completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "category": categoryController.text,
      "lesson": lessonNameController.text,
      "description": lessonDescription.text,
      "lesson_date": selectedDateController.text,
      "lesson_time": selectedTimeController.text,
      "meeting_link": lessonLinkController.text
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.add_new_lesson,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: createLesson)
        .then((response) {
      AppPopUps().dissmissDialog();
      completion();
    }).catchError((error) {
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
