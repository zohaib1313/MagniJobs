import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/country_and_job_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/chat/chat_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/app_alert_bottom_sheet.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class CountryAndJobScreen extends StatefulWidget {
  CountryAndJobModel countryAndJobModel;

  static const id = "CountryAndJobScreen";

  CountryAndJobScreen({required this.countryAndJobModel});

  @override
  _CountryAndJobScreenState createState() => _CountryAndJobScreenState();
}

class _CountryAndJobScreenState extends State<CountryAndJobScreen> {
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
          appBar: myAppBar(title: "Country & Job", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: /*(widget.countryAndJobModel.candidates?.length ?? 0)*/ 1 != 0
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                      //  height: MediaQuery.of(context).size.height,
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
                      child: ListView.builder(
                          itemCount:
                              1 /*widget.countryAndJobModel.candidates?.length ?? 0*/,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getJobSeekerWidget();
                          })),
                )
              : Center(
                  child: Text(
                    'No Candidate',
                    style: AppTextStyles.textStyleBoldBodyMedium,
                  ),
                ),
        ),
      ),
    );
  }

  getJobSeekerWidget() {
    return Container(
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Job Seeker",
            style: AppTextStyles.textStyleBoldBodySmall,
          ),
          space,
          Text(
            "Rebecca James",
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.textStyleBoldSubTitleLarge
                .copyWith(color: AppColor.primaryBlueColor),
          ),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_location.svg",
                        text: "Bexel United Kingdom"),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_timer.svg", text: "29 Years"),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_person.svg", text: "British"),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_gender.svg", text: "Female"),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                      padding: 18.h,
                      buttonText: "VIEW",
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        BottomSheets().showBottomSheet(
                            context: context,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Job Seeker",
                                        style: AppTextStyles
                                            .textStyleNormalBodyMedium,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: AppColor.blackColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  space,
                                  Text("Rebecca James",
                                      style: AppTextStyles
                                          .textStyleBoldSubTitleLarge
                                          .copyWith(
                                              color:
                                                  AppColor.primaryBlueColor)),
                                  space,
                                  space,
                                  Expanded(
                                      child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        getBottomSheetRowInfo(),
                                        space,
                                        space,
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: rowInformation(
                                                    icon:
                                                        "assets/icons/ic_timer.svg",
                                                    text: "29 years")),
                                            Expanded(
                                              child: Button(
                                                cornerRadius: 25.r,
                                                padding: 18.h,
                                                buttonText: "Chat",
                                                textColor: AppColor.whiteColor,
                                                onTap: () {
                                                  Navigator.of(myContext!).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatScreen()));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        space,
                                        space,
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ));
                      },
                    ),
                    space,
                    Button(
                      padding: 18.h,
                      buttonText: "Chat",
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        Navigator.of(myContext!).push(MaterialPageRoute(
                            builder: (context) => ChatScreen()));
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  rowInformation({required String icon, required String text}) {
    return Row(
      children: [
        SvgViewer(svgPath: icon),
        SizedBox(width: 50.w),
        Flexible(
            child: Text(text, style: AppTextStyles.textStyleNormalBodyMedium)),
      ],
    );
  }

  getBottomSheetRowInfo() {
    return Column(
      children: [
        space,
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text("Martial Status"),
            ),
            Expanded(
              flex: 3,
              child: Button(
                cornerRadius: 25.r,
                padding: 18.h,
                buttonText: "Single",
                textColor: AppColor.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
