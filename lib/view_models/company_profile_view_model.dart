import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/models/countries_model.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

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
}
