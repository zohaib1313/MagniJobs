import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/models/countries_model.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/company_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/job_type_model.dart';
import '../../profile_settting_screen.dart';
import '../../routes.dart';
import '../../view_models/all_packges_view_model.dart';
import '../../view_models/country_and_job_view_model.dart';
import '../country_and_job/country_and_job_screen.dart';
import '../job_post/job_post_screen.dart';
import '../packages_/packages_screen.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);
  static const id = "CompanyProfileScreen";

  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  var view = Provider.of<CompanyProfileViewModel>(myContext!, listen: false);
  final space = SizedBox(height: 20.h);
  late Stream<List<Countries?>> streamCountries;
  late Stream<List<Jobs?>> streamJobs;
  String? logo = UserDefaults.getEmployerUserSession()?.employerModel?.logo;

  @override
  void initState() {
    streamCountries = view.loadCountries();
    streamJobs = view.loadJobs();
    view.setPreferedLocations();
    super.initState();
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
          appBar: myAppBar(title: 'Company & Profile', goBack: false, actions: [
            InkWell(
              onTap: () {
                Navigator.of(myContext!).push(MaterialPageRoute(
                    builder: (context) => ProfileSettingScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: SvgViewer(svgPath: "assets/icons/ic_settings.svg"),
              ),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(
                left: 100.w,
                right: 100.w,
                top: 50.h,
                bottom: 50.h,
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
                  imageEditWidget(),
                  Container(
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
                          stream: Provider.of<CompanyProfileViewModel>(
                                  myContext!,
                                  listen: false)
                              .loadCountries(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Countries?>> snapshot) {
                            if (snapshot.hasData) {
                              return MyDropDown(
                                onChange: (value) {
                                  view.selectedCountryId = value.id.toString();
                                },
                                hintText: "Country",
                                labelText: "",
                                itemAsString: (item) {
                                  return item.name ?? '';
                                },
                                labelColor: AppColor.redColor,
                                borderColor: AppColor.alphaGrey,
                                fillColor: AppColor.whiteColor,
                                suffixIcon: "assets/icons/drop_down_ic.svg",
                                items: snapshot.data!,
                                validator: (string) {
                                  return null;
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        space,
                        /* StreamBuilder(
                          stream: Provider.of<CompanyProfileViewModel>(
                                  myContext!,
                                  listen: false)
                              .loadJobs(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Jobs?>> snapshot) {
                            if (snapshot.hasData) {
                              return MyDropDown(
                                onChange: (value) {
                                  view.queryEditingController.text =
                                      value.job ?? "";
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
                                child: Container(
                                    child: CircularProgressIndicator()));
                          },
                        ),
*/
                        StreamBuilder(
                          stream: Provider.of<CountryAndJobViewModel>(
                                  myContext!,
                                  listen: false)
                              .getJobTypes(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Jobtypes?>> snapshot) {
                            if (snapshot.hasData) {
                              return MyDropDown(
                                onChange: (value) {
                                  Provider.of<CountryAndJobViewModel>(
                                          myContext!,
                                          listen: false)
                                      .selectedJobType = value;
                                  Provider.of<CountryAndJobViewModel>(
                                          myContext!,
                                          listen: false)
                                      .getJobSubTypes();
                                },
                                hintText: "Jobs",
                                labelText: "",
                                itemAsString: (item) {
                                  return item.jobType ?? '';
                                },
                                labelColor: AppColor.redColor,
                                borderColor: AppColor.alphaGrey,
                                fillColor: AppColor.whiteColor,
                                value: Provider.of<CountryAndJobViewModel>(
                                        myContext!,
                                        listen: false)
                                    .selectedJobType,
                                suffixIcon: "assets/icons/drop_down_ic.svg",
                                items: snapshot.data!,
                                validator: (string) {
                                  if (Provider.of<CountryAndJobViewModel>(
                                              myContext!,
                                              listen: false)
                                          .selectedJobType ==
                                      null) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
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
                      Button(
                        buttonText: "Submit",
                        textColor: AppColor.whiteColor,
                        color: AppColor.primaryBlueDarkColor,
                        onTap: () {
                          if (view.selectedCountryId.isNotEmpty &&
                              Provider.of<CountryAndJobViewModel>(myContext!,
                                          listen: false)
                                      .selectedJobType !=
                                  null) {
                            Provider.of<CountryAndJobViewModel>(myContext!,
                                    listen: false)
                                .getAllCandidates(completion: () {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (c) => CountryAndJobScreen()));
                            });
                          } else {
                            AppPopUps.showAlertDialog(
                                message: 'Enter all fields');
                          }
                        },
                      ),
                      space,
                      space,
                      Button(
                        buttonText: "Job Posting",
                        textColor: AppColor.whiteColor,
                        color: AppColor.primaryBlueDarkColor,
                        onTap: () {
                          view.getSubscriptions(onCompleteA: (status) {
                            if (status != -1) {
                              Navigator.of(myContext!).push(
                                MaterialPageRoute(
                                  builder: (context) => JobPostScreen(
                                    selectedCountryId: view.selectedCountryId,
                                    updateId: null,
                                  ),
                                ),
                              );
                            } else {
                              AppPopUps.showAlertDialog(
                                  message:
                                      'You are not subscribed to any package or package has been consumed, kindly subscribe to post a job',
                                  onSubmit: () {
                                    Navigator.of(myContext!).pop();
                                    Provider.of<AllPackagesAndPaymentViewModel>(
                                            myContext!,
                                            listen: false)
                                        .getAllPackages(completion: () {
                                      Navigator.of(myContext!)
                                          .pushNamed(PackagesScreen.id);
                                    });
                                  });
                            }
                          });
                        },
                      ),
                      space,
                      space,
                      /* Button(
                        buttonText: 'Preferred Locations',
                        textColor: AppColor.whiteColor,
                        color: AppColor.primaryBlueDarkColor,
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
                                    MyDropDown(
                                      onChange: (value) {
                                        view.pereferdLocation1.text =
                                            value.toString();
                                      },
                                      hintText: getCountryNameFromId(
                                            (int.parse(
                                                view.pereferdLocation1.text)),
                                          )?.name ??
                                          "Preferred Location",
                                      labelText: "",
                                      itemAsString: (item) {
                                        return item.name ?? '';
                                      },
                                      leftPadding: 0,
                                      rightPadding: 0,
                                      labelColor: AppColor.redColor,
                                      borderColor: AppColor.alphaGrey,
                                      fillColor: AppColor.alphaGrey,
                                      suffixIcon:
                                          "assets/icons/drop_down_ic.svg",
                                      items: UserDefaults.getCountriesList()
                                          ?.countries!,
                                      validator: (string) {
                                        return null;
                                      },
                                    ),
                                    space,
                                    MyDropDown(
                                      onChange: (value) {
                                        view.pereferdLocation2.text =
                                            value.toString();
                                      },
                                      hintText: getCountryNameFromId(
                                            (int.parse(
                                                view.pereferdLocation2.text)),
                                          )?.name ??
                                          "Preferred Location",
                                      labelText: "",
                                      itemAsString: (item) {
                                        return item.name ?? '';
                                      },
                                      leftPadding: 0,
                                      rightPadding: 0,
                                      labelColor: AppColor.redColor,
                                      borderColor: AppColor.alphaGrey,
                                      fillColor: AppColor.alphaGrey,
                                      suffixIcon:
                                          "assets/icons/drop_down_ic.svg",
                                      items: UserDefaults.getCountriesList()
                                          ?.countries!,
                                      validator: (string) {
                                        return null;
                                      },
                                    ),
                                    space,
                                    MyDropDown(
                                      onChange: (value) {
                                        view.pereferdLocation3.text =
                                            value.toString();
                                      },
                                      hintText: getCountryNameFromId(
                                            (int.parse(
                                                view.pereferdLocation3.text)),
                                          )?.name ??
                                          "Preferred Location",
                                      labelText: "",
                                      itemAsString: (item) {
                                        return item.name ?? '';
                                      },
                                      leftPadding: 0,
                                      rightPadding: 0,
                                      labelColor: AppColor.redColor,
                                      borderColor: AppColor.alphaGrey,
                                      fillColor: AppColor.alphaGrey,
                                      suffixIcon:
                                          "assets/icons/drop_down_ic.svg",
                                      items: UserDefaults.getCountriesList()
                                          ?.countries!,
                                      validator: (string) {
                                        return null;
                                      },
                                    ),
                                    space,
                                    MyDropDown(
                                      onChange: (value) {
                                        view.pereferdLocation4.text =
                                            value.toString();
                                      },
                                      hintText: getCountryNameFromId(
                                            (int.parse(
                                                view.pereferdLocation4.text)),
                                          )?.name ??
                                          "Preferred Location",
                                      labelText: "",
                                      itemAsString: (item) {
                                        return item.name ?? '';
                                      },
                                      leftPadding: 0,
                                      rightPadding: 0,
                                      labelColor: AppColor.redColor,
                                      borderColor: AppColor.alphaGrey,
                                      fillColor: AppColor.alphaGrey,
                                      suffixIcon:
                                          "assets/icons/drop_down_ic.svg",
                                      items: UserDefaults.getCountriesList()
                                          ?.countries!,
                                      validator: (string) {
                                        return null;
                                      },
                                    ),
                                    space,
                                    MyDropDown(
                                      onChange: (value) {
                                        view.pereferdLocation5.text =
                                            value.toString();
                                      },
                                      hintText: getCountryNameFromId(
                                            (int.parse(
                                                view.pereferdLocation5.text)),
                                          )?.name ??
                                          "Preferred Location",
                                      labelText: "",
                                      itemAsString: (item) {
                                        return item?.name ?? '';
                                      },
                                      leftPadding: 0,
                                      rightPadding: 0,
                                      labelColor: AppColor.redColor,
                                      borderColor: AppColor.alphaGrey,
                                      fillColor: AppColor.alphaGrey,
                                      suffixIcon:
                                          "assets/icons/drop_down_ic.svg",
                                      items: UserDefaults.getCountriesList()
                                          ?.countries!,
                                      validator: (string) {
                                        return null;
                                      },
                                    ),
                                    space,
                                    space,
                                    Button(
                                      buttonText: 'Save',
                                      textColor: AppColor.whiteColor,
                                      onTap: () {
                                        view.updateProfile(onComplete: () {
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                    space,
                                    space,
                                  ],
                                ),
                              ));
                        },
                      ),*/
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

  getListOfJobs(AsyncSnapshot<List<Jobs?>> snapshot) {
    List<Jobs> list = [];
    list.add(Jobs(job: "Other", id: -1));

    for (var e in snapshot.data!) {
      list.add(e!);
    }

    return list;
  }

  imageEditWidget() {
    print("vvvv");
    return GestureDetector(
      onTap: () {
        view.getFile(onCompleteA: () {
          if (mounted) {
            imageCache?.clear();
            imageCache?.clearLiveImages();
            loadLogo();
          }
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
                        radius: 250.r,
                        key: UniqueKey(),
                        backgroundImage: (logo != null)
                            ? Image.network(
                                ApiConstants.employer_logos + (logo ?? ''),
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

  void loadLogo() {
    setState(() {
      logo = UserDefaults.getEmployerUserSession()?.employerModel?.logo;
    });
  }
}
