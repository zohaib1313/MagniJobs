import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/packages_/packages_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_packges_view_model.dart';
import 'package:magnijobs_rnr/view_models/employer_signup_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/countries_model.dart';
import '../../routes.dart';
import '../../view_models/company_profile_view_model.dart';

class EmployerSignUpScreen extends StatefulWidget {
  EmployerSignUpScreen({Key? key}) : super(key: key);
  static const id = "EmployerSignUpScreen";

  @override
  _EmployerSignUpScreenState createState() => _EmployerSignUpScreenState();
}

class _EmployerSignUpScreenState extends State<EmployerSignUpScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<EmployerSignUpViewModel>(myContext!);

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
                title: "Employer Sign Up",
                onBacKTap: () {
                  view.resetState();
                  Navigator.of(context).pop();
                }),
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
                              labelText: "First Name",
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
                              labelText: "Last Name",
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
                              hintText: "Email",
                              labelText: "Email",
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
                              hintText: "Mobile",
                              labelText: "Mobile",
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
                              labelText: "Address",
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
                                      if (view
                                          .locationController.text.isEmpty) {
                                        return 'select country';
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
                            space,
                            MyTextField(
                              fillColor: AppColor.alphaGrey,
                              hintText: "Company Name",
                              labelText: "Company Name",
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
                              fillColor: AppColor.alphaGrey,
                              hintText: "Company Contact",
                              labelText: "Company Contact",
                              controller: view.contactNumberController,
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            space,
                            MyTextField(
                              fillColor: AppColor.alphaGrey,
                              hintText: "Company Mail",
                              labelText: "Company Mail",
                              controller: view.contactEmailController,
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
                                view.martialStatusController.text = value ?? "";
                              },
                              hintText: "Martial Status",
                              labelText: "",
                              labelColor: AppColor.redColor,
                              borderColor: AppColor.alphaGrey,
                              fillColor: AppColor.alphaGrey,
                              suffixIcon: "assets/icons/drop_down_ic.svg",
                              itemFuntion: [
                                DropdownMenuItem(
                                  value: "Married",
                                  child: Text(
                                    "Married",
                                    style: AppTextStyles.textStyleBoldBodySmall,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Single",
                                  child: Text(
                                    "Single",
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
                              fillColor: AppColor.alphaGrey,
                              hintText: "Website",
                              labelText: "Website",
                              controller: view.webSiteController,
                              /*  validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },*/
                            ),
                            space,
                            MyTextField(
                              obsecureText: view.hidePassword,
                              controller: view.passwordController,
                              suffixIconWidet: GestureDetector(
                                  onTap: () {
                                    view.hidePassword = !view.hidePassword;
                                  },
                                  child: Icon(view.hidePassword
                                      ? Icons.remove_red_eye_rounded
                                      : Icons.visibility_off_outlined)),
                              fillColor: AppColor.alphaGrey,
                              hintText: "Password",
                              labelText: "Password",
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
                              },
                            ),
                            space,
                            MyTextField(
                              obsecureText: view.hidePassword2,
                              controller: view.confirmPasswordController,
                              suffixIconWidet: GestureDetector(
                                  onTap: () {
                                    view.hidePassword2 = !view.hidePassword2;
                                  },
                                  child: Icon(view.hidePassword2
                                      ? Icons.remove_red_eye_rounded
                                      : Icons.visibility_off_outlined)),
                              fillColor: AppColor.alphaGrey,
                              hintText: "Confirm Password",
                              labelText: "Confirm Password",
                              validator: (string) {
                                if (string == null || string.isEmpty) {
                                  return 'Enter Value';
                                }
                                return null;
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
                Padding(
                  padding: EdgeInsets.all(100.r),
                  child: Button(
                    buttonText: "Register",
                    textColor: AppColor.whiteColor,
                    onTap: () async {
                      if (view.formKey.currentState!.validate()) {
                        view.registerUser(completion: () {
                          AppPopUps.showAlertDialog(
                              message: "User Created Successfully",
                              onSubmit: () {
                                view.resetState();
                                Provider.of<AllPackagesViewModel>(myContext!,
                                        listen: false)
                                    .getAllPackages(completion: () {
                                  Navigator.of(myContext!)
                                      .pushReplacementNamed(PackagesScreen.id);
                                });
                              });
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
