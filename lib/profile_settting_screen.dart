import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/chat/all_chats_page.dart';
import 'package:magnijobs_rnr/screens/choose_signin/choose_signin_screen.dart';
import 'package:magnijobs_rnr/screens/interested_applicants_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/interested_applicant_view_model.dart';
import 'package:magnijobs_rnr/view_models/profile_settings_view_model.dart';
import 'package:magnijobs_rnr/view_models/sigin_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_widgets/app_popups.dart';
import 'forgot_password_enter_mail_screen.dart';

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
            /* const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )*/
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.9,
              margin: EdgeInsets.only(top: 10.h, left: 20.h, right: 20.h),
              decoration: const BoxDecoration(
                color: AppColor.alphaGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    /*   padding: EdgeInsets.only(
                        top: 10.h, bottom: 20.h, left: 20.h, right: 20.h),*/
                    child: Column(
                      children: [
                        getRowProfileItem(
                            "assets/icons/ic_message.svg", "Chats", onTap: () {
                          Navigator.of(myContext!).pushNamed(AllChatPage.id);
                        }),
                        if (UserDefaults.getEmployerUserSession() != null)
                          getRowProfileItem("assets/icons/ic_edit_person.svg",
                              "Interested Applicants", onTap: () {
                            Provider.of<InterestedApplicantsViewModel>(
                                    myContext!,
                                    listen: false)
                                .getInterestedApplicants(completion: () {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (c) =>
                                      InterestedApplicantsScreen()));
                            });
                          }),
                        getRowProfileItem("assets/icons/ic_change_password.svg",
                            "Change Password", onTap: () {
                          AppPopUps.displayTextInputDialog(
                              title: "Enter mail where we will send OTP",
                              message: "Send Otp",
                              hint: "email",
                              onSubmit: (String text) {
                                if (text.isNotEmpty) {
                                  Provider.of<SignInViewModel>(myContext!,
                                          listen: false)
                                      .sendForgotPassword(
                                          completion: () {
                                            Navigator.of(myContext!).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordEnterMailScreen(
                                                  mail: text,
                                                ),
                                              ),
                                            );
                                          },
                                          mail: text);
                                }
                              });
                        }),
                        getRowProfileItem(
                            "assets/icons/ic_news_letter.svg", "Contact Us",
                            onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'marketing1_rnr@magnijobs.com',
                            query:
                                'subject=MagniJobs', //add subject and body here
                          );

                          var url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            AppPopUps.showAlertDialog(
                                message: 'Failed to launch mail');
                          }
                        }),

                        /*   getRowProfileItem("assets/icons/ic_notifications.svg",
                            "Notifications"),
                        getRowProfileItem(
                            "assets/icons/ic_settings.svg", "Privacy Settings"),
                        getRowProfileItem(
                            "assets/icons/ic_payment_.svg", "Payment"),*/
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<ProfileSettingViewModel>(myContext!,
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
                                  style: AppTextStyles.textStyleBoldBodyMedium,
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
                  /* Container(
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
                                  "assets/icons/ic_message.svg", "Chats",
                                  onTap: () {
                                Navigator.of(myContext!)
                                    .pushNamed(AllChatPage.id);
                              }),
                              getRowProfileItem(
                                  "assets/icons/ic_change_password.svg",
                                  "Change Password", onTap: () {
                                AppPopUps.displayTextInputDialog(
                                    title: "Enter mail where we will send OTP",
                                    message: "Send Otp",
                                    hint: "email",
                                    onSubmit: (String text) {
                                      if (text.isNotEmpty) {
                                        Provider.of<SignInViewModel>(myContext!,
                                                listen: false)
                                            .sendForgotPassword(
                                                completion: () {
                                                  Navigator.of(myContext!).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgotPasswordEnterMailScreen(
                                                        mail: text,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                mail: text);
                                      }
                                    });
                              }),
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
                  ),*/
                  /* Padding(
                    padding: EdgeInsets.all(60.r),
                    child: Text(
                      "More Options",
                      style: AppTextStyles.textStyleBoldSubTitleLarge
                          .copyWith(color: AppColor.primaryBlueColor),
                    ),
                  ),*/
                  /* Container(
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
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getRowProfileItem(String icon, String title, {String? endText, onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
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
      ),
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
