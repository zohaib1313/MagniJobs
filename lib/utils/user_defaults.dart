import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:magnijobs_rnr/models/signin_model.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/countries_model.dart';

class UserDefaults {
  static SharedPreferences? sharedPreferences;

  setBoolValue(String key, bool value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setBool(key, value);
  }

  setString(String key, String value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setString(key, value);
  }

  static Future<SharedPreferences> getPref() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences!;
  }

  bool getBoolValue(String key, bool defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getBool(key)!
          : defaultValue;
    }
    return defaultValue;
  }

  String getStringValue(String key, String defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getString(key)!
          : defaultValue;
    }

    return defaultValue;
  }

  clearAll() {
    if (sharedPreferences != null) {
      sharedPreferences!.clear();
    }
  }

  static void setIntValue(String key, int value) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    sharedPreferences.setInt(key, value);
  }

  static int getIntValue(String key, int defaultValue) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  //employer, applicant,tutor

  static Future<void> saveCandidateUserSession(
      CandidateSignInModel signInModel, String type) async {
    setCurrentUserId(signInModel.user!.id!.toString());
    String user = json.encode(signInModel.toJson());
    return getPref().then((value) => value
      ..setString('userData', user)
      ..setString('type', type));
  }

  static CandidateSignInModel? getCandidateUserSession() {
    CandidateSignInModel? user;
    if (sharedPreferences!.getString('userData') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('userData')!);
      user = CandidateSignInModel.fromJson(json);
      printWrapped(user.toString());
    }
    return user;
  }

  static void saveEmployerUserSession(
      EmployerSignInModel signInModel, String type) async {
    setCurrentUserId(signInModel.user!.id!.toString());
    String user = json.encode(signInModel.toJson());
    getPref().then((value) => value
      ..setString('userData', user)
      ..setString('type', type));
    if (kDebugMode) {
      printWrapped("user session saved type= ${type} ${user}");
      printWrapped(user.toString());
    }
  }

  static EmployerSignInModel? getEmployerUserSession() {
    EmployerSignInModel? user;
    if (sharedPreferences!.getString('userData') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('userData')!);
      user = EmployerSignInModel.fromJson(json);

      //printWrapped(user.toString());
    }
    return user;
  }

  static Future<void> saveTutorSignInModel(
      TutorSignInModel signInModel, String type) async {
    setCurrentUserId(signInModel.user!.id!.toString());
    String user = json.encode(signInModel.toJson());
    return getPref().then((value) => value
      ..setString('userData', user)
      ..setString('type', type));
    if (kDebugMode) {
      printWrapped("user session saved type= ${type} ${user}");
      printWrapped(user.toString());
    }
  }

  static void saveCountries(CountriesModel countriesModel) async {
    String c = json.encode(countriesModel.toJson());
    getPref().then((value) => value..setString('countries', c));
    if (kDebugMode) {
      printWrapped(c.toString());
    }
  }

  static CountriesModel? getCountriesList() {
    CountriesModel? countriesModel;
    if (sharedPreferences!.getString('countries') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('countries')!);
      countriesModel = CountriesModel.fromJson(json);

      printWrapped(countriesModel.toString());
    }
    return countriesModel;
  }

  static TutorSignInModel? getTutorUserSession() {
    TutorSignInModel? user;
    if (sharedPreferences!.getString('userData') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('userData')!);
      user = TutorSignInModel.fromJson(json);

      printWrapped(user.toString());
    }
    return user;
  }

  static String? getUserType() {
    return sharedPreferences?.getString('type');
  }

  static String? getToken() {
    return sharedPreferences?.getString('ApiToken');
  }

  static setCurrentUserId(String value) {
    return sharedPreferences?.setString('userId', value);
  }

  static String? getCurrentUserId() {
    return sharedPreferences?.getString('userId');
  }

  static setApiToken(String value) {
    return sharedPreferences?.setString('ApiToken', value);
  }
}
