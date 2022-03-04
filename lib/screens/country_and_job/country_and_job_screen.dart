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
import 'package:provider/provider.dart';

import '../../models/all_jobs_model.dart';
import '../../utils/user_defaults.dart';
import '../../view_models/all_jobs_view_model.dart';
import '../job_posted/job_posted_screen.dart';

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
          floatingActionButton: Container(
            width: 500.w,
            height: 80.h,
            child: FloatingActionButton(
                backgroundColor: AppColor.primaryBlueColor,
                onPressed: () {
                  Provider.of<AllJobsViewModel>(myContext!, listen: false)
                      .getAllJobs(completion: (List<Jobs> jobs) {
                    Provider.of<AllJobsViewModel>(myContext!, listen: false)
                        .getFilterJobsOnEmployerId(
                            id: (UserDefaults?.getUserSession()?.user?.id ?? 0)
                                .toString(),
                            completion: (List<Jobs> jobss) {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (context) => JobPostedScreen()));
                            });
                  });
                },
                child: const Icon(Icons.arrow_forward)),
          ),
          appBar: myAppBar(title: "Country & Job", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: (widget.countryAndJobModel.candidates?.length ?? 0) != 0
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
                              widget.countryAndJobModel.candidates?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getJobSeekerWidget(
                                widget.countryAndJobModel.candidates![index]);
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

  getJobSeekerWidget(Candidates? candidate) {
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
            candidate?.firstName ?? '',
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
                        text: candidate?.location ?? ''),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_timer.svg",
                        text: candidate?.dob ?? ''),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_person.svg",
                        text: candidate?.nationality ?? ''),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_gender.svg",
                        text: candidate?.gender ?? ''),
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
                                  Text(candidate?.firstName ?? '-',
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
                                        getBottomSheetRowInfo('First Name',
                                            candidate?.firstName ?? "-"),
                                        getBottomSheetRowInfo('Last Name',
                                            candidate?.lastName ?? "-"),
                                        getBottomSheetRowInfo('Date of birth',
                                            candidate?.dob ?? "-"),
                                        getBottomSheetRowInfo('Nationality',
                                            candidate?.nationality ?? "-"),
                                        getBottomSheetRowInfo('Location',
                                            candidate?.location ?? "-"),
                                        getBottomSheetRowInfo(
                                            'Gender', candidate?.gender ?? "-"),
                                        getBottomSheetRowInfo('Martial Status',
                                            candidate?.maritalStatus ?? "-"),
                                        getBottomSheetRowInfo(
                                            'Mobile', candidate?.mobile ?? "-"),
                                        getBottomSheetRowInfo('Address',
                                            candidate?.address ?? "-"),
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

  getBottomSheetRowInfo(String key, String value) {
    return Column(
      children: [
        space,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(key),
            ),
            Expanded(
              flex: 3,
              child: Button(
                cornerRadius: 25.r,
                padding: 18.h,
                buttonText: value,
                textColor: AppColor.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
