import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/signin_model.dart';
import 'package:path/path.dart';

import '../routes.dart';
import '../utils/user_defaults.dart';

class TutorSignUpViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  File? nationalIdImage;
  TextEditingController firstnameContoller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
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

  void logout({onComplete}) {
    onComplete();
    /* AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.logout,
              // body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: logout)
        .then((response) {
      AppPopUps().dissmissDialog();
      onComplete();
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
    });*/
  }

  registerTutor({completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    FormData body = FormData.fromMap({
      "first_name": firstnameContoller.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "utype": "Tutor",
      "status": 0,
      "address": addressController.text,
      "location": locationController.text,
      "company": companyNameController.text,
      "id_card": await MultipartFile.fromFile(
        nationalIdImage!.path,
        filename: basename(nationalIdImage!.path),
      ),
    });
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.register_new_tutor,
              body: body,
            ),
            create: () =>
                APIResponse<TutorSignInModel>(create: () => TutorSignInModel()),
            apiFunction: registerTutor)
        .then((response) {
      if (response.response?.data?.token != null) {
        UserDefaults.setApiToken(response.response?.data?.token ?? '');
      }

      AppPopUps().dissmissDialog();
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
    formKey = GlobalKey<FormState>();
    nationalIdImage = null;
    firstnameContoller.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
    locationController.clear();
    companyNameController.clear();
    webSiteController.clear();
    _hidePassword = true;
  }
}
