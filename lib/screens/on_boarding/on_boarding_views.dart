import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/utils/app_constants.dart';

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
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
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
                            message: AppConstants.companyIntro,
                            isExpanded: true)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Goal",
                            message: AppConstants.companyGoals,
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
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
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
                            message: AppConstants.employerRecruitmentPlacement,
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benifits",
                            message:
                                "For CLIENTS such as employers and recruitment/placement agencies, the company offers: \n•Reduced expenses on recruitment process.\n• High quality and trained applicant.\n• Easy access to and communication with qualified   candidates.\n• Flexibility in advertising positions.",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "How to Navigate",
                            message:
                                '''Sign Up, Sign In, Job Posting, Accessing Country and Job ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Pricing",
                            message: "Information Provided",
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
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
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
                                '''Job seekers from across the world can benefit from this App, with communication
with clients and usage incredibly easy. With the MAGNIJOBS App, it is possible
to maintain visibility to all clients on the App and thus receive multiple offers. We
offer a video on how to navigate the App for applicants so that they can start
finding jobs fitting their skills as soon as possible ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benefits",
                            message:
                                '''For APPLICANTS, the company’s services are:
    • Easy to use and communicate with clients.
    • Allow applicants to receive multiple offers 
      from clients.
    • Increased visibility.
    • Applicants have the option to apply for an
      advertised job or just stand by until a client 
      shows interest in their profile.  ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Free to Use",
                            message:
                                '''The APP is free to use for all Job Seekers. Just sign up, sign in, then you’re ready to
explore. There will be free access to exam tutors as well. Tutors like for example but
not limited to IELTS FOR UKVI, OET, CBT, NCLEX and other exams necessary for
a job application abroad.
The APP will cater as a site for other service providers which include Emergency
Loan, Recruitment Companies, Food Delivery, Groceries and other useful websites
for our everyday need''',
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
