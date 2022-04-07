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
import 'package:magnijobs_rnr/utils/utils.dart';
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
  TextEditingController licenseController = TextEditingController();

  TextEditingController pereferdLocation1 = TextEditingController();
  TextEditingController pereferdLocation2 = TextEditingController();
  TextEditingController pereferdLocation3 = TextEditingController();
  TextEditingController pereferdLocation4 = TextEditingController();
  TextEditingController pereferdLocation5 = TextEditingController();

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
        allowedExtensions: ['jpg'],
        allowMultiple: false);
    if (result != null) {
      File file = File(result.files.single.path!);
      profilePicImage = file;
      setValuesWithSharedPref();
      updateProfile(onComplete: () {
        profilePicImage = null;
        setValuesWithSharedPref();
        AppPopUps.showAlertDialog(message: 'Profile updated');
        onCompleteA();
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
    pereferdLocation1.clear();
    pereferdLocation2.clear();

    pereferdLocation3.clear();

    pereferdLocation4.clear();
    pereferdLocation5.clear();

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
      "preferred_location": pereferdLocation1.text,
      "preferred_location2": pereferdLocation2.text,
      "preferred_location3": pereferdLocation3.text,
      "preferred_location4": pereferdLocation4.text,
      "preferred_location5": pereferdLocation5.text,
      "job_type":
          UserDefaults.getCandidateUserSession()?.candidateModel?.job_type ??
              "null",
      'avatar': profilePicImage?.path != null
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

      printWrapped(UserDefaults.getCandidateUserSession()?.user?.profile ?? '');
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

    licenseController.text = user?.candidateModel?.license ?? '';
    locationController.text = user?.candidateModel?.location ?? '00';
    pereferdLocation1.text = user?.candidateModel?.preferredLocation ?? '00';
    pereferdLocation2.text = user?.candidateModel?.preferredLocation2 ?? '00';
    pereferdLocation3.text = user?.candidateModel?.preferredLocation3 ?? '00';
    pereferdLocation4.text = user?.candidateModel?.preferredLocation4 ?? '00';
    pereferdLocation5.text = user?.candidateModel?.preferredLocation5 ?? '00';
  }
}
