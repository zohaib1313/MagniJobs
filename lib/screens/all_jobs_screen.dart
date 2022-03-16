import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/app_alert_bottom_sheet.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:provider/provider.dart';

import '../common_widgets/app_popups.dart';
import '../utils/my_app_bar.dart';

class AllJobScreen extends StatefulWidget {
  AllJobScreen({Key? key, allApplications}) : super(key: key);
  static const id = "AllJobScreen";

  @override
  _AllJobScreenState createState() => _AllJobScreenState();
}

class _AllJobScreenState extends State<AllJobScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<AllJobsViewModel>(myContext!, listen: true);

  @override
  void initState() {
    super.initState();
    view.searchJobPostedController.addListener(() {
      view.searchJobPosted();
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
          appBar: myAppBar(context: context, title: "Jobs Posted", actions: [
            MyAnimSearchBar(
              width: MediaQuery.of(context).size.width,
              onSuffixTap: () {
                view.searchJobPostedController.clear();
              },
              closeSearchOnSuffixTap: true,
              textController: view.searchJobPostedController,
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Container(
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
            child: view.filteredJobs.isEmpty
                ? const Center(
                    child: Text(
                        'No Job Found related to selected country and search'),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: 3,
                    itemCount: view.filteredJobs.length,
                    itemBuilder: (context, index) {
                      return getJobInforCard(view.filteredJobs[index]);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  getJobInforCard(Jobs job) {
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
            job.poster ?? "",
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
                        icon: "assets/icons/ic_file.svg", text: job.job ?? ""),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_location.svg",
                        text: job.location ?? ""),
                    SizedBox(height: 10.h),
                    rowInformation(
                        icon: "assets/icons/ic_currency.svg",
                        text: (job.salary ?? "") + " / Year"),
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
                                  Expanded(
                                      child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(children: [
                                      space,
                                      ExpandAbleTile(
                                          model: ExpandableTileModel(
                                              title: "Qualifications",
                                              message: job.qualification ?? "",
                                              isExpanded: false)),
                                      space,
                                      space,
                                      ExpandAbleTile(
                                          model: ExpandableTileModel(
                                              title: "Description",
                                              message: job.jobDescription ?? "",
                                              isExpanded: false)),
                                      space,
                                      space,
                                      space,
                                      Button(
                                        padding: 18.h,
                                        leftPadding: 400.w,
                                        rightPading: 400.w,
                                        buttonText: "Apply",
                                        textColor: AppColor.whiteColor,
                                        onTap: () {
                                          view.applyForJob(
                                              id: job.id ?? 0,
                                              completion: () {
                                                AppPopUps.showAlertDialog(
                                                    message:
                                                        'Application was sent successfully');
                                              });
                                        },
                                      ),
                                      space,
                                      space,
                                    ]),
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
                        view.applyForJob(
                            id: job.id ?? 0,
                            completion: () {
                              AppPopUps.showAlertDialog(
                                  message: 'Application was sent successfully');
                            });
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
        SvgViewer(
          svgPath: icon,
          color: AppColor.primaryBlueColor,
        ),
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
