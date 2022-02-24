import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/all_employers_model.dart';
import 'package:magnijobs_rnr/screens/country_and_job/country_and_job_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/country_and_job_view_model.dart';
import 'package:magnijobs_rnr/view_models/job_post_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class JobPostScreen extends StatefulWidget {
  JobPostScreen({Key? key}) : super(key: key);
  static const id = "JobPostScreen";

  @override
  _JobPostScreenState createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<JobPostViewModel>(myContext!);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: WillPopScope(
        onWillPop: () {
          view.resetState();
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: myAppBar(
                title: "Job Post",
                onTap: () {
                  view.resetState();
                  Navigator.of(context).pop();
                }),
            backgroundColor: AppColor.alphaGrey,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                //  height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                ),
                margin: EdgeInsets.only(
                  top: 100.r,
                  bottom: 100.r,
                  left: 100.w,
                  right: 100.w,
                ),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r)),
                ),
                child: Form(
                  key: view.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50.h, bottom: 20.h),
                        padding: EdgeInsets.only(left: 100.w, right: 100.w),
                        decoration: BoxDecoration(
                          color: AppColor.alphaGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.r),
                              topRight: Radius.circular(40.r)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            space,
                            Text(
                              "Post A Job",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                            space,
                            MyDropDown(
                              leftPadding: 0,
                              rightPadding: 0,
                              onChange: (value) {
                                view.selectedCompanyId = value.id.toString();
                              },
                              hintText: "Company Name",
                              labelText: "",
                              labelColor: AppColor.redColor,
                              borderColor: AppColor.alphaGrey,
                              fillColor: AppColor.whiteColor,
                              suffixIcon: "assets/icons/drop_down_ic.svg",
                              itemFuntion: view.employersModel!.employers!
                                  .map((Employers value) {
                                return DropdownMenuItem<Employers>(
                                  value: value,
                                  child: Text(
                                    value.companyName ?? "",
                                  ),
                                );
                              }).toList(),
                              validator: (item) {
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              fillColor: AppColor.whiteColor,
                              hintText: "Job",
                              controller: view.jobController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              fillColor: AppColor.whiteColor,
                              hintText: "Location",
                              controller: view.locationController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              fillColor: AppColor.whiteColor,
                              keyboardType: TextInputType.number,
                              hintText: "Salary",
                              controller: view.salaryController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              fillColor: AppColor.whiteColor,
                              hintText: "Qualifications",
                              controller: view.qualificationController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              leftPadding: 0,
                              rightPadding: 0,
                              fillColor: AppColor.whiteColor,
                              hintText: "Job Description",
                              labelText: "Job Description",
                              controller: view.jobdiscriptionController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            space,
                          ],
                        ),
                      ),
                      space,
                      space,
                      space,
                      space,
                      Button(
                        buttonText: "Submit",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (view.formKey.currentState!.validate()) {
                            if ((view.selectedCompanyId ?? "").isNotEmpty) {
                              view.postJob(
                                completion: () {
                                  AppPopUps.showAlertDialog(
                                    message: "Job Created Successfully",
                                    onSubmit: () {
                                      view.resetState();
                                      Provider.of<CountryAndJobViewModel>(
                                              myContext!,
                                              listen: false)
                                          .getAllCandidates(completion: () {
                                        Navigator.of(myContext!)
                                            .pushReplacementNamed(
                                                CountryAndJobScreen.id);
                                      });
                                    },
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                      space,
                      space,
                      space,
                      space,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
