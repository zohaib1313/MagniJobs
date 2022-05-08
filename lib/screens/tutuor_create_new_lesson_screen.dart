import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/tutor_create_new_lesson_controller.dart';
import 'package:provider/provider.dart';

class TutorCreateNewLessonScreen extends StatefulWidget {
  const TutorCreateNewLessonScreen({Key? key}) : super(key: key);

  static const id = "TutorCreateNewLessonScreen";

  @override
  _TutorCreateNewLessonScreenState createState() =>
      _TutorCreateNewLessonScreenState();
}

class _TutorCreateNewLessonScreenState
    extends State<TutorCreateNewLessonScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<TutorCreateNewLessonViewModel>(myContext!);

  @override
  void initState() {
    view.resetDate();
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
                                "Create a new lesson",
                                style: AppTextStyles.textStyleBoldSubTitleLarge,
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
                                hintText: "Category",
                                controller: view.categoryController,
                                labelText: "Category",
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
                                hintText: "Lesson",
                                controller: view.lessonNameController,
                                labelText: "Lesson",
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
                                hintText: "Description",
                                controller: view.lessonDescription,
                                labelText: "Description",
                                validator: (string) {
                                  if (string == null || string.isEmpty) {
                                    return 'Required';
                                  }
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
                              MyTextField(
                                leftPadding: 0,
                                rightPadding: 0,
                                enable: true,
                                fillColor: AppColor.greyColor.withOpacity(0.34),
                                textColor: AppColor.blackColor,
                                hintColor: AppColor.blackColor,
                                labelColor: AppColor.blackColor,
                                hintText: "Meeting Link",
                                controller: view.lessonLinkController,
                                labelText: "Meeting Link",
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
                        view.createLesson(
                          completion: () {
                            view.resetDate();
                            AppPopUps.showAlertDialog(
                                message: 'Lesson created');
                          },
                        );
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
