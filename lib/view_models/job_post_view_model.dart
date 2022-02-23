import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/post_job.dart';
import 'package:magnijobs_rnr/routes.dart';

class JobPostViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController companynameContoller = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController jobdiscriptionController = TextEditingController();

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  postJob({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "job": jobController.text,
      "location": locationController.text,
      "salary": salaryController.text,
      "comapny": companynameContoller.text,
      "qualification": qualificationController.text,
      "job_description": jobdiscriptionController.text,
    };
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.post_a_job,
              body: body,
            ),
            create: () => PostJob(),
            apiFunction: postJob)
        .then((response) {
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

  resetState() {
    TextEditingController companynameContoller = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    TextEditingController qualificationController = TextEditingController();
    TextEditingController jobdiscriptionController = TextEditingController();
  }
}
