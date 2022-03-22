import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/applicant_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/employer_signup/employer_signup_screen.dart';
import 'package:magnijobs_rnr/screens/sign_in/sign_in_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../../routes.dart';
import '../tutor_sign_up_screen.dart';
import '../web_view_example.dart';

class ChooseSignInScreen extends StatefulWidget {
  ChooseSignInScreen({Key? key}) : super(key: key);
  static const id = "ChooseSignInScreen";

  @override
  _ChooseSignInScreenState createState() => _ChooseSignInScreenState();
}

class _ChooseSignInScreenState extends State<ChooseSignInScreen> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(title: "Welcome", goBack: false),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Employers
                Container(
                  margin: EdgeInsets.all(100.w),
                  padding: EdgeInsets.all(100.w),
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Companies",
                              style: AppTextStyles.textStyleBoldTitleLarge,
                            ),
                          ),
                        ],
                      ),
                      space,
                      Button(
                        buttonText: "Sign in",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          Navigator.of(myContext!).push(
                            MaterialPageRoute(
                              builder: (context) => SigInScreen(
                                userType: "employer",
                              ),
                            ),
                          );
                        },
                      ),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Don’t have not an account?",
                              style: AppTextStyles.textStyleBoldBodySmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(myContext!)
                                  .pushNamed(EmployerSignUpScreen.id);
                            },
                            child: Text(
                              " Sign up!",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
                          )
                        ],
                      ),
                      space,
                    ],
                  ),
                ),
                //applicant
                Container(
                  margin: EdgeInsets.all(100.w),
                  padding: EdgeInsets.all(100.w),
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Applicants",
                              style: AppTextStyles.textStyleBoldTitleLarge,
                            ),
                          ),
                        ],
                      ),
                      space,
                      Button(
                        buttonText: "Sign in",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          Navigator.of(myContext!).push(
                            MaterialPageRoute(
                              builder: (context) => SigInScreen(
                                userType: "applicant",
                              ),
                            ),
                          );
                        },
                      ),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Don’t have not an account?",
                              style: AppTextStyles.textStyleBoldBodySmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(myContext!)
                                  .pushNamed(ApplicantSignUp.id);
                            },
                            child: Text(
                              " Sign up!",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
                          )
                        ],
                      ),
                      space,
                    ],
                  ),
                ),
                //NMC
                SizedBox(height: 5.h),
                Button(
                  buttonText: "NMC OSCE",
                  leftPadding: 200.w,
                  rightPading: 200.w,
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Navigator.of(myContext!).push(MaterialPageRoute(
                        builder: (contet) => WebViewExample()));
                  },
                ),
                SizedBox(height: 5.h),
                Container(
                  margin: EdgeInsets.all(100.w),
                  padding: EdgeInsets.all(100.w),
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "English Exams\nTutors",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.textStyleBoldTitleLarge,
                            ),
                          ),
                        ],
                      ),
                      space,
                      Button(
                        buttonText: "Sign in",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          Navigator.of(myContext!).push(
                            MaterialPageRoute(
                              builder: (context) => SigInScreen(
                                userType: "tutor",
                              ),
                            ),
                          );
                        },
                      ),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Don’t have not an account?",
                              style: AppTextStyles.textStyleBoldBodySmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (contxt) => TutorSignUpScreen()));
                            },
                            child: Text(
                              " Sign up!",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
                          )
                        ],
                      ),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Attendies",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.textStyleBoldTitleLarge,
                            ),
                          ),
                        ],
                      ),
                      space,
                      Button(
                        buttonText: "Sign in",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          Navigator.of(myContext!).push(MaterialPageRoute(
                              builder: (c) => SigInScreen(
                                    userType: 'attendie',
                                  )));
                        },
                      ),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Don’t have not an account?",
                              style: AppTextStyles.textStyleBoldBodySmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (contxt) => ApplicantSignUp()));
                            },
                            child: Text(
                              " Sign up!",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
                          )
                        ],
                      ),
                      space,
                      space,
                    ],
                  ),
                ),
                space,
                space, space,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
