import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../profile_settting_screen.dart';
import 'tutor_calender_screen.dart';

class TutorProfileScreen extends StatefulWidget {
  TutorProfileScreen({Key? key}) : super(key: key);
  static const id = "TutorProfileScreen";

  @override
  _TutorProfileScreenState createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
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
          appBar: myAppBar(title: "Profile", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.only(
                left: 50.w,
                right: 50.w,
              ),
              decoration: BoxDecoration(
                color: AppColor.alphaGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  space,
                  space,
                  imageEditWidget(),
                  Spacer(),
                  Container(
                    //height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 20.h, left: 20.h, right: 20.h),
                    margin: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Column(
                      children: [
                        getRowProfileItem(
                            "assets/icons/ic_edit_person.svg", "Profile"),
                        getRowProfileItem(
                            "assets/icons/ic_settings.svg", "Settings",
                            onTap: () {
                          Navigator.of(myContext!).push(MaterialPageRoute(
                              builder: (context) => ProfileSettingScreen()));
                        }),
                        getRowProfileItem(
                            "assets/icons/ic_history.svg", "Job History"),
                        getRowProfileItem(
                            "assets/icons/ic_heart_filled.svg", "Favourite"),
                        getRowProfileItem(
                            "assets/icons/ic_location_black.svg", "Address"),
                        getRowProfileItem(
                            "assets/icons/ic_calender.svg", "Calender",
                            onTap: () {
                          Navigator.of(myContext!).push(MaterialPageRoute(
                              builder: (context) => TutorCalenderScreen()));
                        }),
                        getRowProfileItem(
                            "assets/icons/ic_file.svg", "Terms & Conditions"),
                        getRowProfileItem("assets/icons/ic_chat.svg", "Help"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SvgViewer(svgPath: "assets/icons/ic_logout.svg"),
                            SizedBox(
                              width: 35.w,
                            ),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
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

  imageEditWidget() {
    return Container(
      padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
      margin: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 250.r,
                    backgroundColor: Colors.grey.shade200,
                    child: CircleAvatar(
                      radius: 250.r,
                      backgroundImage: const AssetImage(
                          'assets/images/place_your_image.png'),
                    ),
                  ),
                  /*   Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            150.r,
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
          space,
          Text(
            "Rebeca James",
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
        ],
      ),
    );
  }

  getRowProfileItem(String icon, String title, {onTap}) {
    return GestureDetector(
      onTap: onTap,
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
              Icon(Icons.navigate_next),
            ],
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}