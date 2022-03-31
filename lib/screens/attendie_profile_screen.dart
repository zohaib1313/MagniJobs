import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/my_lesson_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/update_candidate_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:magnijobs_rnr/view_models/attendie_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../dio_network/APis.dart';
import '../profile_settting_screen.dart';
import '../utils/user_defaults.dart';
import '../view_models/profile_settings_view_model.dart';
import '../view_models/update_candidate_profile_view_model.dart';
import 'attendie_booked_lessons_screen.dart';
import 'attendie_calender.dart';
import 'choose_signin/choose_signin_screen.dart';
import 'my_applications_screen.dart';

class AttendieCandidateProfileScreen extends StatefulWidget {
  AttendieCandidateProfileScreen({Key? key}) : super(key: key);
  static const id = "AttendieProfileScreen";

  @override
  _AttendieCandidateProfileScreenState createState() =>
      _AttendieCandidateProfileScreenState();
}

class _AttendieCandidateProfileScreenState
    extends State<AttendieCandidateProfileScreen> {
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
          appBar: myAppBar(title: "Profile", actions: []),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              //  height: MediaQuery.of(context).size.height * 0.9,
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
                  imageEditWidget(),
                  space,
                  Container(
                    height: MediaQuery.of(context).size.height,
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
                          "assets/icons/ic_edit_person.svg",
                          "Profile",
                          onTap: () async {
                            await Navigator.of(myContext!).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateCandidateScreen()));
                            setState(() {});
                          },
                        ),
                        getRowProfileItem(
                            "assets/icons/ic_settings.svg", "Settings",
                            onTap: () {
                          Navigator.of(myContext!).push(MaterialPageRoute(
                              builder: (context) => ProfileSettingScreen()));
                        }),
                        getRowProfileItem(
                            "assets/icons/ic_history.svg", "Job History",
                            onTap: () {
                          Provider.of<AllJobsViewModel>(myContext!,
                                  listen: false)
                              .getAllJobs(completion: (allJobs) {
                            Provider.of<AttendieProfileViewModel>(myContext!,
                                    listen: false)
                                .allJobs = allJobs;
                            Provider.of<AttendieProfileViewModel>(myContext!,
                                    listen: false)
                                .getMyApplications(
                              completion: (allApplications) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyApplicationsScreen(
                                        allApplications: allApplications)));
                              },
                            );
                          });
                        }),
                        /* getRowProfileItem(
                            "assets/icons/ic_heart_filled.svg", "Favourite"),
                        getRowProfileItem(
                            "assets/icons/ic_location_black.svg", "Address"),*/
                        getRowProfileItem(
                            "assets/icons/ic_calender.svg", "Lessons",
                            onTap: () {
                          Provider.of<AttendieProfileViewModel>(myContext!,
                                  listen: false)
                              .getAllLessions(completion: (lessons) {
                            Navigator.of(myContext!).push(MaterialPageRoute(
                                builder: (myC) =>
                                    AttendieCalender.AttendieLessonBooking()));
                          });
                        }),
                        /*    getRowProfileItem(
                            "assets/icons/ic_calender.svg", "Calendar",
                            onTap: () {
                          Provider.of<AttendieProfileViewModel>(myContext!,
                                  listen: false)
                              .getAllLessions(completion: (lessons) {
                            Navigator.of(myContext!).push(
                              MaterialPageRoute(
                                builder: (myC) =>
                                    AttendieCalender.AttendieLessonBooking(
                                  showBookButton: false,
                                ),
                              ),
                            );
                          });
                        }),*/
                        getRowProfileItem(
                            "assets/icons/ic_calender.svg", "Calendar",
                            onTap: () {
                          Provider.of<AttendieProfileViewModel>(myContext!,
                                  listen: false)
                              .getMyLessonsBooking(
                                  completion: (MyLessonModel myLesson) {
                            Navigator.of(myContext!).push(
                              MaterialPageRoute(
                                builder: (myC) => AttendieBookedLessonScreen(),
                              ),
                            );
                          });
                        }),
                        /* getRowProfileItem(
                            "assets/icons/ic_file.svg", "Terms & Conditions"),
                        getRowProfileItem("assets/icons/ic_chat.svg", "Help"),*/
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<ProfileSettingViewModel>(myContext!,
                                    listen: false)
                                .logout(onComplete: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChooseSignInScreen()));
                            });
                          },
                          child: Row(
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
    return InkWell(
      onTap: () {
        Provider.of<UpdateCandidateProfileViewModel>(myContext!, listen: false)
            .getFile(onCompleteA: () {
          imageCache?.clear();
          imageCache?.clearLiveImages();
          setState(() {});
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
        margin: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        key: UniqueKey(),
                        radius: 250.r,
                        backgroundImage: (UserDefaults.getCandidateUserSession()
                                    ?.user
                                    ?.profile !=
                                null)
                            ? Image.network(
                                ApiConstants.profilePicsBaseUrl +
                                    (UserDefaults.getCandidateUserSession()
                                            ?.user
                                            ?.profile ??
                                        ""),
                                key: UniqueKey(),
                              ).image
                            : const AssetImage(
                                'assets/images/place_your_image.png'),
                      ),
                    ),
                    Positioned(
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
                    ),
                  ],
                ),
              ],
            ),
            space,
            Text(
              UserDefaults.getCandidateUserSession()?.user?.firstName ?? "",
              style: AppTextStyles.textStyleNormalBodySmall
                  .copyWith(color: AppColor.blackColor),
            ),
            space,
          ],
        ),
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
