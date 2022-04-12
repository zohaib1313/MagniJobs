import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/all_employers_model.dart';
import 'package:magnijobs_rnr/models/post_job.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';

import '../models/job_sub_type_model.dart';
import '../models/job_type_model.dart';

class JobPostViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String _selectedCountryId = '';

  String get selectedCountryId => _selectedCountryId;

  Jobtypes? selectedJobType;

  StreamController<List<Jobtypes?>> jobTypeStreamController =
      StreamController.broadcast();
  StreamController<List<Jobsubtypes?>> jobSubTypeStreamController =
      StreamController.broadcast();
  Jobsubtypes? selectedJobSubType;

  set selectedCountryId(String value) {
    _selectedCountryId = value;
  }

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
      "job": selectedJobType?.jobType ?? "null",
      "location": locationController.text,
      'country': selectedCountryId,
      "salary": salaryController.text,
      // "company": selectedCompanyId ?? "",
      "company": (UserDefaults.getEmployerUserSession()?.employerModel?.id ?? 0)
          .toString(),
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

  resetState(
      {String? countryId,
      String? job,
      String? location,
      String? salary,
      String? qulification,
      String? dueDate = '',
      String? jobDesc}) {
    selectedCountryId = '';
    getJobTypes(jobType: job);
    locationController.text = location ?? '';
    salaryController.text = salary ?? '';
    qualificationController.text = qulification ?? '';
    dueDateController.text = dueDate != ''
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(dueDate!))
        : '';
    jobdiscriptionController.text = jobDesc ?? '';
  }

  void updateJobs({completion, required int id}) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {
      "job": selectedJobType?.jobType ?? 'null',
      "subtype": selectedJobSubType?.jobType ?? 'null',
      "location": locationController.text,
      'country': selectedCountryId,
      "salary": salaryController.text,
      "company": selectedCompanyId ?? "",
      "qualification": qualificationController.text,
      "job_description": jobdiscriptionController.text,
      'due_date': dueDateController.text,
    };
    String s =
        ApiConstants.baseUrl + ApiConstants.update_job_post + id.toString();
    var client = APIClient(isCache: false, baseUrl: s);
    client
        .request(
            route: APIRoute(
              APIType.update_job_post,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: updateJobs)
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

  Stream<List<Jobtypes?>> getJobTypes({String? jobType}) {
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

        if (jobType != null) {
          jobTypeModel.jobtypes?.forEach((element) {
            if ((element.jobType ?? 'nn') == (jobType)) {
              selectedJobType = element;
            }
          });
        }

        getJobSubTypes();
      }
    }).catchError((error) {});
    return jobTypeStreamController.stream;
  }

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

          jobSubTypeStreamController.sink.add(jobSubTypeModel!.jobsubtypes!);
          selectedJobSubType = jobSubTypeModel.jobsubtypes![0];
        }
      }).catchError((error) {});
    }

    return jobSubTypeStreamController.stream;
  }
}
