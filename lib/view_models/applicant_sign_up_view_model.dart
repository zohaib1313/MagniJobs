import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:path/path.dart';

import '../routes.dart';

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
  TextEditingController companynameController = TextEditingController();
  TextEditingController contactnumberController = TextEditingController();
  TextEditingController contactemailController = TextEditingController();
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
      "company_name": companynameController.text,
      "contact_number": contactnumberController.text,
      "contact_email": contactemailController.text,
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
      create: () => APIResponse(decoding: false),
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
    companynameController.clear();
    contactnumberController.clear();
    contactemailController.clear();
    nationalIdImage = null;
  }
}
