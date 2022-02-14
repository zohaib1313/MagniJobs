import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/screens/jobs_posted_employee_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../../routes.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  static const id = "UpdateProfileScreen";

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
          appBar: myAppBar(title: "Edit Profile", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
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
                        MyDropDown(
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Country",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "School Graduated",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Date Of Birth",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Martial Status",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          hintText: "Work Experience",
                          fillColor: AppColor.whiteColor,
                          unfocusBorderColor: AppColor.whiteColor,
                          labelColor: AppColor.alphaGrey.withOpacity(0.34),
                          textColor: AppColor.blackColor,
                          hintColor: AppColor.blackColor,
                        ),
                        space,
                        MyDropDown(
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Exam Taken",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Professional License",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Certificates",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                          leftPadding: 0,
                          rightPadding: 0,
                          onChange: (value) {},
                          hintText: "Preferred Location",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.whiteColor,
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text(
                                "A",
                                style: AppTextStyles.textStyleBoldBodySmall,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "B",
                              child: Text(
                                "B",
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
                    buttonText: "Submit",
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      Navigator.of(myContext!).push(MaterialPageRoute(
                          builder: (context) => JobPostedEmployeeScreen()));
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
}
