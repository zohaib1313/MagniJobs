import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/applicant_sign_up_view_model.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ApplicantSignUp extends StatefulWidget {
  ApplicantSignUp({Key? key}) : super(key: key);
  static const id = "ApplicantSignUp";

  @override
  _ApplicantSignUpState createState() => _ApplicantSignUpState();
}

class _ApplicantSignUpState extends State<ApplicantSignUp> {
  final space = SizedBox(height: 20.h);

  var view = Provider.of<ApplicantSignUpViewModel>(myContext!);

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
          appBar: myAppBar(title: "Applicant Sign Up"),
          backgroundColor: AppColor.whiteColor,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: view.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "First Name",
                            controller: view.firstnameContoller,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Last Name",
                            controller: view.lastNameController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Email Address",
                            controller: view.emailController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Mobile number",
                            controller: view.mobileController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Address",
                            controller: view.addressController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
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
                            fillColor: AppColor.alphaGrey,
                            hintText: "Date of Birth",
                            controller: view.dobController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Nationality",
                            controller: view.nationalityController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Company name",
                            controller: view.companynameController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Contact number",
                            controller: view.contactnumberController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Contact email",
                            controller: view.contactemailController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.genderController.text = value;
                            },
                            hintText: "Gender",
                            labelText: "",
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.alphaGrey,
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
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.martialStatusController.text = value;
                            },
                            hintText: "Material status",
                            labelText: "",
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.alphaGrey,
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
                          MyTextField(
                            suffixIconWidet: GestureDetector(
                                onTap: () {
                                  view.hidePassword = !view.hidePassword;
                                },
                                child: Icon(view.hidePassword
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.visibility_off_outlined)),
                            fillColor: AppColor.alphaGrey,
                            hintText: "Password",
                            obsecureText: view.hidePassword,
                            controller: view.passwordController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            suffixIconWidet: GestureDetector(
                                onTap: () {
                                  view.hidePassword2 = !view.hidePassword2;
                                },
                                child: Icon(view.hidePassword
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.visibility_off_outlined)),
                            obsecureText: view.hidePassword2,
                            fillColor: AppColor.alphaGrey,
                            hintText: "Confirm Password",
                            controller: view.confirmPasswordController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                          space,
                          space,
                          Padding(
                            padding: EdgeInsets.all(100.w),
                            child: DottedBorder(
                              color: AppColor.greyColor,
                              dashPattern: [10, 10],
                              strokeWidth: 1,
                              child: Container(
                                padding: EdgeInsets.all(80.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgViewer(
                                      svgPath: 'assets/icons/ic_copy.svg',
                                      width: 200.w,
                                      height: 200.w,
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Upload ID",
                                            style: AppTextStyles
                                                .textStyleNormalBodyMedium,
                                          ),
                                          Text(
                                            view.nationalIdImage?.path
                                                    .split('/')
                                                    .last ??
                                                "doc, dox, pdf",
                                            style: AppTextStyles
                                                .textStyleNormalBodyMedium
                                                .copyWith(
                                                    color: AppColor.greyColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Button(
                                            buttonText: "Choose",
                                            textColor: AppColor.whiteColor,
                                            onTap: () {
                                              view.getFile();
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Register",
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    if (view.formKey.currentState!.validate()) {
                      if (view.nationalIdImage != null) {
                        view.registerApplicant(completion: () {
                          AppPopUps.showAlertDialog(
                              message: "User created Successfully");
                        });
                      } else {
                        AppPopUps.showAlertDialog(
                          message: "Select File",
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
