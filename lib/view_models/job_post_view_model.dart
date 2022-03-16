import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/all_employers_model.dart';
import 'package:magnijobs_rnr/models/post_job.dart';
import 'package:magnijobs_rnr/routes.dart';

class JobPostViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String _selectedCountryId = '';

  String get selectedCountryId => _selectedCountryId;

  set selectedCountryId(String value) {
    _selectedCountryId = value;
  }

  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController jobdiscriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  AllEmployersModel? employersModel;
  bool _rememberMe = false;

  String? selectedCompanyId = "";

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
      'country': selectedCountryId,
      "salary": salaryController.text,
      "company": selectedCompanyId ?? "",
      "qualification": qualificationController.text,
      "job_description": jobdiscriptionController.text,
      'due_date': dueDateController.text,
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

  void getAllCompanies({completion}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_employers,
              body: body,
            ),
            create: () => APIResponse<AllEmployersModel>(
                create: () => AllEmployersModel()),
            apiFunction: getAllCompanies)
        .then((response) {
      AppPopUps().dissmissDialog();
      employersModel = response.response!.data;
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
    selectedCountryId = '';
    jobController.clear();
    locationController.clear();
    salaryController.clear();
    qualificationController.clear();
    dueDateController.clear();
    jobdiscriptionController.clear();
  }
}
