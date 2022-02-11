import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class SigInScreen extends StatefulWidget {
  SigInScreen({Key? key}) : super(key: key);
  static const id = "SigInScreen";

  @override
  _SigInScreenState createState() => _SigInScreenState();
}

class _SigInScreenState extends State<SigInScreen> {
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
          appBar: myAppBar(title: "Sign in"),
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
                  Column(
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
                            top: 20.r, bottom: 20.r, left: 80.r, right: 80.r),
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
                              rightPadding: 0,
                              hintText: "Email",
                              prefixIcon: "assets/icons/ic_mail.svg",
                              focusBorderColor: AppColor.primaryBlueDarkColor,
                              textColor: AppColor.blackColor,
                              hintColor: AppColor.blackColor,
                              fillColor: AppColor.alphaGrey,
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              hintText: "Password",
                              prefixIcon: "assets/icons/ic_lock.svg",
                              focusBorderColor: AppColor.primaryBlueDarkColor,
                              textColor: AppColor.blackColor,
                              hintColor: AppColor.blackColor,
                              fillColor: AppColor.alphaGrey,
                            ),
                            space,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: mySwitch(
                                      message: "Remember me",
                                      messageColor: AppColor.blackColor,
                                      fillColor: AppColor.primaryBlueColor,
                                      checkColor: AppColor.whiteColor,
                                      onTap: () {}),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password ?",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall,
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
                                //    Navigator.of(myContext!).pushNamed(AddPaymentScreen.id);
                              },
                            ),
                            space,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have not an account? ",
                                  style: AppTextStyles.textStyleNormalBodySmall,
                                ),
                                Text(
                                  "Sign Up!",
                                  style: AppTextStyles.textStyleNormalBodySmall
                                      .copyWith(
                                          color: AppColor.primaryBlueColor),
                                ),
                              ],
                            ),
                            space,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
