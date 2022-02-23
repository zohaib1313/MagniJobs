import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/register_new_applicant.dart';
import 'package:path/path.dart';

import '../routes.dart';

class UpdateMyProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  File? nationalIdImage;

  TextEditingController firstnameContoller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();

  TextEditingController schoolController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController certificationController = TextEditingController();

  TextEditingController examsController = TextEditingController();
  TextEditingController preferredlocationController = TextEditingController();
  TextEditingController licenseController = TextEditingController();

  bool _hidePassword = true;

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
      "address": addressController.text,
      "location": locationController.text,
      "dob": dobController.text,
      "nationality": nationalityController.text,
      "gender": genderController.text,
      "marital_status": martialStatusController.text,
      "school": schoolController,
      "work_experience": workExperienceController,
      "certifications": certificationController.text,
      "exams": examsController.text,
      "license": licenseController.text,
      "preferred_location": preferredlocationController.text,
    });
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
      route: APIRoute(
        APIType.register_new_employer,
        body: body,
      ),
      create: () => RegisterNewApplicant(),
      // apiFunction: registerApplicant()
    )
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
    firstnameContoller = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();

    addressController = TextEditingController();
    locationController = TextEditingController();
    dobController = TextEditingController();
    nationalityController = TextEditingController();
    genderController = TextEditingController();
    martialStatusController = TextEditingController();

    schoolController = TextEditingController();
    workExperienceController = TextEditingController();
    certificationController = TextEditingController();

    examsController = TextEditingController();
    preferredlocationController = TextEditingController();
    licenseController = TextEditingController();
  }
}
