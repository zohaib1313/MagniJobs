import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magnijobs_rnr/styles.dart';

import '../routes.dart';
import 'on_boarding/onboardin_screen.dart';

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
    Timer(const Duration(seconds: 3),
        () => {Navigator.pushReplacementNamed(myContext!, OnBoardingScreen.id)}
        /*      {
              if (UserDefaults.getUserSession() != null)
                {Navigator.pushReplacementNamed(myContext!, MainScreen.id)}
              else
                {Navigator.pushReplacementNamed(myContext!, SignInScreen.id)}
            }*/

        );
  }

  @override
  void dispose() {
    super.dispose();
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
