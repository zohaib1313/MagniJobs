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

import '../../utils/my_app_bar.dart';
import '../utils/user_defaults.dart';
import '../view_models/interested_applicant_view_model.dart';

class InterestedApplicantsScreen extends StatefulWidget {
  static const id = "InterestedApplicantsScreen";

  InterestedApplicantsScreen({Key? key}) : super(key: key);

  @override
  _InterestedApplicantsScreenState createState() =>
      _InterestedApplicantsScreenState();
}

class _InterestedApplicantsScreenState
    extends State<InterestedApplicantsScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<InterestedApplicantsViewModel>(myContext!);

  @override
  void initState() {
    super.initState();

    view.getJobTypes();
    view.searchTextController.addListener(() {
      view.searchFromList();
    });
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
          /*  floatingActionButton: Container(
            width: 500.w,
            height: 80.h,
            child: FloatingActionButton(
                backgroundColor: AppColor.primaryBlueColor,
                onPressed: () {
                  Provider.of<AllJobsViewModel>(myContext!, listen: false)
                    ..countryFilterJobSalaryController.clear()
                    ..searchJobPostedController.clear()
                    ..getMyJobs(completion: (List<Jobs> jobs) {
                      Navigator.of(myContext!).push(MaterialPageRoute(
                          builder: (context) => JobPostedScreen()));
                    });
                },
                child: const Icon(Icons.arrow_forward)),
          ),*/
          appBar: myAppBar(title: "Interested Applicants", actions: [
            MyAnimSearchBar(
              width: MediaQuery.of(context).size.width,
              onSuffixTap: () {
                view.searchTextController.clear();
              },
              closeSearchOnSuffixTap: true,
              textController: view.searchTextController,
            ),
            /*  Flexible(
              child: InkWell(
                onTap: () {
                  Navigator.of(myContext!).push(MaterialPageRoute(
                      builder: (context) => ProfileSettingScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: SvgViewer(svgPath: "assets/icons/ic_settings.svg"),
                ),
              ),
            )*/
          ]),
          backgroundColor: AppColor.alphaGrey,
          // ignore: prefer_is_empty
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(50.r)),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  view.filterOnVerified();
                                },
                                child: Text(
                                  "Verified",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                            ),
                          ),
                          Icon(view.isVerifiedFiltered
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 40.w),
                      color: AppColor.alphaGrey,
                      width: 2,
                      height: 50.h,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          view.isSortFiltered
                              ? Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                    ),
                                  ],
                                ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                view.filterJobsOnSort();
                              },
                              child: Text(
                                "Sort",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 40.w),
                      color: AppColor.alphaGrey,
                      width: 2,
                      height: 50.h,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt_rounded),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showBottom();
                              },
                              child: Text(
                                "Filter",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              (view.showingListOfCandidates.isNotEmpty)
                  ? Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
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
                                itemCount: view.showingListOfCandidates.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return getJobSeekerWidget(
                                      view.showingListOfCandidates[index]);
                                })),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          'No Candidate',
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                      ),
                    ),
            ],
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
        color: (candidate?.verified ?? 0) == 1
            ? AppColor.gold
            : AppColor.whiteColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Job Seeker",
                style: AppTextStyles.textStyleBoldBodySmall,
              ),
              (candidate?.verified ?? 0) != 1
                  ? /* Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('Not Verified'),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.not_interested_outlined,
                          color: Colors.red,
                        ),
                      ],
                    )*/
                  IgnorePointer()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Verified'),
                        const SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          'assets/images/green_certificate.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
            ],
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
                        text: getCountryNameFromId(candidate?.location ?? 0)
                                ?.name ??
                            ""),
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
                                        getBottomSheetRowInfo(
                                            'Location',
                                            getCountryNameFromId(
                                                        candidate?.location ??
                                                            0)
                                                    ?.name ??
                                                ""),
                                        getBottomSheetRowInfo(
                                            'Gender', candidate?.gender ?? "-"),
                                        getBottomSheetRowInfo('Martial Status',
                                            candidate?.maritalStatus ?? "-"),
                                        getBottomSheetRowInfo(
                                            'Mobile', candidate?.mobile ?? "-"),
                                        getBottomSheetRowInfo('Address',
                                            candidate?.address ?? "-"),
                                        getBottomSheetRowInfo('Certifications',
                                            candidate?.certifications ?? "-"),
                                        getBottomSheetRowInfo(
                                            'Exams', candidate?.exams ?? "-"),
                                        getBottomSheetRowInfo('Work Experience',
                                            candidate?.workExperience ?? "-"),
                                        getBottomSheetRowInfo('License',
                                            candidate?.license ?? "-"),
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
                                                          ChatScreen(
                                                        otherUserId: candidate!
                                                            .id!
                                                            .toString(),
                                                        otherUserImage: '',
                                                        otherUserName: candidate
                                                            .firstName!,
                                                        otherUserPhone:
                                                            candidate.mobile!,
                                                      ),
                                                    ),
                                                  );
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
                        Navigator.of(myContext!).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              otherUserId: candidate!.id!.toString(),
                              otherUserImage: '',
                              otherUserName: candidate.firstName!,
                              otherUserPhone: candidate.mobile!,
                            ),
                          ),
                        );
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

  void showBottom() {
    BottomSheets().showBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apply Filter",
                    style: AppTextStyles.textStyleNormalBodyMedium,
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
              space,
              MyDropDown(
                onChange: (value) {
                  view.filterLocation.text = value.id.toString();
                  Navigator.of(context).pop();
                  view.filterOnLocation();
                },
                hintText: "Location",
                labelText: "",
                itemAsString: (item) {
                  return item.name ?? '';
                },
                leftPadding: 0,
                value: view.filterLocation.text.isNotEmpty
                    ? getCountryNameFromId(int.parse(view.filterLocation.text))
                    : null,
                rightPadding: 0,
                labelColor: AppColor.redColor,
                borderColor: AppColor.alphaGrey,
                fillColor: AppColor.alphaGrey,
                suffixIcon: "assets/icons/drop_down_ic.svg",
                items: UserDefaults.getCountriesList()?.countries!,
                validator: (string) {
                  return null;
                },
              ),
              space,
              MyDropDown(
                onChange: (value) {
                  view.selectedJobType = value;
                  Navigator.of(context).pop();
                  view.filterJobOnJobType();
                },
                hintText: "Job Type",
                labelText: "",
                itemAsString: (item) {
                  return item.jobType ?? '';
                },
                leftPadding: 0,
                value: view.selectedJobType,
                rightPadding: 0,
                labelColor: AppColor.redColor,
                borderColor: AppColor.alphaGrey,
                fillColor: AppColor.alphaGrey,
                suffixIcon: "assets/icons/drop_down_ic.svg",
                items: view.jobTypeList,
                validator: (string) {
                  return null;
                },
              ),
              space,
              space,
              space,
              Button(
                buttonText: 'Clear Filter',
                textColor: AppColor.whiteColor,
                onTap: () {
                  Navigator.of(context).pop();
                  view.clearFilter();
                },
              ),
              space,
            ],
          ),
        ));
  }
}
