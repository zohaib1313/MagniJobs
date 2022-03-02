import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/choose_signin/choose_signin_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/profile_settings_view_model.dart';
import 'package:provider/provider.dart';

class ProfileSettingScreen extends StatefulWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);
  static const id = "ProfileSettingScreen";

  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
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
          appBar: myAppBar(title: "Setting", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.9,
              margin: EdgeInsets.only(top: 140.h, left: 20.h, right: 20.h),
              decoration: const BoxDecoration(
                color: AppColor.alphaGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space,
                  Container(
                    //height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                          bottomLeft: Radius.circular(0.r),
                          bottomRight: Radius.circular(0.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.primaryBlueColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(40.r),
                                bottomLeft: Radius.circular(0.r),
                                bottomRight: Radius.circular(0.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(60.r),
                            child: Text(
                              "Accounts",
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 20.h, left: 20.h, right: 20.h),
                          child: Column(
                            children: [
                              getRowProfileItem(
                                  "assets/icons/ic_change_password.svg",
                                  "Change Password"),
                              getRowProfileItem(
                                  "assets/icons/ic_notifications.svg",
                                  "Notifications"),
                              getRowProfileItem("assets/icons/ic_settings.svg",
                                  "Privacy Settings"),
                              getRowProfileItem(
                                  "assets/icons/ic_payment_.svg", "Payment"),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<ProfileSettingViewModel>(
                                          myContext!,
                                          listen: false)
                                      .logout(onComplete: () {
                                    UserDefaults().clearAll();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseSignInScreen()));
                                  });
                                },
                                child: Row(
                                  children: [
                                    const SvgViewer(
                                        svgPath: "assets/icons/ic_logout.svg"),
                                    SizedBox(
                                      width: 35.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Sign out",
                                        style: AppTextStyles
                                            .textStyleBoldBodyMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(60.r),
                    child: Text(
                      "More Options",
                      style: AppTextStyles.textStyleBoldSubTitleLarge
                          .copyWith(color: AppColor.primaryBlueColor),
                    ),
                  ),
                  Container(
                    //height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 20.h, left: 20.h, right: 20.h),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                          bottomLeft: Radius.circular(0.r),
                          bottomRight: Radius.circular(0.r)),
                    ),
                    child: Column(
                      children: [
                        getRowProfileItemWithSwitch(
                            "assets/icons/ic_news_letter.svg", "News Letter"),
                        getRowProfileItemWithSwitch(
                            "assets/icons/ic_message.svg", "Text Message"),
                        getRowProfileItemWithSwitch(
                            "assets/icons/ic_phone_call.svg", "Phone Call"),
                        getRowProfileItem(
                            "assets/icons/ic_currency.svg", "Currency",
                            endText: "\$USD"),
                        getRowProfileItem(
                            "assets/icons/ic_language.svg", "Language",
                            endText: "English"),
                        getRowProfileItem(
                            "assets/icons/ic_link.svg", "Linked Accounts",
                            endText: "Facebook,Google,Twitter"),
                      ],
                    ),
                  ),
                  /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rebeca James",
                        style: AppTextStyles.textStyleBoldSubTitleLarge,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              100.r,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  space,
                  Text(
                    "Registered Nurse",
                    style: AppTextStyles.textStyleNormalBodySmall
                        .copyWith(color: AppColor.greyColor),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getRowProfileItem(String icon, String title, {String? endText}) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            SvgViewer(svgPath: icon),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Row(
              children: [
                Text(
                  endText ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textStyleNormalBodySmall
                      .copyWith(color: AppColor.greyColor),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  getRowProfileItemWithSwitch(String icon, String title) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            SvgViewer(svgPath: icon),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: false,
                onChanged: (bool value) {},
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
