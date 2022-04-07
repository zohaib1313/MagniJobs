import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:path/path.dart';

import '../models/signin_model.dart';
import '../routes.dart';

class UpdateTutorProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  File? profilePic;
  TextEditingController firstnameContoller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyController = TextEditingController();

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

  getFile({onCompleteA}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
        allowMultiple: false);
    if (result != null) {
      File file = File(result.files.single.path!);
      profilePic = file;
      setValuesWithSharedPref();
      updateProfile(onComplete: () {
        AppPopUps.showAlertDialog(message: 'Profile updated');
        onCompleteA();
      });
    } else {
      // User canceled the picker
    }
  }

  resetState() {
    profilePic = null;
    firstnameContoller.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    addressController.clear();
    companyController.clear();
  }

  Future<void> updateProfile({onComplete}) async {
    AppPopUps().showProgressDialog(context: myContext);
    FormData body = FormData.fromMap({
      "first_name": firstnameContoller.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "address": addressController.text,
      "company": companyController.text,
      'avatar': profilePic?.path != null
          ? await MultipartFile.fromFile(
              profilePic!.path,
              filename: basename(profilePic!.path),
            )
          : "",
    });
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.update_tutor_profile,
              body: body,
            ),
            create: () =>
                APIResponse<TutorSignInModel>(create: () => TutorSignInModel()),
            apiFunction: updateProfile)
        .then((response) async {
      AppPopUps().dissmissDialog();
      await UserDefaults.saveTutorSignInModel(
          response.response!.data!, UserDefaults.getUserType() ?? '');
      //   resetState();
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
    });
  }

  void setValuesWithSharedPref() {
    TutorSignInModel? user = UserDefaults.getTutorUserSession();
    firstnameContoller.text = user?.user?.firstName ?? "";
    lastNameController.text = user?.user?.lastName ?? "";
    emailController.text = user?.user?.email ?? "";
    mobileController.text = user?.user?.mobile ?? "";
    addressController.text = user?.tutorModel?.address ?? "";
    companyController.text = user?.tutorModel?.company ?? "";
  }
}
