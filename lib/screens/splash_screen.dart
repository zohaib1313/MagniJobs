import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/screens/on_boarding/onboardin_screen.dart';
import 'package:magnijobs_rnr/screens/tutor_profile_screen.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../view_models/country_list_view_model.dart';
import 'attendie_profile_screen.dart';
import 'company_profile/company_profile_screen.dart';
import 'employee_portal_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    if (UserDefaults.getCountriesList()?.countries != null) {
      Timer(
          const Duration(seconds: 3),
          () => {
                if (UserDefaults.getUserType() != null)
                  {gotoRelevantScreenOnUserType()}
                else
                  {
                    Navigator.of(myContext!)
                        .pushReplacementNamed(OnBoardingScreen.id)
                  }
              });
    } else {
      Provider.of<CountriesListViewModel>(myContext!, listen: false)
          .loadCountries(completion: (countryModel) {
        if (countryModel != null) {
          UserDefaults.saveCountries(countryModel!);
          Timer(
              const Duration(seconds: 1),
              () => {
                    if (UserDefaults.getUserType() != null)
                      {gotoRelevantScreenOnUserType()}
                    else
                      {
                        Navigator.of(myContext!)
                            .pushReplacementNamed(OnBoardingScreen.id)
                      }
                  });
        } else {
          AppPopUps.showAlertDialog(message: "No Internet Connection");
        }
      });
    }
  }

  void gotoRelevantScreenOnUserType() {
    String userType = UserDefaults?.getUserType() ?? "";

    printWrapped(userType);
    //todo
    // && isPhoneVerified
    if (userType.isNotEmpty) {
      switch (userType) {
        case 'attendie':
          if (UserDefaults?.getCandidateUserSession()?.candidateModel != null) {
            Navigator.of(myContext!)
                .pushReplacementNamed(AttendieCandidateProfileScreen.id);
          }
          break;

        case 'employer':
          if (UserDefaults?.getEmployerUserSession()?.employerModel != null) {
            Navigator.of(myContext!)
                .pushReplacementNamed(CompanyProfileScreen.id);
          }
          break;
        case 'applicant':
          if (UserDefaults?.getCandidateUserSession()?.candidateModel != null) {
            Navigator.of(myContext!)
                .pushReplacementNamed(EmployeePortalScreen.id);
          }

          break;
        case 'tutor':
          if (UserDefaults?.getTutorUserSession()?.tutorModel != null) {
            Navigator.of(myContext!)
                .pushReplacementNamed(TutorProfileScreen.id);
          }
          break;

        default:
          Navigator.of(myContext!).pushReplacementNamed(OnBoardingScreen.id);
      }
    } else {
      Navigator.of(myContext!).pushReplacementNamed(OnBoardingScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.teal,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.teal //or the color you prefer
            ),
        child: SafeArea(
          child: Container(
            color: Colors.teal,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/app_logo_img.png"),
              ),
            ),
          ),
        ));
  }
}
