import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/countries_model.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/company_profile_view_model.dart';
import 'package:magnijobs_rnr/view_models/job_post_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/job_sub_type_model.dart';
import '../../models/job_type_model.dart';
import '../../routes.dart';

class JobPostScreen extends StatefulWidget {
  String selectedCountryId;
  int? updateId;

//not being used now id
  JobPostScreen({required this.selectedCountryId, required this.updateId});

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
                title: widget.updateId != null ? 'Update Job' : "Job Post",
                onBacKTap: () {
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
                              widget.updateId != null
                                  ? 'Update Job'
                                  : "Post A Job",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.blackColor),
                            ),
                            space,
                            /*  MyDropDown(
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
                                if ((view.selectedCompanyId ?? '').isEmpty) {
                                  return "select company";
                                }
                                return null;
                              },
                            ),
                            space,*/
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
                                      view.selectedCountryId =
                                          value.id.toString();
                                    },
                                    hintText: "Country",
                                    labelText: "",
                                    leftPadding: 0,
                                    rightPadding: 0,
                                    itemAsString: (item) {
                                      return item.name ?? '';
                                    },
                                    labelColor: AppColor.redColor,
                                    borderColor: AppColor.alphaGrey,
                                    fillColor: AppColor.whiteColor,
                                    suffixIcon: "assets/icons/drop_down_ic.svg",
                                    items: snapshot.data!,
                                    validator: (string) {
                                      /*   if (view
                                          .locationController.text.isEmpty) {
                                        return 'select country';
                                      }*/
                                      return null;
                                    },
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                            space,
                            /*     MyTextField(
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
                            ),*/

                            StreamBuilder(
                              stream: view.getJobTypes(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Jobtypes?>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Container(
                                          child:
                                              const CircularProgressIndicator()));
                                }

                                if (snapshot.hasData) {
                                  return MyDropDown(
                                    onChange: (value) {
                                      view.selectedJobType = value;
                                      view.getJobSubTypes();
                                      setState(() {});
                                    },
                                    hintText: "Job Type",
                                    labelText: "",
                                    itemAsString: (item) {
                                      return item.jobType ?? '';
                                    },
                                    labelColor: AppColor.redColor,
                                    borderColor: AppColor.alphaGrey,
                                    fillColor: AppColor.whiteColor,
                                    leftPadding: 0,
                                    rightPadding: 0,
                                    value: view.selectedJobType,
                                    suffixIcon: "assets/icons/drop_down_ic.svg",
                                    items: snapshot.data!,
                                    validator: (string) {
                                      /* if (view.selectedJobType == null) {
                                      return 'Required';
                                    }*/
                                      return null;
                                    },
                                  );
                                }
                                return const IgnorePointer();
                              },
                            ),
                            if (view.selectedJobType != null)
                              Column(
                                children: [
                                  space,
                                  StreamBuilder(
                                    stream: view.getJobSubTypes(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Jobsubtypes?>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: Container(
                                                child:
                                                    const CircularProgressIndicator()));
                                      }

                                      if (snapshot.hasData) {
                                        return MyDropDown(
                                          onChange: (value) {
                                            view.selectedJobSubType = value;
                                          },
                                          hintText: /*view.selectedJobSubType?.subtype ??*/
                                              "Job Sub-Type",
                                          labelText: "",
                                          itemAsString: (item) {
                                            return item.subtype ?? '';
                                          },
                                          value: view.selectedJobSubType,
                                          labelColor: AppColor.redColor,
                                          leftPadding: 0,
                                          rightPadding: 0,
                                          borderColor: AppColor.alphaGrey,
                                          fillColor: AppColor.whiteColor,
                                          suffixIcon:
                                              "assets/icons/drop_down_ic.svg",
                                          items: snapshot.data!,
                                          validator: (string) {
                                            /*  if (view.locationController.text.isEmpty) {
                                          return 'select country';
                                        }*/
                                            return null;
                                          },
                                        );
                                      }

                                      return const IgnorePointer();
                                    },
                                  ),
                                ],
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
                            InkWell(
                              onTap: () {
                                showDatePickerDialog(
                                    context: context,
                                    onDateSelected: ((value) {
                                      print(value.toString());
                                      view.dueDateController.text =
                                          value.toString();
                                    }));
                              },
                              child: MyTextField(
                                leftPadding: 0,
                                rightPadding: 0,
                                enable: false,
                                fillColor: AppColor.whiteColor,
                                textColor: AppColor.blackColor,
                                hintColor: AppColor.blackColor,
                                labelColor: AppColor.blackColor,
                                hintText: "Due Date",
                                controller: view.dueDateController,
                                labelText: "Due Date",
                                validator: (string) {
                                  if (string == null || string.isEmpty) {
                                    return 'Enter Value';
                                  }
                                  return null;
                                },
                              ),
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
                        buttonText:
                            widget.updateId != null ? 'Update' : "Submit",
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (view.formKey.currentState!.validate()) {
                            /* if (((view.selectedCompanyId ?? '')
                                    .isNotEmpty) */ /*&&
                                ((view.selectedCountryId).isNotEmpty)*/ /*
                                ) {*/
                            if (widget.updateId != null) {
                              view.updateJobs(
                                  id: widget.updateId!,
                                  completion: () {
                                    AppPopUps.showAlertDialog(
                                      message: "Job Updated Successfully",
                                      onSubmit: () {
                                        view.resetState();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        /*   if (!widget.isForUpdate) {
                                          Provider.of<CountryAndJobViewModel>(
                                                  myContext!,
                                                  listen: false)
                                              .getAllCandidates(completion: () {
                                            Navigator.of(myContext!)
                                                .pushReplacement(MaterialPageRoute(
                                                    builder: (c) =>
                                                        CountryAndJobScreen()));
                                          });
                                        } else {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }*/
                                      },
                                    );
                                  });
                            } else {
                              view.postJob(
                                completion: () {
                                  AppPopUps.showAlertDialog(
                                    message: "Job Created Successfully",
                                    onSubmit: () {
                                      view.resetState();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            }
                            /*    } else {
                              AppPopUps.showAlertDialog(
                                  message: 'Enter all required fields');
                            }*/
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
