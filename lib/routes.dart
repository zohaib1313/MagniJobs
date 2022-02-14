import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/screens/addpayment/add_payment_screen.dart';
import 'package:magnijobs_rnr/screens/applicant_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/choose_signin/choose_signin_screen.dart';
import 'package:magnijobs_rnr/screens/company_profile/company_profile_screen.dart';
import 'package:magnijobs_rnr/screens/country_and_job/country_and_job_screen.dart';
import 'package:magnijobs_rnr/screens/employee_portal_screen.dart';
import 'package:magnijobs_rnr/screens/employer_signup/employer_signup_screen.dart';
import 'package:magnijobs_rnr/screens/job_post/job_post_screen.dart';
import 'package:magnijobs_rnr/screens/on_boarding/onboardin_screen.dart';
import 'package:magnijobs_rnr/screens/packages_/packages_screen.dart';
import 'package:magnijobs_rnr/screens/sign_in/sign_in_screen.dart';
import 'package:magnijobs_rnr/screens/splash_screen.dart';
import 'package:magnijobs_rnr/screens/update_profile_screen.dart';
import 'package:magnijobs_rnr/screens/verify_number/verify_number_screen.dart';
import 'package:magnijobs_rnr/view_models/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  OnBoardingScreen.id: (context) => const OnBoardingScreen(),
  ChooseSignInScreen.id: (context) => ChooseSignInScreen(),
  EmployerSignUpScreen.id: (context) => EmployerSignUpScreen(),
  PackagesScreen.id: (context) => PackagesScreen(),
  AddPaymentScreen.id: (context) => AddPaymentScreen(),
  SigInScreen.id: (context) => SigInScreen(),
  VerifyNumberScreen.id: (context) => VerifyNumberScreen(),
  CompanyProfileScreen.id: (context) => CompanyProfileScreen(),
  JobPostScreen.id: (context) => JobPostScreen(),
  CountryAndJobScreen.id: (context) => CountryAndJobScreen(),
  ApplicantSignUp.id: (context) => ApplicantSignUp(),
  EmployeePortalScreen.id: (context) => EmployeePortalScreen(),
  UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
};

final List<ChangeNotifierProvider<dynamic>> multiProviders = [
  ChangeNotifierProvider<SplashScreenViewModel>(
      create: (_) => SplashScreenViewModel()),
];
