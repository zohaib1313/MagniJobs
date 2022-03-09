import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/verify_number_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class VerifyNumberScreen extends StatefulWidget {
  VerifyNumberScreen({Key? key}) : super(key: key);
  static const id = "VerifyNumberScreen";

  @override
  _VerifyNumberScreenState createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final space = SizedBox(height: 20.h);
  final hSpace = SizedBox(width: 20.h);

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  var view = Provider.of<VerifyNumberViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
  }

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
          appBar: myAppBar(title: "Verifying Number"),
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
                      svgPath: "assets/icons/verify_number_ic.svg"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          child: view.isVerificationSent
                              ? getViewSent()
                              : getViewToSent(view, context)),
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

  getViewToSent(VerifyNumberViewModel view, context) {
    return Column(
      children: [
        space,
        Text(
          "We will send a code to \nthe Phone Number you registered\nto verify your information",
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleNormalBodySmall
              .copyWith(color: AppColor.blackColor),
        ),
        space,
        MyTextField(
          controller: view.phonenumberController,
          leftPadding: 0,
          rightPadding: 0,
          hintText: "Enter Phone Number",
          focusBorderColor: AppColor.primaryBlueDarkColor,
          textColor: AppColor.blackColor,
          hintColor: AppColor.blackColor,
          fillColor: AppColor.alphaGrey,
        ),
        space,
        Button(
          buttonText: "Send",
          textColor: AppColor.whiteColor,
          color: AppColor.primaryBlueDarkColor,
          onTap: () {
            view.checkMyNumber(completion: () {
              view.setIsVerificationSent(true);
              setState(() {});
            });
          },
        ),
        space,
      ],
    );
  }

  getViewSent() {
    return Column(
      children: [
        space,
        Text(
          "We have sent verification code to\n${view.phonenumberController.text}",
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleNormalBodySmall
              .copyWith(color: AppColor.blackColor),
        ),
        space,
        MyTextField(
          leftPadding: 0,
          controller: view.otpCodeController,
          rightPadding: 0,
          hintText: "Enter Code",
          focusBorderColor: AppColor.primaryBlueDarkColor,
          textColor: AppColor.blackColor,
          hintColor: AppColor.blackColor,
          fillColor: AppColor.alphaGrey,
        ),
        space,
        Button(
          buttonText: "Verify",
          textColor: AppColor.whiteColor,
          color: AppColor.primaryBlueDarkColor,
          onTap: () {
            printWrapped("verifying...");
             Navigator.of(myContext!).pop(true);

            ///todo
           /* if (view.otpCodeController.text.isNotEmpty) {
              view.verifyMyNumber(completion: () {
                Navigator.of(myContext!).pop(true);
              });
            }*/
          },
        ),
        space,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: view.timeEnd,
              child: GestureDetector(
                onTap: () {
                  view.checkMyNumber(completion: () {
                    view.isVerificationSent = true;
                    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                    view.setTimeEnd(false);
                    setState(() {});
                  });

                  // Navigator.of(myContext!)
                  //     .pushReplacementNamed(VerifyNumberScreen.id);
                },
                child: Text(
                  "Resend",
                  style: AppTextStyles.textStyleBoldBodyMedium.copyWith(
                      color: AppColor.blueColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            hSpace,
            Center(
              child: CountdownTimer(
                endTime: endTime,
                onEnd: () {
                  Future.delayed(Duration.zero, () async {
                    endTime = 0;
                    view.setTimeEnd(true);
                    view.setIsVerificationSent(true);
                    setState(() {});
                  });
                },
                widgetBuilder: (context, time) {
                  return Text(
                    '${time?.sec ?? 0} Sec Left',
                    style: AppTextStyles.textStyleBoldBodySmall,
                  );
                },
              ),
            )
          ],
        ),
        space,
      ],
    );
  }

/* void gotoRelevantScreenOnUserType() {
    String userType = UserDefaults?.getUserType() ?? "";
    printWrapped(userType);
    if (userType.isNotEmpty) {
      switch (userType) {
        case 'employer':
          Navigator.of(myContext!)
              .pushReplacementNamed(CompanyProfileScreen.id);
          break;
        case 'applicant':
          Navigator.of(myContext!)
              .pushReplacementNamed(EmployeePortalScreen.id);
          break;
        case 'tutor':
          Navigator.of(myContext!).pushReplacementNamed(TutorProfileScreen.id);

          break;
      }
    }
  }*/
}
