import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:path/path.dart';

import '../models/signin_model.dart';
import '../routes.dart';

class UpdateCandidateProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  File? profilePicImage;
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
      profilePicImage = file;
      setValuesWithSharedPref();
      updateProfile(onComplete: () {
        profilePicImage = null;
        setValuesWithSharedPref();
        AppPopUps.showAlertDialog(message: 'Profile updated');
      });
    } else {
      // User canceled the picker
    }
  }

  resetState() {
    profilePicImage = null;
    firstnameContoller.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    addressController.clear();
    locationController.clear();
    dobController.clear();
    nationalityController.clear();
    genderController.clear();
    martialStatusController.clear();
    schoolController.clear();
    workExperienceController.clear();
    certificationController.clear();
    examsController.clear();
    preferredlocationController.clear();
    licenseController.clear();
  }

  void updateProfile({onComplete}) async {
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
      "gender": genderController.text.isEmpty ? "Male" : genderController.text,
      "marital_status": martialStatusController.text.isEmpty
          ? "Single"
          : martialStatusController.text,
      "school": schoolController.text,
      "work_experience": workExperienceController.text,
      "certifications": certificationController.text,
      "exams": examsController.text,
      "license": licenseController.text,
      "preferred_location": preferredlocationController.text,
      'profile': profilePicImage?.path != null
          ? await MultipartFile.fromFile(
              profilePicImage!.path,
              filename: basename(profilePicImage!.path),
            )
          : "",
    });
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.update_my_profile,
              body: body,
            ),
            create: () => APIResponse<CandidateSignInModel>(
                create: () => CandidateSignInModel()),
            apiFunction: updateProfile)
        .then((response) async {
      AppPopUps().dissmissDialog();
      await UserDefaults.saveCandidateUserSession(
          response.response!.data!, UserDefaults.getUserType() ?? '');
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
    CandidateSignInModel? user = UserDefaults.getCandidateUserSession();
    firstnameContoller.text = user?.user?.firstName ?? "";
    lastNameController.text = user?.user?.lastName ?? "";
    emailController.text = user?.user?.email ?? "";
    mobileController.text = user?.user?.mobile ?? "";
    addressController.text = user?.candidateModel?.address ?? '';
    locationController.text = user?.candidateModel?.location ?? '00';
    dobController.text = user?.candidateModel?.dob != null
        ? DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(user!.candidateModel!.dob!))
            .toString()
        : '';
    nationalityController.text = user?.candidateModel?.nationality ?? '';
    genderController.text = user?.candidateModel?.gender ?? '';
    martialStatusController.text = user?.candidateModel?.maritalStatus ?? '';
    schoolController.text = user?.candidateModel?.school ?? '';
    workExperienceController.text = user?.candidateModel?.workExperience ?? '';
    certificationController.text = user?.candidateModel?.certifications ?? '';
    examsController.text = user?.candidateModel?.exams ?? '';
    preferredlocationController.text =
        user?.candidateModel?.preferredLocation ?? '00';
    licenseController.text = user?.candidateModel?.license ?? '';
  }
}
