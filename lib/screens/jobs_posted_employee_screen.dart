import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/app_alert_bottom_sheet.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

///not being used
class JobPostedEmployeeScreen extends StatefulWidget {
  JobPostedEmployeeScreen({Key? key}) : super(key: key);
  static const id = "JobPostedEmployeeScreen";

  @override
  _JobPostedEmployeeScreenState createState() =>
      _JobPostedEmployeeScreenState();
}

class _JobPostedEmployeeScreenState extends State<JobPostedEmployeeScreen> {
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
          appBar: myAppBar(title: "Jobs Posted", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
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
              child: Column(
                children: [
                  getJobPostedCompanyWidget(),
                  getJobPostedCompanyWidget(),
                  getJobPostedCompanyWidget(),
                  getJobPostedCompanyWidget(),
                  getJobPostedCompanyWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getJobPostedCompanyWidget() {
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
            "Company",
            style: AppTextStyles.textStyleBoldBodySmall,
          ),
          space,
          Text(
            "CARE247SOLUTIONS",
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
                        icon: "assets/icons/ic_file.svg",
                        text: "Registered Nurse"),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_location.svg",
                        text: "Bexel, United Kingdom"),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_location.svg",
                        text: "\$250k /year"),
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
                                        "",
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
                                  space,
                                  Expanded(
                                      child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        ExpandAbleTile(
                                            model: ExpandableTileModel(
                                                title: "Qualifications",
                                                message:
                                                    "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                                                isExpanded: false)),
                                        space,
                                        ExpandAbleTile(
                                            model: ExpandableTileModel(
                                                title: "Job Description",
                                                message:
                                                    "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                                                isExpanded: false)),
                                        space,
                                        space,
                                        Button(
                                          width: 180.h,
                                          height: 75.h,
                                          cornerRadius: 25.r,
                                          leftPadding: 0,
                                          rightPading: 0,
                                          padding: 18.h,
                                          buttonText: "Apply",
                                          textColor: AppColor.whiteColor,
                                          onTap: () {
                                            /*     Navigator.of(myContext!).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(ca)));*/
                                          },
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
                      buttonText: "Apply",
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        /* Navigator.of(myContext!).push(MaterialPageRoute(
                            builder: (context) => ChatScreen()));*/
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
}
