import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/tutor_profile_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../routes.dart';

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Full Name",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Company Name (Optional)",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Address",
                        ),
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Email Address",
                        ),
                        space,
                        space,
                        MyTextField(
                          fillColor: AppColor.alphaGrey,
                          hintText: "Confirm Email Address",
                        ),
                        space,
                        MyTextField(
                          obsecureText: false,
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
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Register",
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Navigator.of(myContext!).push(MaterialPageRoute(
                        builder: (context) => TutorProfileScreen()));
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
