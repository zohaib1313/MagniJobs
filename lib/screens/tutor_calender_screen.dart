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

import '../models/all_lessons_model.dart';

class TutorCalenderScreen extends StatefulWidget {
  List<Lessons?> lessons;

  TutorCalenderScreen({Key? key, required this.lessons}) : super(key: key);
  static const id = "TutorCalenderScreen";

  @override
  _TutorCalenderScreenState createState() => _TutorCalenderScreenState();
}

class _TutorCalenderScreenState extends State<TutorCalenderScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<CalenderApplicantBookingsViewModel>(myContext!);

  String selectedLessonId = '';

  @override
  void initState() {
    super.initState();
  }

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
          appBar: myAppBar(title: "Lesson", actions: []),
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 100),
                        child: Form(
                          key: view.formKey,
                          child: Column(
                            children: [
                              Text(
                                "Select Date & Exam",
                                style: AppTextStyles.textStyleBoldSubTitleLarge,
                              ),
                              space,
                              MyDropDown(
                                onChange: (value) {
                                  selectedLessonId = value.toString();
                                },
                                labelText: "",
                                hintText: 'Select Lesson',
                                leftPadding: 0,
                                rightPadding: 0,
                                labelColor: AppColor.redColor,
                                borderColor: AppColor.alphaGrey,
                                fillColor: AppColor.greyColor.withOpacity(0.34),
                                suffixIcon: "assets/icons/drop_down_ic.svg",
                                itemFuntion: widget.lessons
                                    .map((e) => DropdownMenuItem(
                                          value: e?.id.toString(),
                                          child: Text(
                                            e?.lesson ?? '',
                                            style: AppTextStyles
                                                .textStyleBoldBodySmall,
                                          ),
                                        ))
                                    .toList(),
                                validator: (string) {
                                  return null;
                                },
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
                                  fillColor:
                                      AppColor.greyColor.withOpacity(0.34),
                                  textColor: AppColor.blackColor,
                                  hintColor: AppColor.blackColor,
                                  labelColor: AppColor.blackColor,
                                  hintText: "Select Date",
                                  controller: view.selectedDateController,
                                  labelText: "Select Date",
                                  validator: (string) {
                                    if (string == null || string.isEmpty) {
                                      return 'Required';
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
                                    return 'Required';
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
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                              /*     space,
                              MyTextField(
                                leftPadding: 0,
                                rightPadding: 0,
                                enable: true,
                                fillColor: AppColor.greyColor.withOpacity(0.34),
                                textColor: AppColor.blackColor,
                                hintColor: AppColor.blackColor,
                                labelColor: AppColor.blackColor,
                                hintText: "Lesson Name",
                                controller: view.lessonNameController,
                                labelText: "Lesson Name",
                                validator: (string) {
                                  if (string == null || string.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),*/
                              space,
                              MyTextField(
                                leftPadding: 0,
                                rightPadding: 0,
                                enable: true,
                                fillColor: AppColor.greyColor.withOpacity(0.34),
                                textColor: AppColor.blackColor,
                                hintColor: AppColor.blackColor,
                                labelColor: AppColor.blackColor,
                                hintText: "Lesson Link",
                                controller: view.lessonLinkController,
                                labelText: "Lesson Link",
                                validator: (string) {
                                  if (string == null || string.isEmpty) {
                                    return 'Required';
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
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                              space,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button(
                    buttonText: "Submit",
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      if (view.formKey.currentState!.validate()) {
                        if (selectedLessonId.isNotEmpty) {
                          view.placeBookings(
                            id: (selectedLessonId).toString(),
                            completion: () {
                              view.resetDate();
                              AppPopUps.showAlertDialog(
                                  message: 'Bookings Placed');
                            },
                          );
                        } else {
                          AppPopUps.showSnackvBar(
                              message: 'Select Lesson', context: context);
                        }
                      }
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
