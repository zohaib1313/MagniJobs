import 'package:flutter/material.dart';

import '../common_widgets/app_popups.dart';
import '../dio_network/APis.dart';
import '../dio_network/api_client.dart';
import '../dio_network/api_response.dart';
import '../dio_network/api_route.dart';
import '../routes.dart';

class CalenderApplicantBookingsViewModel extends ChangeNotifier {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController selectedTimeController = TextEditingController();
  TextEditingController examTypeController = TextEditingController();
  TextEditingController examSubTypeController = TextEditingController();
  TextEditingController lessonLinkController = TextEditingController();
  TextEditingController lessonNameController = TextEditingController();

  void resetDate() {
    selectedTimeController.clear();
    selectedDateController.clear();
    examTypeController.clear();
    examSubTypeController.clear();
    lessonLinkController.clear();
    lessonNameController.clear();
  }

  placeBookings({required completion, required String id}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "date": selectedDateController.text,
      "exam_type": examSubTypeController.text,
      "exam_sub_type": examSubTypeController.text,
      "time": selectedTimeController.text,
      "lesson_id": id
    };

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.place_booking,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: placeBookings)
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
