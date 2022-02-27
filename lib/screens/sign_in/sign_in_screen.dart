import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/forgot_password_enter_mail_screen.dart';
import 'package:magnijobs_rnr/screens/applicant_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/employer_signup/employer_signup_screen.dart';
import 'package:magnijobs_rnr/screens/tutor_sign_up_screen.dart';
import 'package:magnijobs_rnr/screens/verify_number/verify_number_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/sigin_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class SigInScreen extends StatefulWidget {
  static const id = "SigInScreen";
  String userType = "";

  SigInScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  _SigInScreenState createState() => _SigInScreenState();
}

class _SigInScreenState extends State<SigInScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<SignInViewModel>(myContext!);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: WillPopScope(
        onWillPop: () {
          view.resetState();
          Navigator.of(context).pop();

          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: myAppBar(
                title: "Sign in",
                onTap: () {
                  view.resetState();
                  Navigator.of(context).pop();
                }),
            backgroundColor: AppColor.alphaGrey,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  left: 100.w,
                  right: 100.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgViewer(
                        width: double.infinity,
                        height: 500.h,
                        svgPath: "assets/icons/sign_in_ic.svg"),
                    Form(
                      key: view.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome!",
                            style: AppTextStyles.textStyleBoldTitleLarge
                                .copyWith(color: AppColor.primaryBlueColor),
                          ),
                          Text(
                            "Sign in to continue",
                            style: AppTextStyles.textStyleNormalLargeTitle
                                .copyWith(color: AppColor.blackColor),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 20.r,
                                bottom: 20.r,
                                left: 80.r,
                                right: 80.r),
                            margin: EdgeInsets.only(
                              top: 100.r,
                              bottom: 100.r,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Column(
                              children: [
                                space,
                                MyTextField(
                                  leftPadding: 0,
                                  controller: view.userNameController,
                                  rightPadding: 0,
                                  hintText: "Email",
                                  prefixIcon: "assets/icons/ic_mail.svg",
                                  focusBorderColor:
                                      AppColor.primaryBlueDarkColor,
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  fillColor: AppColor.alphaGrey,
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                                space,
                                MyTextField(
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  suffixIconWidet: GestureDetector(
                                      onTap: () {
                                        view.hidePassword = !view.hidePassword;
                                      },
                                      child: Icon(view.hidePassword
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.visibility_off_outlined)),
                                  controller: view.userPasswordController,
                                  hintText: "Password",
                                  obsecureText: view.hidePassword,
                                  prefixIcon: "assets/icons/ic_lock.svg",
                                  focusBorderColor:
                                      AppColor.primaryBlueDarkColor,
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  fillColor: AppColor.alphaGrey,
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: mySwitch(
                                          message: "Remember me",
                                          isActive: view.rememberMe,
                                          messageColor: AppColor.blackColor,
                                          fillColor: AppColor.primaryBlueColor,
                                          checkColor: AppColor.whiteColor,
                                          onTap: () {
                                            view.rememberMe = !view.rememberMe;
                                          }),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              AppPopUps.displayTextInputDialog(
                                                  title:
                                                      "Enter mail where we will send OTP",
                                                  message: "Send Otp",
                                                  hint: "email",
                                                  onSubmit: (String text) {
                                                    if (text.isNotEmpty) {
                                                      view.sendForgotPassword(
                                                          completion: () {
                                                            Navigator.of(
                                                                    myContext!)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ForgotPasswordEnterMailScreen(),
                                                              ),
                                                            );
                                                          },
                                                          mail: text);
                                                    }
                                                  });
                                            },
                                            child: Text(
                                              "Forgot Password ?",
                                              style: AppTextStyles
                                                  .textStyleNormalBodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                space,
                                Button(
                                  buttonText: "Sign in",
                                  textColor: AppColor.whiteColor,
                                  color: AppColor.primaryBlueDarkColor,
                                  onTap: () {
                                    // Navigator.of(myContext!)
                                    //     .pushNamed(VerifyNumberScreen.id);
                                    if (view.formKey.currentState!.validate()) {
                                      view.signInUser(widget.userType,
                                          completion: () {
                                        printWrapped('****Signed in*****');
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              VerifyNumberScreen(),
                                        ));
                                      });
                                    }
                                  },
                                ),
                                space,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have not an account? ",
                                      style: AppTextStyles
                                          .textStyleNormalBodySmall,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        gotoReleventSignup(widget.userType);
                                      },
                                      child: Text(
                                        "Sign Up!",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color:
                                                    AppColor.primaryBlueColor),
                                      ),
                                    ),
                                  ],
                                ),
                                space,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void gotoReleventSignup(String userType) {
    switch (userType) {
      case "employer":
        Navigator.of(myContext!).pushNamed(EmployerSignUpScreen.id);
        break;
      case "applicant":
        Navigator.of(myContext!).pushNamed(ApplicantSignUp.id);
        break;
      case "tutor":
        Navigator.of(myContext!).pushNamed(TutorSignUpScreen.id);
        break;
    }
  }
}
