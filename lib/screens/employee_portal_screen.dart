import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/update_employer_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_portal_view_model.dart';
import 'package:provider/provider.dart';

import '../models/all_jobs_model.dart';
import '../models/countries_model.dart';
import '../profile_settting_screen.dart';
import '../view_models/company_profile_view_model.dart';
import 'all_jobs_screen.dart';

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
          appBar: myAppBar(title: "Employee Portal", actions: [
            InkWell(
              onTap: () {
                Navigator.of(myContext!).push(MaterialPageRoute(
                    builder: (context) => ProfileSettingScreen()));
                /*  Provider.of<ProfileSettingViewModel>(myContext!, listen: false)
                    .logout(onComplete: () {
                  UserDefaults().clearAll();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ChooseSignInScreen()));
                });*/
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
                        UserDefaults.getUserSession()?.user?.firstName ?? "",
                        style: AppTextStyles.textStyleBoldSubTitleLarge,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Container(
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
                      ),
                    ],
                  ),
                  space,
                  Text(
                    UserDefaults.getUserSession()?.user?.utype ?? "",
                    style: AppTextStyles.textStyleNormalBodySmall
                        .copyWith(color: AppColor.greyColor),
                  ),
                  space,
                  Button(
                    leftPadding: 200.w,
                    rightPading: 200.w,
                    buttonText: "Update Profile",
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      Navigator.of(myContext!).push(MaterialPageRoute(
                          builder: (context) => UpdateEmployerProfileScreen()));
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
                            //  view.selectedCountryId = value.toString();
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
                                      style:
                                          AppTextStyles.textStyleBoldBodySmall,
                                    ),
                                  ))
                              .toList(),
                          validator: (string) {
                            return null;
                          },
                        );
                      }
                      return Center(
                          child: Container(child: CircularProgressIndicator()));
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
                                      style:
                                          AppTextStyles.textStyleBoldBodySmall,
                                    ),
                                  ))
                              .toList(),
                          validator: (string) {
                            return null;
                          },
                        );
                      }
                      return Center(
                          child: Container(child: CircularProgressIndicator()));
                    },
                  ),
                  space,
                  Button(
                    leftPadding: 200.w,
                    rightPading: 200.w,
                    buttonText: "Save Profile",
                    textColor: AppColor.whiteColor,
                  ),
                  space,
                  Button(
                    leftPadding: 200.w,
                    rightPading: 200.w,
                    buttonText: "Browse Jobs Posted",
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      Provider.of<AllJobsViewModel>(myContext!, listen: false)
                          .getAllJobs(completion: (allJobs) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllJobScreen()));
                      });
                    },
                  ),
                  space,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageEditWidget() {
    return Container(
      padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
      margin: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      backgroundImage:
                          (UserDefaults.getUserSession()?.user?.profile != null)
                              ? Image.network(UserDefaults.getUserSession()
                                          ?.user
                                          ?.profile ??
                                      "")
                                  .image
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
          )
        ],
      ),
    );
  }
}
