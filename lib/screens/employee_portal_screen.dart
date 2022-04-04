import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/profile_settting_screen.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/update_candidate_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_portal_view_model.dart';
import 'package:magnijobs_rnr/view_models/update_candidate_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../models/all_jobs_model.dart';
import '../models/countries_model.dart';
import '../view_models/company_profile_view_model.dart';
import 'all_jobs_screen.dart';
import 'attendie_profile_screen.dart';

class EmployeePortalScreen extends StatefulWidget {
  const EmployeePortalScreen({Key? key}) : super(key: key);
  static const id = "EmployeePortalScreen";

  @override
  _EmployeePortalScreenState createState() => _EmployeePortalScreenState();
}

class _EmployeePortalScreenState extends State<EmployeePortalScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<EmployerPortalViewModel>(myContext!, listen: false);

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
          appBar: myAppBar(title: "Applicant Portal", goBack: false, actions: [
            InkWell(
              onTap: () async {
                if (UserDefaults.getUserType() == 'attendie') {
                  await Navigator.of(myContext!).push(MaterialPageRoute(
                      builder: (context) => AttendieCandidateProfileScreen()));
                  setState(() {});
                } else {
                  await Navigator.of(myContext!).push(MaterialPageRoute(
                      builder: (context) => ProfileSettingScreen()));
                  setState(() {});
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: SvgViewer(svgPath: "assets/icons/ic_settings.svg"),
              ),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Builder(builder: (context) {
            return SingleChildScrollView(
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
                child: Column(
                  children: [
                    imageEditWidget(),
                    space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          UserDefaults.getCandidateUserSession()
                                  ?.user
                                  ?.firstName ??
                              "",
                          style: AppTextStyles.textStyleBoldSubTitleLarge,
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        /*  Container(
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
                        ),*/
                      ],
                    ),
                    space,
                    Text(
                      UserDefaults.getCandidateUserSession()?.user?.utype ?? "",
                      style: AppTextStyles.textStyleNormalBodySmall
                          .copyWith(color: AppColor.greyColor),
                    ),
                    space,
                    Button(
                      leftPadding: 200.w,
                      rightPading: 200.w,
                      buttonText: "Update Profile",
                      textColor: AppColor.whiteColor,
                      onTap: () async {
                        await Navigator.of(myContext!).push(MaterialPageRoute(
                            builder: (context) => UpdateCandidateScreen()));
                        setState(() {});
                      },
                    ),
                    space,
                    space,
                    Text(
                      "Job Preferences",
                      style: AppTextStyles.textStyleBoldSubTitleLarge,
                    ),
                    space,
                    StreamBuilder(
                      stream: Provider.of<CompanyProfileViewModel>(myContext!,
                              listen: false)
                          .loadCountries(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Countries?>> snapshot) {
                        if (snapshot.hasData) {
                          return MyDropDown(
                            onChange: (value) {
                              view.selectedCountryId = value.id.toString();
                            },
                            hintText: "Location",
                            labelText: "",
                            itemAsString: (item) {
                              return item.name ?? '';
                            },
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.alphaGrey,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: snapshot.data!,
                            validator: (string) {
                              if (view.selectedCountryId == null) {
                                return 'select country';
                              }
                              return null;
                            },
                          );
                        }
                        return Center(
                            child:
                                Container(child: CircularProgressIndicator()));
                      },
                    ),
                    space,
                    StreamBuilder(
                      stream: Provider.of<CompanyProfileViewModel>(myContext!,
                              listen: false)
                          .loadJobs(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Jobs?>> snapshot) {
                        if (snapshot.hasData) {
                          return MyDropDown(
                            onChange: (value) {
                              if (value.id.toString() != '-1') {
                                view.showQueryField = false;
                                view.queryEditingController.text =
                                    value.job ?? "";
                              } else {
                                view.showQueryField = true;
                              }
                            },
                            hintText: "Jobs",
                            labelText: "",
                            itemAsString: (a) {
                              return a.job ?? '';
                            },
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: getListOfJobs(snapshot),
                            validator: (string) {
                              return null;
                            },
                          );
                        }
                        return Center(
                            child:
                                Container(child: CircularProgressIndicator()));
                      },
                    ),
                    space,
                    /* Provider.of<EmployerPortalViewModel>(myContext!,
                                listen: true)
                            .showQueryField
                        ? MyTextField(
                            fillColor: AppColor.whiteColor,
                            textColor: AppColor.blackColor,
                            hintColor: AppColor.blackColor,
                            labelColor: AppColor.blackColor,
                            hintText: "search job",
                            controller: view.queryEditingController,
                            labelText: "Jobs",
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          )
                        : Container(),
                    space,*/
                    Button(
                      leftPadding: 200.w,
                      rightPading: 200.w,
                      buttonText: "Browse Jobs Posted",
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        if (view.selectedCountryId != null) {
                          if (view.showQueryField) {
                            Provider.of<AllJobsViewModel>(myContext!,
                                    listen: false)
                                .getAllJobs(
                              completion: (allJobs) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AllJobScreen()));
                              },
                            );
                          } else if (view
                              .queryEditingController.text.isNotEmpty) {
                            Provider.of<AllJobsViewModel>(myContext!,
                                    listen: false)
                                .getJobBasedOnCountry(
                              countryId: view.selectedCountryId ?? '',
                              query: view.queryEditingController.text,
                              completion: (allJobs) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AllJobScreen()));
                              },
                            );
                          } else {
                            AppPopUps.showSnackvBar(
                                message: 'Select job', context: context);
                          }
                        } else {
                          AppPopUps.showSnackvBar(
                              message: 'Select country', context: context);
                        }
                      },
                    ),
                    space,
                  ],
                ),
              ),
            );
          }),
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
        padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
        margin: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: !(UserDefaults.getCandidateUserSession()
                          ?.candidateModel
                          ?.verified ??
                      false)
                  ? /*Row(
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
            ),
            space,
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
                        key: UniqueKey(),
                        backgroundImage: Provider.of<
                                            UpdateCandidateProfileViewModel>(
                                        myContext!,
                                        listen: false)
                                    .profilePicImage !=
                                null
                            ? (Image.file(Provider.of<
                                            UpdateCandidateProfileViewModel>(
                                        myContext!,
                                        listen: false)
                                    .profilePicImage!)
                                .image)
                            : (UserDefaults.getCandidateUserSession()
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
          ],
        ),
      ),
    );
  }

  getListOfJobs(AsyncSnapshot<List<Jobs?>> snapshot) {
    List<Jobs> list = [];
    list.add(Jobs(job: "Other", id: -1));

    for (var e in snapshot.data!) {
      list.add(e!);
    }

    return list;
  }
}
