import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/job_type_model.dart';
import 'package:magnijobs_rnr/models/signin_model.dart';
import 'package:magnijobs_rnr/screens/verify_number/verify_number_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/app_constants.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/applicant_sign_up_view_model.dart';
import 'package:provider/provider.dart';

import '../models/countries_model.dart';
import '../models/job_sub_type_model.dart';
import '../routes.dart';
import '../utils/app_alert_bottom_sheet.dart';
import '../utils/user_defaults.dart';
import '../view_models/company_profile_view_model.dart';
import '../view_models/verify_number_view_model.dart';
import 'attendie_profile_screen.dart';
import 'employee_portal_screen.dart';
import 'verify_number/privacy_policy_screen.dart';

class ApplicantSignUp extends StatefulWidget {
  static const id = "ApplicantSignUp";

  String userType;

  ApplicantSignUp({required this.userType});

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
                                        value.id.toString();
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
                                    if (view.locationController.text.isEmpty) {
                                      return 'select country';
                                    }
                                    return null;
                                  },
                                );
                              }
                              return Center(
                                  child: Container(
                                      child:
                                          const CircularProgressIndicator()));
                            },
                          ),
                          space,
                          StreamBuilder(
                            stream: view.getJobTypes(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Jobtypes?>> snapshot) {
                              if (snapshot.hasData) {
                                view.getJobSubTypes();
                                return MyDropDown(
                                  onChange: (value) {
                                    view.selectedJobType = value;
                                    setState(() {
                                      view.getJobSubTypes();
                                    });
                                  },
                                  hintText: "Job Type",
                                  labelText: "",
                                  itemAsString: (item) {
                                    return item.jobType ?? '';
                                  },
                                  labelColor: AppColor.redColor,
                                  borderColor: AppColor.alphaGrey,
                                  fillColor: AppColor.alphaGrey,
                                  value: view.selectedJobType,
                                  suffixIcon: "assets/icons/drop_down_ic.svg",
                                  items: snapshot.data!,
                                  validator: (string) {
                                    /* if (view.locationController.text.isEmpty) {
                                      return 'Required';
                                    }*/
                                    return null;
                                  },
                                );
                              }
                              return Center(
                                  child: Container(
                                      child:
                                          const CircularProgressIndicator()));
                            },
                          ),
                          space,
                          StreamBuilder(
                            stream: view.getJobSubTypes(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Jobsubtypes?>> snapshot) {
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
                                  borderColor: AppColor.alphaGrey,
                                  fillColor: AppColor.alphaGrey,
                                  suffixIcon: "assets/icons/drop_down_ic.svg",
                                  items: snapshot.data!,
                                  validator: (string) {
                                    /*  if (view.locationController.text.isEmpty) {
                                      return 'select country';
                                    }*/
                                    return null;
                                  },
                                );
                              }
                              return Center(
                                  child: Container(
                                      child:
                                          const CircularProgressIndicator()));
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
                            items: const ["Male", "Female"],
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          MyDropDown(
                            onChange: (value) {
                              view.martialStatusController.text = value;
                            },
                            hintText: "Marital status",
                            labelText: "",
                            labelColor: AppColor.redColor,
                            borderColor: AppColor.alphaGrey,
                            fillColor: AppColor.alphaGrey,
                            suffixIcon: 'assets/icons/drop_down_ic.svg',
                            items: const ["Single", "Married"],
                            validator: (string) {
                              return null;
                            },
                          ),
                          space,
                          getEducationFiedls(
                              title: 'Certifications',
                              controller: view.certificatesController),
                          space,
                          getEducationFiedls(
                              title: 'Exams', controller: view.examsController),
                          space,
                          getEducationFiedls(
                              title: 'Work Experience',
                              controller: view.workExperienceController),
                          space,
                          getEducationFiedls(
                              title: 'Licenses',
                              controller: view.licenseController),
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
                                const SizedBox(
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
                          view.registerApplicant(
                              completion: (CandidateSignInModel? model) {
                            AppPopUps.showAlertDialog(
                                message: "User created Successfully",
                                onSubmit: () async {
                                  startVerification(model);
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

  void showSheet(
      {required String title,
      required TextEditingController textEditingControllerList}) {
    List<TextEditingController> controllersField = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];

    List<String?> initialText = textEditingControllerList.text.split(",");
    for (int i = 0; i < initialText.length; i++) {
      controllersField[i].text = initialText[i] ?? '';
    }

    BottomSheets().showBottomSheet(
        context: context,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.textStyleNormalBodyMedium,
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
              ListView.builder(
                  itemCount: controllersField.length,
                  shrinkWrap: true,
                  itemBuilder: (context, item) {
                    return Column(
                      children: [
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Enter $title",
                          controller: controllersField[item],
                          validator: (string) {
                            return null;
                          },
                        ),
                        space,
                      ],
                    );
                  }),
              space,
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Save",
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    String certificates = '';
                    for (int i = 0; i < controllersField.length; i++) {
                      if (i != 0) {
                        if (controllersField[i].text.isNotEmpty) {
                          certificates = certificates +
                              "," +
                              controllersField[i].text.toString();
                        }
                      } else {
                        if (controllersField[0].text.isNotEmpty) {
                          certificates = controllersField[0].text;
                        }
                      }
                    }

                    textEditingControllerList.text = certificates;
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ));
  }

  getEducationFiedls(
      {required String title, required TextEditingController controller}) {
    return InkWell(
      onTap: () {
        showSheet(title: title, textEditingControllerList: controller);
      },
      child: MyTextField(
        enable: false,
        fillColor: AppColor.alphaGrey,
        hintText: title,
        suffixIconWidet: const Icon(
          Icons.add_circle,
          color: AppColor.primaryBlueColor,
        ),
        controller: controller,
        validator: (string) {
          return null;
        },
      ),
    );
  }

  Future<void> startVerification(CandidateSignInModel? model) async {
    Provider.of<VerifyNumberViewModel>(myContext!, listen: false).resetState();
    bool? isVerified = await Navigator.of(myContext!).push(MaterialPageRoute(
      builder: (myContext) => VerifyNumberScreen(),
    ));
    if (isVerified ?? false) {
      if (model != null) {
        switch (widget.userType) {
          case 'applicant':
            await UserDefaults.saveCandidateUserSession(model, widget.userType);
            view.resetState();
            if (UserDefaults.getCandidateUserSession()?.candidateModel !=
                null) {
              Navigator.of(myContext!).pop();
              Navigator.of(myContext!)
                  .pushReplacementNamed(EmployeePortalScreen.id);
            } else {
              AppPopUps.showAlertDialog(
                  message: 'Not Applicant User',
                  onSubmit: () {
                    UserDefaults().clearAll();
                    Navigator.pop(context);
                  });
            }
            break;

          case 'attendie':
            await UserDefaults.saveCandidateUserSession(model, widget.userType);
            view.resetState();
            if (UserDefaults.getCandidateUserSession()?.candidateModel !=
                null) {
              Navigator.of(myContext!).pop();
              Navigator.of(myContext!)
                  .pushReplacementNamed(AttendieCandidateProfileScreen.id);
            } else {
              AppPopUps.showAlertDialog(
                  message: 'Not Attendie User',
                  onSubmit: () {
                    UserDefaults().clearAll();
                    Navigator.pop(context);
                  });
            }
            break;
        }
      }
    } else {
      AppPopUps.showConfirmDialog(
          title: 'Alert',
          message: 'Verifications failed, retry?',
          onSubmit: () {
            startVerification(model);
          });
    }
  }
}
