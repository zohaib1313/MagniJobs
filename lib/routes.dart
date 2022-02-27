import 'package:flutter/cupertino.dart';
import 'package:magnijobs_rnr/screens/addpayment/add_payment_screen.dart';
import 'package:magnijobs_rnr/screens/all_jobs_screen.dart';
import 'package:magnijobs_rnr/screens/applicant_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/choose_signin/choose_signin_screen.dart';
import 'package:magnijobs_rnr/screens/company_profile/company_profile_screen.dart';
import 'package:magnijobs_rnr/screens/employee_portal_screen.dart';
import 'package:magnijobs_rnr/screens/employer_signup/employer_signup_screen.dart';
import 'package:magnijobs_rnr/screens/job_post/job_post_screen.dart';
import 'package:magnijobs_rnr/screens/on_boarding/onboardin_screen.dart';
import 'package:magnijobs_rnr/screens/packages_/packages_screen.dart';
import 'package:magnijobs_rnr/screens/splash_screen.dart';
import 'package:magnijobs_rnr/screens/tutor_profile_screen.dart';
import 'package:magnijobs_rnr/screens/tutor_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/update_profile_screen.dart';
import 'package:magnijobs_rnr/screens/verify_number/verify_number_screen.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:magnijobs_rnr/view_models/all_packges_view_model.dart';
import 'package:magnijobs_rnr/view_models/applicant_sign_up_view_model.dart';
import 'package:magnijobs_rnr/view_models/assign_applicant_t_employee_view_model.dart';
import 'package:magnijobs_rnr/view_models/country_and_job_view_model.dart';
import 'package:magnijobs_rnr/view_models/delete_job_post_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_portal_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_signup_view_model.dart';
import 'package:magnijobs_rnr/view_models/forgot_password_view_model.dart';
import 'package:magnijobs_rnr/view_models/job_post_view_model.dart';
import 'package:magnijobs_rnr/view_models/jobseeker_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/logout_view_model.dart';
import 'package:magnijobs_rnr/view_models/my_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/sigin_screen_view_model.dart';
import 'package:magnijobs_rnr/view_models/splash_screen_view_model.dart';
import 'package:magnijobs_rnr/view_models/tutor_signup_view_model.dart';
import 'package:magnijobs_rnr/view_models/update_job_post_view_model.dart';
import 'package:magnijobs_rnr/view_models/update_my_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/upload_my_business_registration_view_model.dart';
import 'package:magnijobs_rnr/view_models/upload_my_covid_certificate_view_model.dart';
import 'package:magnijobs_rnr/view_models/upload_my_national_id_view_model.dart';
import 'package:magnijobs_rnr/view_models/upload_my_nurse_certificate_view_model.dart';
import 'package:magnijobs_rnr/view_models/upload_my_resume_view_model.dart';
import 'package:magnijobs_rnr/view_models/verify_number_view_model.dart';
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
  VerifyNumberScreen.id: (context) => VerifyNumberScreen(),
  CompanyProfileScreen.id: (context) => CompanyProfileScreen(),
  JobPostScreen.id: (context) => JobPostScreen(),
  AllJobScreen.id: (context) => AllJobScreen(),
  ApplicantSignUp.id: (context) => ApplicantSignUp(),
  EmployeePortalScreen.id: (context) => const EmployeePortalScreen(),
  UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
  TutorSignUpScreen.id: (context) => TutorSignUpScreen(),
  TutorProfileScreen.id: (context) => TutorProfileScreen(),
};

final List<ChangeNotifierProvider<dynamic>> multiProviders = [
  ChangeNotifierProvider<SplashScreenViewModel>(
      create: (_) => SplashScreenViewModel()),
  ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
  ChangeNotifierProvider<VerifyNumberViewModel>(
      create: (_) => VerifyNumberViewModel()),
  ChangeNotifierProvider<AllPackagesViewModel>(
      create: (_) => AllPackagesViewModel()),
  ChangeNotifierProvider<MyProfileViewModel>(
      create: (_) => MyProfileViewModel()),
  ChangeNotifierProvider<JobseekerViewModel>(
      create: (_) => JobseekerViewModel()),
  ChangeNotifierProvider<UpdateMyProfileViewModel>(
      create: (_) => UpdateMyProfileViewModel()),
  ChangeNotifierProvider<JobPostViewModel>(create: (_) => JobPostViewModel()),
  ChangeNotifierProvider<UpdateJobPostViewModel>(
      create: (_) => UpdateJobPostViewModel()),
  ChangeNotifierProvider<DeleteJobPostViewModel>(
      create: (_) => DeleteJobPostViewModel()),
  ChangeNotifierProvider<AllJobsViewModel>(create: (_) => AllJobsViewModel()),
  ChangeNotifierProvider<ApplicantSignUpViewModel>(
      create: (_) => ApplicantSignUpViewModel()),
  ChangeNotifierProvider<EmployerSignUpViewModel>(
      create: (_) => EmployerSignUpViewModel()),
  ChangeNotifierProvider<TutorSignUpViewModel>(
      create: (_) => TutorSignUpViewModel()),
  ChangeNotifierProvider<LogoutViewModel>(create: (_) => LogoutViewModel()),
  ChangeNotifierProvider<UploadMyResumesViewModel>(
      create: (_) => UploadMyResumesViewModel()),
  ChangeNotifierProvider<UploadMyNurseCertificateViewModel>(
      create: (_) => UploadMyNurseCertificateViewModel()),
  ChangeNotifierProvider<UploadMyNationalIdViewModel>(
      create: (_) => UploadMyNationalIdViewModel()),
  ChangeNotifierProvider<UploadMyBusinessRegistrationViewModel>(
      create: (_) => UploadMyBusinessRegistrationViewModel()),
  ChangeNotifierProvider<UploadMyCovidCertificateViewModel>(
      create: (_) => UploadMyCovidCertificateViewModel()),
  ChangeNotifierProvider<AssignApplicantToEmployeeViewModel>(
      create: (_) => AssignApplicantToEmployeeViewModel()),
  ChangeNotifierProvider<CountryAndJobViewModel>(
      create: (_) => CountryAndJobViewModel()),
  ChangeNotifierProvider<AllJobsViewModel>(create: (_) => AllJobsViewModel()),
  ChangeNotifierProvider<ForgotPasswordViewModel>(
      create: (_) => ForgotPasswordViewModel()),
  ChangeNotifierProvider<EmployerPortalViewModel>(
      create: (_) => EmployerPortalViewModel()),
];
