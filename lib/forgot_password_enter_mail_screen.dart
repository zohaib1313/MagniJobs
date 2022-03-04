import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/forgot_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../routes.dart';

class ForgotPasswordEnterMailScreen extends StatefulWidget {
  static const id = "ForgotPasswordEnterMailScreen";
  final String mail;

  const ForgotPasswordEnterMailScreen({
    Key? key,
    required this.mail,
  }) : super(key: key);

  @override
  _ForgotPasswordEnterMailScreenState createState() =>
      _ForgotPasswordEnterMailScreenState();
}

class _ForgotPasswordEnterMailScreenState
    extends State<ForgotPasswordEnterMailScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<ForgotPasswordViewModel>(myContext!);

  @override
  Widget build(BuildContext context) {
    view.emailController.text = widget.mail;
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
                title: "Forgot Password",
                onTap: () {
                  view.resetState();
                  Navigator.of(context).pop();
                }),
            backgroundColor: AppColor.alphaGrey,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                            "Reset Password",
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
                                  enable: false,
                                  controller: view.emailController,
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
                                        view.hidePassword1 =
                                            !view.hidePassword1;
                                      },
                                      child: Icon(view.hidePassword1
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.visibility_off_outlined)),
                                  controller: view.passwordController,
                                  hintText: "Password",
                                  obsecureText: view.hidePassword1,
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
                                MyTextField(
                                  leftPadding: 0,
                                  rightPadding: 0,
                                  suffixIconWidet: GestureDetector(
                                      onTap: () {
                                        view.hidePassword2 =
                                            !view.hidePassword2;
                                      },
                                      child: Icon(view.hidePassword2
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.visibility_off_outlined)),
                                  controller: view.confirmPasswordController,
                                  hintText: "Confirm Password",
                                  obsecureText: view.hidePassword2,
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
                                MyTextField(
                                  leftPadding: 0,
                                  controller: view.otpController,
                                  rightPadding: 0,
                                  hintText: "Otp",
                                  focusBorderColor:
                                      AppColor.primaryBlueDarkColor,
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  fillColor: AppColor.alphaGrey,
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Enter Otp';
                                    }
                                    return null;
                                  },
                                ),
                                space,
                                Button(
                                  buttonText: "Reset",
                                  textColor: AppColor.whiteColor,
                                  color: AppColor.primaryBlueDarkColor,
                                  onTap: () {
                                    if (view.formKey.currentState!.validate()) {
                                      view.resetPassword(completion: () {
                                        printWrapped(
                                            '****password changed *****');
                                        AppPopUps.showAlertDialog(
                                            message: 'Password Reset Success');
                                      });
                                    }
                                  },
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
}
