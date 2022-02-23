import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/company_profile/company_profile_screen.dart';
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
  bool isVerificationSent = false;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;

  @override
  Widget build(BuildContext context) {
    var view = Provider.of<VerifyNumberViewModel>(myContext!);

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
                          child: isVerificationSent
                              ? getViewToSent()
                              : getViewSent(view, context)),
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

  getViewSent(VerifyNumberViewModel view, context) {
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
            setState(() {
              isVerificationSent = true;
              view.checkmynumber();
            });
          },
        ),
        space,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verification Code sent to +444******** ",
              style: AppTextStyles.textStyleNormalBodySmall,
            ),
          ],
        ),
        space,
      ],
    );
  }

  getViewToSent() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    return Column(
      children: [
        space,
        Text(
          "We have sent verification code to\n+44444444444",
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleNormalBodySmall
              .copyWith(color: AppColor.blackColor),
        ),
        space,
        MyTextField(
          leftPadding: 0,
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
            Navigator.of(myContext!).pushNamed(CompanyProfileScreen.id);
          },
        ),
        space,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: CountdownTimer(
                endTime: endTime,
                onEnd: () {
                  /*  setState(() {
                    isVerificationSent = false;
                  });*/
                },
                widgetBuilder: (context, time) {
                  if (time == null) {}
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
}
