import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class TutorCalenderScreen extends StatefulWidget {
  TutorCalenderScreen({Key? key}) : super(key: key);
  static const id = "TutorCalenderScreen";

  @override
  _TutorCalenderScreenState createState() => _TutorCalenderScreenState();
}

class _TutorCalenderScreenState extends State<TutorCalenderScreen> {
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
          appBar: myAppBar(title: "Calender", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            margin: EdgeInsets.only(top: 50.h, left: 40.h, right: 40.h),
            decoration: const BoxDecoration(
              color: AppColor.alphaGrey,
            ),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Select Date & Exam",
                          style: AppTextStyles.textStyleBoldSubTitleLarge,
                        ),
                        space,
                        MyDropDown(
                          leftPadding: 0,
                          rightPadding: 0,
                          isItalicHint: true,
                          onChange: (value) {},
                          hintText: "Select Date",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
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
                          isItalicHint: true,
                          onChange: (value) {},
                          hintText: "Exam Type",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
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
                          isItalicHint: true,
                          onChange: (value) {},
                          hintText: "Exam Sub Type",
                          labelText: "",
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
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
                          hintText: "Select Time",
                          labelText: "",
                          isItalicHint: true,
                          labelColor: AppColor.redColor,
                          borderColor: AppColor.alphaGrey,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
                          suffixIcon: "assets/icons/drop_down_ic.svg",
                          itemFuntion: [
                            DropdownMenuItem(
                              value: "A",
                              child: Text("A",
                                  style: AppTextStyles.textStyleBoldBodySmall),
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
                      ],
                    ),
                  ),
                  Button(
                    buttonText: "Submit",
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      /*   Navigator.of(myContext!).push(MaterialPageRoute(
                          builder: (context) => JobPostedEmployeeScreen()));*/
                    },
                  ),
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
