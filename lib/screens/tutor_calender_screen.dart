import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/calender_applicant_bookings_view_model.dart';
import 'package:provider/provider.dart';

class TutorCalenderScreen extends StatefulWidget {
  TutorCalenderScreen({Key? key}) : super(key: key);
  static const id = "TutorCalenderScreen";

  @override
  _TutorCalenderScreenState createState() => _TutorCalenderScreenState();
}

class _TutorCalenderScreenState extends State<TutorCalenderScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<CalenderApplicantBookingsViewModel>(myContext!);

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
                        InkWell(
                          onTap: () {
                            showDatePickerDialog(
                                context: context,
                                onDateSelected: ((value) {
                                  view.selectedDateController.text =
                                      value.toString();
                                }));
                          },
                          child: MyTextField(
                            leftPadding: 0,
                            rightPadding: 0,
                            enable: false,
                            fillColor: AppColor.greyColor.withOpacity(0.34),
                            textColor: AppColor.blackColor,
                            hintColor: AppColor.blackColor,
                            labelColor: AppColor.blackColor,
                            hintText: "Select Date",
                            controller: view.selectedDateController,
                            labelText: "Select Date",
                            validator: (string) {
                              if (string == null || string.isEmpty) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                          ),
                        ),
                        space,
                        /*   MyDropDown(
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
                        ),*/

                        MyTextField(
                          leftPadding: 0,
                          rightPadding: 0,
                          enable: true,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
                          textColor: AppColor.blackColor,
                          hintColor: AppColor.blackColor,
                          labelColor: AppColor.blackColor,
                          hintText: "Exam Type",
                          controller: view.examTypeController,
                          labelText: "Exam Type",
                          validator: (string) {
                            if (string == null || string.isEmpty) {
                              return 'Enter Value';
                            }
                            return null;
                          },
                        ),
                        space,
                        MyTextField(
                          leftPadding: 0,
                          rightPadding: 0,
                          enable: true,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
                          textColor: AppColor.blackColor,
                          hintColor: AppColor.blackColor,
                          labelColor: AppColor.blackColor,
                          hintText: "Exam Sub Type",
                          controller: view.examSubTypeController,
                          labelText: "Exam Sub Type",
                          validator: (string) {
                            if (string == null || string.isEmpty) {
                              return 'Enter Value';
                            }
                            return null;
                          },
                        ),
                        space,
                        MyTextField(
                          leftPadding: 0,
                          rightPadding: 0,
                          enable: true,
                          keyboardType: TextInputType.number,
                          fillColor: AppColor.greyColor.withOpacity(0.34),
                          textColor: AppColor.blackColor,
                          hintColor: AppColor.blackColor,
                          labelColor: AppColor.blackColor,
                          hintText: "Select hours",
                          controller: view.selectedTimeController,
                          labelText: "Select hours",
                          validator: (string) {
                            if (string == null || string.isEmpty) {
                              return 'Enter Value';
                            }
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
                      view.placeBookings(completion: () {
                        view.resetDate();
                        AppPopUps.showAlertDialog(message: 'Bookings Placed');
                      });
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
