import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';

import '../../styles.dart';

class OnBoardingOurCompanyInfo extends StatefulWidget {
  const OnBoardingOurCompanyInfo({Key? key}) : super(key: key);

  @override
  _OnBoardingOurCompanyInfoState createState() =>
      _OnBoardingOurCompanyInfoState();
}

class _OnBoardingOurCompanyInfoState extends State<OnBoardingOurCompanyInfo> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 200.w, right: 200.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("Our Company",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Introduction",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: true)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Goal",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////For Clients//////////

class OnBoardingForClients extends StatefulWidget {
  const OnBoardingForClients({Key? key}) : super(key: key);

  @override
  _OnBoardingForClientsState createState() => _OnBoardingForClientsState();
}

class _OnBoardingForClientsState extends State<OnBoardingForClients> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 200.w, right: 200.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("For Clients",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title:
                                "Employers, Recruitment Agencies, Placement Agencies",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benifits",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benifits",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "How to Navigate",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Pricing",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///////////////For Applicants//////////

class OnBoardingForApplicant extends StatefulWidget {
  const OnBoardingForApplicant({Key? key}) : super(key: key);

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<OnBoardingForApplicant> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 200.w, right: 200.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("For Applicants",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Job Seekers",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benifits",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Free to Use",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
