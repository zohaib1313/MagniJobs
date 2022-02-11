import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/screens/addpayment/add_payment_screen.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import '../../routes.dart';
import '../../styles.dart';

class PackagesScreen extends StatefulWidget {
  static const id = "PackagesScreen";

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<PackagesScreen> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryBlueDarkColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor:
              AppColor.primaryBlueDarkColor //or the color you prefer
          ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
          color: AppColor.primaryBlueColor,
          child: Column(
            children: [
              Text("Packages",
                  style: AppTextStyles.textStyleBoldTitleLarge
                      .copyWith(color: AppColor.whiteColor)),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      space,
                      space,
                      ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Free Trial",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                            isExpanded: false),
                      ),
                      space,
                      ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benifits", isExpanded: false),
                        expandedWidgetChild: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$ 299",
                                  style: AppTextStyles.textStyleNormalBodyMedium
                                      .copyWith(color: AppColor.whiteColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ".1 Job Posting",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color: AppColor.whiteColor),
                                      ),
                                      Text(
                                        ".1 Job Posting",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color: AppColor.whiteColor),
                                      ),
                                      Text(
                                        ".1 Job Posting",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color: AppColor.whiteColor),
                                      ),
                                      Text(
                                        ".1 Job Posting",
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall
                                            .copyWith(
                                                color: AppColor.whiteColor),
                                      ),
                                      space,
                                      mySwitch(
                                          message: "Selected Package",
                                          onTap: () {}),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Free to Use",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Essential Member",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Premiere Member",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      Text(
                        "Disclaimers",
                        style: AppTextStyles.textStyleBoldTitleLarge
                            .copyWith(color: AppColor.whiteColor),
                      ),
                      space,
                      ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Terms & Conditions", isExpanded: false),
                        expandedWidgetChild: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Your submission of information, Including personal information is governed by the terms of our privacy policy as updated from time to time, and any additional privacy notice issued by your employer. We grant you a non-exclusive, non-transferable",
                                          style: AppTextStyles
                                              .textStyleNormalBodySmall
                                              .copyWith(
                                                  color: AppColor.whiteColor),
                                        ),
                                        space,
                                        InkWell(
                                          onTap: () {
                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8.r),
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: true
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 15.0,
                                                        color: Colors.black,
                                                      )
                                                    : Icon(
                                                        null,
                                                        size: 30.0,
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                              ),
                                              Text(
                                                "Selected Package ",
                                                style: AppTextStyles
                                                    .textStyleNormalBodySmall
                                                    .copyWith(
                                                        color: AppColor
                                                            .whiteColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Non-Disclosure Agreement",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "No Refund Policy",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Other Disclaimers",
                              message:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                              isExpanded: false)),
                      space,
                      space,
                      space,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Payment",
                  textColor: AppColor.primaryBlueDarkColor,
                  color: AppColor.whiteColor,
                  onTap: () {
                    Navigator.of(myContext!).pushNamed(AddPaymentScreen.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
