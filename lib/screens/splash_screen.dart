import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magnijobs_rnr/screens/on_boarding/onboardin_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../routes.dart';
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
    Timer(
        const Duration(seconds: 3),
        () => {
              if (UserDefaults.getUserSession() != null)
                {gotoRelevantScreenOnUserType()}
              else
                {
                  Navigator.of(myContext!)
                      .pushReplacementNamed(OnBoardingScreen.id)
                }
            });
  }

  void gotoRelevantScreenOnUserType() {
    String userType = UserDefaults?.getUserType() ?? "";
    printWrapped(userType);

    if (userType.isNotEmpty) {
      switch (userType) {
        case 'employer':
          Navigator.of(myContext!)
              .pushReplacementNamed(CompanyProfileScreen.id);

          break;
        case 'applicant':
          Navigator.of(myContext!)
              .pushReplacementNamed(EmployeePortalScreen.id);
          break;
        case 'tutor':
          // Navigator.of(myContext!).pushReplacementNamed(EmployeePortalScreen.id);
          break;
      }
    } else {
      Navigator.of(myContext!).pushReplacementNamed(OnBoardingScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryBlueDarkColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor:
                AppColor.primaryBlueDarkColor //or the color you prefer
            ),
        child: SafeArea(
          child: Container(
            color: AppColor.primaryBlueColor,
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
