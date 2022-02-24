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
import 'package:magnijobs_rnr/view_models/all_candidate_view_model.dart';
import 'package:magnijobs_rnr/view_models/all_employers_view_model.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:magnijobs_rnr/view_models/all_packges_view_model.dart';
import 'package:magnijobs_rnr/view_models/applicant_sign_up_view_model.dart';
import 'package:magnijobs_rnr/view_models/assign_applicant_t_employee_view_model.dart';
import 'package:magnijobs_rnr/view_models/country_and_job_view_model.dart';
import 'package:magnijobs_rnr/view_models/delete_job_post_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_signup_view_model.dart';
import 'package:magnijobs_rnr/view_models/job_post_view_model.dart';
import 'package:magnijobs_rnr/view_models/jobseeker_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/logout_view_model.dart';
import 'package:magnijobs_rnr/view_models/my_jobs_as_employer_view_model.dart';
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
  ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
  ChangeNotifierProvider<AllJobsViewModel>(create: (_) => AllJobsViewModel()),
  ChangeNotifierProvider<VerifyNumberViewModel>(
      create: (_) => VerifyNumberViewModel()),
  ChangeNotifierProvider<AllEmployerViewModel>(
      create: (_) => AllEmployerViewModel()),
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
  ChangeNotifierProvider<MyJobsAsEmployerViewModel>(
      create: (_) => MyJobsAsEmployerViewModel()),
  ChangeNotifierProvider<ApplicantSignUpViewModel>(
      create: (_) => ApplicantSignUpViewModel()),
  ChangeNotifierProvider<EmployerSignUpViewModel>(
      create: (_) => EmployerSignUpViewModel()),
  ChangeNotifierProvider<TutorSignUpViewModel>(
      create: (_) => TutorSignUpViewModel()),
  ChangeNotifierProvider<LogoutViewModel>(create: (_) => LogoutViewModel()),
  ChangeNotifierProvider<AllCandidateViewModel>(
      create: (_) => AllCandidateViewModel()),
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
];
