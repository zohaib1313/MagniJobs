import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/update_candidate_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class UpdateCandidateScreen extends StatefulWidget {
  UpdateCandidateScreen({Key? key}) : super(key: key);
  static const id = "UpdateCandidateScreen";

  @override
  _UpdateCandidateScreenState createState() => _UpdateCandidateScreenState();
}

class _UpdateCandidateScreenState extends State<UpdateCandidateScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<UpdateCandidateProfileViewModel>(myContext!);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    view.setValuesWithSharedPref();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(title: "Edit Profile", actions: [
            /*   const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )*/
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
                    child: Form(
                      key: view.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          space,
                          Text(
                            "Profile Information",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textStyleBoldSubTitleLarge
                                .copyWith(color: AppColor.blackColor),
                          ),
                          space,
                          space,
                          getInputItem(
                              hint: "First name",
                              validateDate: true,
                              controller: view.firstnameContoller),
                          getInputItem(
                              hint: "Last name",
                              validateDate: true,
                              controller: view.lastNameController),
                          getInputItem(
                              hint: "Email",
                              validateDate: true,
                              enabled: false,
                              controller: view.emailController),
                          getInputItem(
                              hint: "Mobile",
                              enabled: false,
                              validateDate: true,
                              controller: view.mobileController),
                          getInputItem(
                              hint: "Address",
                              validateDate: true,
                              controller: view.addressController),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.locationController.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.locationController.text)),
                                )?.name ??
                                "Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: UserDefaults.getCountriesList()?.countries!
                            /* .map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              if (((string ?? '').isEmpty) ||
                                  view.locationController.text.isEmpty ||
                                  view.locationController.text == '00') {
                                return 'Select Location';
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
                                    view.dobController.text = value.toString();
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
                              hintText: "Date of birth",
                              controller: view.dobController,
                              labelText: "Date of birth",
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                          ),
                          getInputItem(
                              hint: "Nationality",
                              validateDate: true,
                              controller: view.nationalityController),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.genderController.text = value;
                            },
                            hintText: "Gender",
                            labelText: "",
                            value: view.genderController.text,
                            leftPadding: 0,
                            rightPadding: 0,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.whiteColor,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: 'assets/icons/drop_down_ic.svg',
                            items: ["Male", "Female"],
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.martialStatusController.text = value;
                            },
                            hintText: "Marital Status",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            value: view.martialStatusController.text,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.whiteColor,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: 'assets/icons/drop_down_ic.svg',
                            items: ["Single", "Married"],
                            validator: (string) {
                              return null;
                            },
                          ),
                          getInputItem(
                              hint: "School",
                              controller: view.schoolController),
                          getInputItem(
                              hint: "Work Experience",
                              controller: view.workExperienceController),
                          getInputItem(
                              hint: "Certificates",
                              controller: view.certificationController),
                          getInputItem(
                              hint: "Exams", controller: view.examsController),
                          getInputItem(
                              hint: "License",
                              controller: view.licenseController),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.pereferdLocation1.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.pereferdLocation1.text)),
                                )?.name ??
                                "Preferred Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: UserDefaults.getCountriesList()?.countries!
                            /*  .map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.pereferdLocation2.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.pereferdLocation2.text)),
                                )?.name ??
                                "Preferred Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: UserDefaults.getCountriesList()?.countries!
                            /* .map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.pereferdLocation3.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.pereferdLocation3.text)),
                                )?.name ??
                                "Preferred Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            items: UserDefaults.getCountriesList()?.countries!
                            /*.map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.pereferdLocation4.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.pereferdLocation4.text)),
                                )?.name ??
                                "Preferred Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: UserDefaults.getCountriesList()?.countries!
                            /*  .map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.pereferdLocation5.text = value.toString();
                            },
                            hintText: getCountryNameFromId(
                                  (int.parse(view.pereferdLocation5.text)),
                                )?.name ??
                                "Preferred Location",
                            labelText: "",
                            leftPadding: 0,
                            rightPadding: 0,
                            itemAsString: (item) {
                              return item?.name ?? '';
                            },
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: "assets/icons/drop_down_ic.svg",
                            items: UserDefaults.getCountriesList()?.countries!
                            /*.map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles
                                            .textStyleBoldBodySmall,
                                      ),
                                    ))
                                .toList()*/
                            ,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          space,
                        ],
                      ),
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
                        view.updateProfile(onComplete: () {
                          view.setValuesWithSharedPref();
                          AppPopUps.showAlertDialog(message: 'Profile Updated');
                        });
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
    );
  }

  getInputItem(
      {required String hint,
      bool enabled = true,
      required controller,
      bool validateDate = false}) {
    return Column(
      children: [
        space,
        MyTextField(
          leftPadding: 0,
          enable: enabled,
          onChanged: (onChange) {},
          controller: controller,
          rightPadding: 0,
          hintText: hint,
          fillColor: AppColor.whiteColor,
          unfocusBorderColor: AppColor.alphaGrey,
          labelColor: AppColor.blackColor,
          textColor: AppColor.blackColor,
          hintColor: AppColor.blackColor,
          validator: (s) {
            if (s!.isEmpty && validateDate) {
              return "enter $hint";
            }
            return null;
          },
        ),
      ],
    );
  }
}
