import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/choose_signin/choose_signin_screen.dart';
import 'package:magnijobs_rnr/screens/on_boarding/on_boarding_views.dart';

import '../../styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const id = "on_boarding";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
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
            //padding: AppConstants.ltrPadding,
            child: IntroductionScreen(
              rawPages: rawPages,
              isBottomSafeArea: true,
              // freeze: true,
              controlsMargin: EdgeInsets.all(10),
              onDone: () {
                Navigator.of(myContext!)
                    .pushReplacementNamed(ChooseSignInScreen.id);
              },
              onSkip: () {
                Navigator.of(myContext!)
                    .pushReplacementNamed(ChooseSignInScreen.id);
              },
              showSkipButton: true,
              skip: Text(
                "Skip",
                style: AppTextStyles.textStyleNormalBodySmall
                    .copyWith(color: AppColor.whiteColor),
              ),
              next: Text(
                "Next",
                style: AppTextStyles.textStyleNormalBodySmall
                    .copyWith(color: AppColor.whiteColor),
              ),
              done: Text(
                "Done",
                style: AppTextStyles.textStyleNormalBodySmall
                    .copyWith(color: AppColor.whiteColor),
              ),
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(30.0, 10.0),
                activeColor: AppColor.whiteColor,
                color: AppColor.whiteColor,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            )),
      ),
    );
  }
}

final rawPages = [
  OnBoardingOurCompanyInfo(),
  OnBoardingForClients(),
  OnBoardingForApplicant(),
];
