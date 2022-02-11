import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/packages_/packages_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class EmployerSignUpScreen extends StatefulWidget {
  EmployerSignUpScreen({Key? key}) : super(key: key);
  static const id = "EmployerSignUpScreen";

  @override
  _EmployerSignUpScreenState createState() => _EmployerSignUpScreenState();
}

class _EmployerSignUpScreenState extends State<EmployerSignUpScreen> {
  final space = SizedBox(height: 20.h);

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
          appBar: myAppBar(title: "Employer Sign Up"),
          backgroundColor: AppColor.whiteColor,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Name",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Company Name",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Address",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Contact Number",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Company Email",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Personal Email",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Confirm Personal Email",
                        ),
                        space,
                        MyTextField(
                          obsecureText: true,
                          suffixIcon: "assets/icons/eye_open_ic.svg",
                          fillColor: AppColor.alphaGrey,
                          hintText: "Password",
                        ),
                        space,
                        MyTextField(
                          suffixIcon: "assets/icons/eye_open_ic.svg",
                          obsecureText: true,
                          fillColor: AppColor.alphaGrey,
                          hintText: "Confirm Password",
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
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Register",
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Navigator.of(myContext!).pushNamed(PackagesScreen.id);
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
