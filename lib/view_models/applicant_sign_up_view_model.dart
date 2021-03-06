import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/job_sub_type_model.dart';
import 'package:magnijobs_rnr/models/job_type_model.dart';
import 'package:path/path.dart';

import '../models/signin_model.dart';
import '../routes.dart';
import '../utils/user_defaults.dart';
import '../utils/utils.dart';

class ApplicantSignUpViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  File? nationalIdImage;

  TextEditingController firstnameContoller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();
  TextEditingController certificatesController = TextEditingController();
  TextEditingController examsController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();

  bool _hidePassword = true;

  bool termsConditionAccepted = false;

  bool get hidePassword => _hidePassword;

  set hidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  bool _hidePassword2 = true;

  bool get hidePassword2 => _hidePassword2;

  set hidePassword2(bool value) {
    _hidePassword2 = value;
    notifyListeners();
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
        allowMultiple: false);
    if (result != null) {
      File file = File(result.files.single.path!);
      nationalIdImage = file;
      notifyListeners();
    } else {
      // User canceled the picker
    }
  }

  registerApplicant({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    FormData body = FormData.fromMap({
      "first_name": firstnameContoller.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "utype": "Candidate",
      "status": 0,
      "address": addressController.text,
      "location": locationController.text,
      "dob": dobController.text,
      "nationality": nationalityController.text,
      "gender": genderController.text,
      "marital_status": martialStatusController.text,
      "certifications": certificatesController.text,
      "exams": examsController.text,
      "license": licenseController.text,
      "job_type": selectedJobType?.id.toString() ?? "null",
      "subType": selectedJobSubType?.id.toString() ?? "null",
      "national_id": await MultipartFile.fromFile(
        nationalIdImage!.path,
        filename: basename(nationalIdImage!.path),
      ),
    });
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
      route: APIRoute(
        APIType.register_new_applicant,
        body: body,
      ),
      create: () => APIResponse<CandidateSignInModel>(
          create: () => CandidateSignInModel()),
      // apiFunction: registerApplicant()
    )
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response?.data?.token != null) {
        UserDefaults.setApiToken(response.response?.data?.token ?? '');
      }

      resetState();
      completion(response.response?.data);
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
    firstnameContoller.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
    dobController.clear();
    nationalityController.clear();
    genderController.clear();
    martialStatusController.clear();
    certificatesController.clear();
    examsController.clear();
    licenseController.clear();
    workExperienceController.clear();
    nationalIdImage = null;
  }

  void addCertificates() {
    print('adding');
    certificatesController.text = 'abc';
  }

/////////////1////////////////
  Jobtypes? selectedJobType;
  Jobsubtypes? selectedJobSubType;
  StreamController<List<Jobtypes?>> jobTypeStreamController =
      StreamController.broadcast();
  StreamController<List<Jobsubtypes?>> jobSubTypeStreamController =
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
        // view.selectedJobType = snapshot.data![0];
        // selectedJobType = jobTypeModel.jobtypes![0];
        getJobSubTypes();
      }
    }).catchError((error) {});
    return jobTypeStreamController.stream;
  }

  Stream<List<Jobsubtypes?>> getJobSubTypes() {
    selectedJobSubType = null;
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
          selectedJobSubType = jobSubTypeModel.jobsubtypes![0];
        }
      }).catchError((error) {
        printWrapped("errrrrr ${error}");
      });
    }

    return jobSubTypeStreamController.stream;
  }

/////////////2/////////////////
  Jobtypes? selectedJobType2;
  Jobsubtypes? selectedJobSubType2;
  StreamController<List<Jobtypes?>> jobTypeStreamController2 =
      StreamController.broadcast();
  StreamController<List<Jobsubtypes?>> jobSubTypeStreamController2 =
      StreamController.broadcast();
  Stream<List<Jobtypes?>> getJobTypes2() {
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

        jobTypeStreamController2.sink.add(jobTypeModel!.jobtypes!);
        // view.selectedJobType = snapshot.data![0];
        // selectedJobType = jobTypeModel.jobtypes![0];
        getJobSubTypes2();
      }
    }).catchError((error) {});
    return jobTypeStreamController2.stream;
  }

  Stream<List<Jobsubtypes?>> getJobSubTypes2() {
    selectedJobSubType2 = null;
    if (selectedJobType2 != null) {
      String url = ApiConstants.baseUrl +
          ApiConstants.all_job_subtypes +
          "/" +
          selectedJobType2!.id!.toString();

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
          jobSubTypeStreamController2.sink.add(jobSubTypeModel!.jobsubtypes!);
          selectedJobSubType2 = jobSubTypeModel.jobsubtypes![0];
        }
      }).catchError((error) {});
    }

    return jobSubTypeStreamController2.stream;
  }
  ////////////////3///////////////////

  Jobtypes? selectedJobType3;
  Jobsubtypes? selectedJobSubType3;
  StreamController<List<Jobtypes?>> jobTypeStreamController3 =
      StreamController.broadcast();
  StreamController<List<Jobsubtypes?>> jobSubTypeStreamController3 =
      StreamController.broadcast();
  Stream<List<Jobtypes?>> getJobTypes3() {
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

        jobTypeStreamController3.sink.add(jobTypeModel!.jobtypes!);
        // view.selectedJobType = snapshot.data![0];
        // selectedJobType = jobTypeModel.jobtypes![0];
        getJobSubTypes3();
      }
    }).catchError((error) {});
    return jobTypeStreamController3.stream;
  }

  Stream<List<Jobsubtypes?>> getJobSubTypes3() {
    selectedJobSubType3 = null;
    if (selectedJobType3 != null) {
      String url = ApiConstants.baseUrl +
          ApiConstants.all_job_subtypes +
          "/" +
          selectedJobType3!.id!.toString();

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
          jobSubTypeStreamController3.sink.add(jobSubTypeModel!.jobsubtypes!);
          selectedJobSubType3 = jobSubTypeModel.jobsubtypes![0];
        }
      }).catchError((error) {});
    }

    return jobSubTypeStreamController3.stream;
  }
}
