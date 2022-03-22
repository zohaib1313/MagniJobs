import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/verify_number/privacy_policy_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/tutor_signup_view_model.dart';
import 'package:provider/provider.dart';

import '../models/countries_model.dart';
import '../routes.dart';
import '../view_models/company_profile_view_model.dart';

class TutorSignUpScreen extends StatefulWidget {
  TutorSignUpScreen({Key? key}) : super(key: key);
  static const id = "TutorSignUpScreen";

  @override
  _TutorSignUpScreenState createState() => _TutorSignUpScreenState();
}

class _TutorSignUpScreenState extends State<TutorSignUpScreen> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    var view = Provider.of<TutorSignUpViewModel>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(title: "Tutor Sign Up"),
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
                                  hintText: "Country",
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
                                    if (string == null || string.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                );
                              }
                              return Center(
                                  child: Container(
                                      child: CircularProgressIndicator()));
                            },
                          ),
                          /*  MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Location",
                            controller: view.locationController,
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),*/
                          space,
                          MyTextField(
                            fillColor: AppColor.alphaGrey,
                            hintText: "Company",
                            controller: view.companyNameController,
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
                                mySwitch(
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
                                                PrivacyPolicyScreen()));
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
                        if (view.termsConditionAccepted) {
                          view.registerTutor(
                            completion: () async {
                              AppPopUps.showAlertDialog(
                                  message: "User created Successfully",
                                  onSubmit: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                            },
                          );
                        } else {
                          AppPopUps.showAlertDialog(
                              message: 'You Must Accept Terms & Conditions');
                        }
                      } else {
                        AppPopUps.displayTextInputDialog(
                            title: "validation",
                            message: "Select File",
                            hint: "Select Image");
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
