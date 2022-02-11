import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/employer_signup/employer_signup_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../../routes.dart';

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
          appBar: myAppBar(title: "Welcome"),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                              "Employers",
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
                          Navigator.of(myContext!)
                              .pushNamed(EmployerSignUpScreen.id);
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
                          Text(
                            " Sign up!",
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(color: AppColor.primaryBlueColor),
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
                        onTap: () {},
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
                          Text(
                            " Sign up!",
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(color: AppColor.primaryBlueColor),
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
                  onTap: () {},
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
                        onTap: () {},
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
                          Text(
                            " Sign up!",
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(color: AppColor.primaryBlueColor),
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
                        onTap: () {},
                      ),
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
