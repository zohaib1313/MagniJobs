import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/app_constants.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/applicant_sign_up_view_model.dart';
import 'package:provider/provider.dart';

import '../models/countries_model.dart';
import '../routes.dart';
import '../view_models/company_profile_view_model.dart';
import 'verify_number/privacy_policy_screen.dart';

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
                                    view.locationController.text =
                                        value.toString();
                                  },
                                  hintText: "Location",
                                  labelText: "",
                                  labelColor: AppColor.redColor,
                                  borderColor: AppColor.alphaGrey,
                                  fillColor: AppColor.alphaGrey,
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
                              fillColor: AppColor.alphaGrey,
                              hintText: "Date of Birth",
                              enable: false,
                              controller: view.dobController,
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
                          /*  space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Company name",
                            controller: view.companynameController,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Contact number",
                            controller: view.contactnumberController,
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Contact email",
                            controller: view.contactemailController,
                            validator: (string) {
                              return null;
                            },
                          ),*/
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.w),
                            child: Row(
                              children: [
                                myCheckBox(
                                    message: "Accept",
                                    isActive: view.termsConditionAccepted,
                                    messageColor: AppColor.blackColor,
                                    fillColor: AppColor.alphaGrey,
                                    checkColor: AppColor.blackColor,
                                    onTap: () {
                                      view.termsConditionAccepted =
                                          !view.termsConditionAccepted;
                                      setState(() {});
                                    }),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(myContext!).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                PrivacyPolicyScreen(
                                                  title: 'Applicant Disclaimer',
                                                  value: AppConstants
                                                      .applicatntDisclamir,
                                                )));
                                  },
                                  child: Text(
                                    'Terms & Conditions',
                                    style: AppTextStyles
                                        .textStyleNormalBodySmall
                                        .copyWith(
                                            color: AppColor.blueColor,
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ),
                          space,
                          Padding(
                            padding: EdgeInsets.all(100.w),
                            child: DottedBorder(
                              color: AppColor.greyColor,
                              dashPattern: const [10, 10],
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
                  onTap: () async {
                    if (view.formKey.currentState!.validate()) {
                      if (view.nationalIdImage != null) {
                        if (view.termsConditionAccepted) {
                          view.registerApplicant(completion: () {
                            AppPopUps.showAlertDialog(
                                message:
                                    "User created Successfully go to login",
                                onSubmit: () {
                                  Navigator.of(myContext!).pop();
                                });
                            view.resetState();
                          });
                        } else {
                          AppPopUps.showAlertDialog(
                            message: "You Must Accept Terms & Conditions",
                          );
                        }
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
