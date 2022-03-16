import 'dart:async';
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
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/models/countries_model.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:path/path.dart';

import '../common_widgets/app_popups.dart';
import '../models/signin_model.dart';
import '../routes.dart';

class CompanyProfileViewModel extends ChangeNotifier {
  StreamController<List<Countries?>> countriesStreamController =
      StreamController.broadcast();
  StreamController<List<Jobs?>> jobsStreamController =
      StreamController.broadcast();

  String _selectedCountryId = '';
  TextEditingController queryEditingController = TextEditingController();

  String get selectedCountryId => _selectedCountryId;

  set selectedCountryId(String value) {
    _selectedCountryId = value;
  }

  Stream<List<Countries?>> loadCountries() {
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.all_countries,
              body: {},
            ),
            create: () =>
                APIResponse<CountriesModel>(create: () => CountriesModel()),
            apiFunction: loadCountries)
        .then((response) {
      if (response.response?.data != null) {
        CountriesModel? countriesModel = response.response!.data;
        printWrapped(countriesModel.toString());
        countriesStreamController.sink.add(countriesModel!.countries!);
      }
    }).catchError((error) {});
    return countriesStreamController.stream;
  }

  Stream<List<Jobs?>> loadJobs() {
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_jobs,
              body: {},
            ),
            create: () =>
                APIResponse<AllJobsModel>(create: () => AllJobsModel()),
            apiFunction: loadCountries)
        .then((response) {
      if (response.response?.data != null) {
        AllJobsModel? model = response.response!.data;
        printWrapped(model.toString());
        jobsStreamController.sink.add(model!.jobs!.jobs!);
      }
    }).catchError((error) {});
    return jobsStreamController.stream;
  }

  void resetState() {
    _selectedCountryId = '';
    queryEditingController.clear();
  }

  var profilePicImage;

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
        allowMultiple: false);
    if (result != null) {
      File file = File(result.files.single.path!);
      profilePicImage = file;
      updateProfile(onComplete: () {
        profilePicImage = null;
        AppPopUps.showAlertDialog(message: 'Profile updated');
      });
    } else {
      // User canceled the picker
    }
  }

  void updateProfile({onComplete}) async {
    AppPopUps().showProgressDialog(context: myContext);
    FormData body = FormData.fromMap({
      "first_name":
          UserDefaults.getEmployerUserSession()?.user?.firstName ?? '',
      "last_name": UserDefaults.getEmployerUserSession()?.user?.lastName ?? '',
      "email": UserDefaults.getEmployerUserSession()?.user?.email ?? '',
      "mobile": UserDefaults.getEmployerUserSession()?.user?.mobile ?? '',
      "address":
          UserDefaults.getEmployerUserSession()?.employerModel?.address ?? '',
      "location":
          UserDefaults.getEmployerUserSession()?.employerModel?.location ?? '',
      "company_name":
          UserDefaults.getEmployerUserSession()?.employerModel?.companyName ??
              '',
      "contact_number":
          UserDefaults.getEmployerUserSession()?.employerModel?.contactNumber ??
              '',
      "contact_email":
          UserDefaults.getEmployerUserSession()?.employerModel?.contactEmail ??
              '',
      "website":
          UserDefaults.getEmployerUserSession()?.employerModel?.website ?? '',
      'logo': profilePicImage?.path != null
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
              APIType.update_employer_profile,
              body: body,
            ),
            create: () => APIResponse<EmployerSignInModel>(
                create: () => EmployerSignInModel()),
            apiFunction: updateProfile)
        .then((response) async {
      AppPopUps().dissmissDialog();
      UserDefaults.saveEmployerUserSession(
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
}
