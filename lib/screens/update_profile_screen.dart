import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/update_my_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  static const id = "UpdateProfileScreen";

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<UpdateMyProfileViewModel>(myContext!);

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
                              controller: view.emailController),
                          getInputItem(
                              hint: "Mobile",
                              validateDate: true,
                              controller: view.mobileController),
                          getInputItem(
                              hint: "Address",
                              validateDate: true,
                              controller: view.addressController),
                          getInputItem(
                              hint: "Location",
                              validateDate: true,
                              controller: view.locationController),
                          getInputItem(
                              hint: "Date of birth",
                              validateDate: true,
                              controller: view.dobController),
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
                            leftPadding: 0,
                            rightPadding: 0,
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.whiteColor,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: 'assets/icons/drop_down_ic.svg',
                            itemFuntion: [
                              DropdownMenuItem(
                                value: "Single",
                                child: Text(
                                  "Single",
                                  style: AppTextStyles.textStyleBoldBodySmall,
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Married",
                                child: Text(
                                  "Married",
                                  style: AppTextStyles.textStyleBoldBodySmall,
                                ),
                              ),
                            ],
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
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.whiteColor,
                            fillColor: AppColor.whiteColor,
                            suffixIcon: 'assets/icons/drop_down_ic.svg',
                            itemFuntion: [
                              DropdownMenuItem(
                                value: "Male",
                                child: Text(
                                  "Male",
                                  style: AppTextStyles.textStyleBoldBodySmall,
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Female",
                                child: Text(
                                  "Female",
                                  style: AppTextStyles.textStyleBoldBodySmall,
                                ),
                              ),
                            ],
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          getInputItem(
                              hint: "School",
                              controller: view.schoolController),
                          space,
                          getInputItem(
                              hint: "Work Experience",
                              controller: view.workExperienceController),
                          space,
                          getInputItem(
                              hint: "Certificates",
                              controller: view.certificationController),
                          space,
                          getInputItem(
                              hint: "Exams", controller: view.examsController),
                          space,
                          getInputItem(
                              hint: "License",
                              controller: view.licenseController),
                          space,
                          getInputItem(
                              hint: "Preferred Location",
                              controller: view.preferredlocationController),
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
                        view.updateProfile(onComplete: () {});
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
      {required String hint, required controller, bool validateDate = false}) {
    return Column(
      children: [
        space,
        MyTextField(
          leftPadding: 0,
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
