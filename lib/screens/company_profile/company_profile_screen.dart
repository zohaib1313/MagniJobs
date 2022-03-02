import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/models/countries_model.dart';
import 'package:magnijobs_rnr/screens/job_post/job_post_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/company_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/job_post_view_model.dart';
import 'package:provider/provider.dart';

import '../../profile_settting_screen.dart';
import '../../routes.dart';

class CompanyProfileScreen extends StatefulWidget {
  CompanyProfileScreen({Key? key}) : super(key: key);
  static const id = "CompanyProfileScreen";

  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  var view = Provider.of<CompanyProfileViewModel>(myContext!, listen: false);
  final space = SizedBox(height: 20.h);
  late Stream<List<Countries?>> streamCountries;
  late Stream<List<Jobs?>> streamJobs;

  @override
  void initState() {
    super.initState();
    streamCountries = view.loadCountries();
    streamJobs = view.loadJobs();
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
          appBar: myAppBar(title: "Company Profile", actions: [
            InkWell(
              onTap: () {
                Navigator.of(myContext!).push(MaterialPageRoute(
                    builder: (context) => ProfileSettingScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 18.0),
                child: SvgViewer(svgPath: 'assets/icons/ic_settings.svg'),
              ),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.only(
                left: 50.w,
                right: 50.w,
                top: 50.h,
                bottom: 50.h,
              ),
              margin: EdgeInsets.only(
                top: 50.h,
                bottom: 50.h,
                left: 100.w,
                right: 100.w,
              ),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.alphaGrey,
                    ),
                    padding: EdgeInsets.all(80.r),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 300.r,
                      child: Icon(
                        Icons.camera_alt,
                        size: 300.r,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.h, bottom: 20.h),
                    decoration: BoxDecoration(
                      color: AppColor.alphaGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r)),
                    ),
                    child: Column(
                      children: [
                        space,
                        Text(
                          "Recruiting For What Country?",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleBoldBodyMedium
                              .copyWith(color: AppColor.blackColor),
                        ),
                        space,
                        space,
                        StreamBuilder(
                          stream: streamCountries,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Countries?>> snapshot) {
                            if (snapshot.hasData) {
                              return MyDropDown(
                                onChange: (value) {
                                  view.selectedCountryId = value.toString();
                                },
                                hintText: "Country",
                                labelText: "",
                                labelColor: AppColor.redColor,
                                borderColor: AppColor.alphaGrey,
                                fillColor: AppColor.whiteColor,
                                suffixIcon: "assets/icons/drop_down_ic.svg",
                                itemFuntion: snapshot.data!
                                    .map((e) => DropdownMenuItem(
                                          value: e?.id.toString() ?? '',
                                          child: Text(
                                            e?.name ?? '',
                                            style: AppTextStyles
                                                .textStyleBoldBodySmall,
                                          ),
                                        ))
                                    .toList(),
                                validator: (string) {
                                  return null;
                                },
                              );
                            }
                            return Center(
                                child: Container(
                                    child: CircularProgressIndicator()));
                          },
                        ),
                        space,
                        StreamBuilder(
                          stream: streamJobs,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Jobs?>> snapshot) {
                            if (snapshot.hasData) {
                              return MyDropDown(
                                onChange: (value) {},
                                hintText: "Jobs",
                                labelText: "",
                                labelColor: AppColor.redColor,
                                borderColor: AppColor.alphaGrey,
                                fillColor: AppColor.whiteColor,
                                suffixIcon: "assets/icons/drop_down_ic.svg",
                                itemFuntion: snapshot.data!
                                    .map((e) => DropdownMenuItem(
                                          value: e?.id.toString() ?? '',
                                          child: Text(
                                            e?.job ?? '',
                                            style: AppTextStyles
                                                .textStyleBoldBodySmall,
                                          ),
                                        ))
                                    .toList(),
                                validator: (string) {
                                  return null;
                                },
                              );
                            }
                            return Center(
                                child: Container(
                                    child: CircularProgressIndicator()));
                          },
                        ),
                        space,
                        space,
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      space,
                      space,
                      space,
                      space,
                      Button(
                        buttonText: "Submit",
                        textColor: AppColor.whiteColor,
                        color: AppColor.primaryBlueDarkColor,
                        onTap: () {
                          if (view.selectedCountryId.isNotEmpty) {
                            Provider.of<JobPostViewModel>(myContext!,
                                    listen: false)
                                .getAllCompanies(completion: () {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (context) => JobPostScreen(
                                        selectedCountryId:
                                            view.selectedCountryId,
                                      )));
                            });
                          }
                        },
                      ),
                      space,
                      space,
                      space,
                      space,
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
