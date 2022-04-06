import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../styles.dart';
import '../../utils/utils.dart';
import '../../view_models/all_packges_view_model.dart';

class AddPaymentScreen extends StatefulWidget {
  static const id = "AddPaymentScreen";

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<AddPaymentScreen> {
  final space = SizedBox(height: 20.h);
  var view =
      Provider.of<AllPackagesAndPaymentViewModel>(myContext!, listen: false);

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
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
          color: AppColor.primaryBlueColor,
          child: Column(
            children: [
              Text("Add Payment",
                  style: AppTextStyles.textStyleBoldTitleLarge
                      .copyWith(color: AppColor.whiteColor)),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: view.formKey,
                    child: Column(
                      children: [
                        space,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.w),
                          child: ExpandAbleTile(
                            isCheckBox: true,
                            isActiveCheckBox: true,
                            onTapCheckBox: () {},
                            model: ExpandableTileModel(
                                title: view.selectedPaymentMethod?.name ?? "",
                                message:
                                    view.selectedPaymentMethod?.details ?? "",
                                isExpanded: false),
                          ),
                        ),
                        space,
                        MyTextField(
                          hintText: "Card Number",
                          controller: view.cardNumberController,
                          labelColor: AppColor.whiteColor,
                          unfocusBorderColor: AppColor.primaryBlueDarkColor,
                          textColor: AppColor.whiteColor,
                          /*keyboardType: TextInputType.number,*/
                          hintColor: AppColor.whiteColor,
                          fillColor: AppColor.primaryBlueDarkColor,
                          validator: (s) {
                            if ((s ?? '').isEmpty) {
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
                                  view.dueDateController.text =
                                      value.toString();
                                }));
                          },
                          child: MyTextField(
                            enable: false,
                            controller: view.dueDateController,
                            hintText: "Date of Expiration",
                            unfocusBorderColor: AppColor.primaryBlueDarkColor,
                            textColor: AppColor.whiteColor,
                            hintColor: AppColor.whiteColor,
                            focusBorderColor: Colors.transparent,
                            labelColor: AppColor.whiteColor,
                            fillColor: AppColor.primaryBlueDarkColor,
                            validator: (s) {
                              if ((s ?? '').isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        space,
                        MyTextField(
                          hintText: "Name Used On Card",
                          controller: view.nameUsedOnCardController,
                          unfocusBorderColor: AppColor.primaryBlueDarkColor,
                          textColor: AppColor.whiteColor,
                          labelColor: AppColor.whiteColor,
                          hintColor: AppColor.whiteColor,
                          fillColor: AppColor.primaryBlueDarkColor,
                          validator: (s) {
                            if ((s ?? '').isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        space,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                          margin: EdgeInsets.only(
                              left: 100.w,
                              right: 100.w,
                              top: 50.h,
                              bottom: 50.h),
                          padding: EdgeInsets.only(
                              left: 150.w,
                              right: 150.w,
                              top: 50.h,
                              bottom: 50.h),
                          child: SvgViewer(
                            height: 100.h,
                            width: 100.h,
                            svgPath: "assets/icons/union_ic.svg",
                          ),
                        ),
                        space,
                        space,
                        Padding(
                          padding: EdgeInsets.only(
                              top: 100.r, left: 100.r, right: 100.r),
                          child: Button(
                            buttonText: "Go Back",
                            textColor: AppColor.primaryBlueDarkColor,
                            color: AppColor.whiteColor,
                            onTap: () {
                              Navigator.of(myContext!).pop();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 100.h,
                              top: 100.r,
                              left: 100.r,
                              right: 100.r),
                          child: Button(
                            buttonText: "Submit Payment",
                            textColor: AppColor.primaryBlueDarkColor,
                            color: AppColor.whiteColor,
                            onTap: () {
                              if (view.formKey.currentState!.validate()) {
                                // view.subscribeToPlan(completion: () {
                                //   Navigator.of(myContext!).push(
                                //     MaterialPageRoute(
                                //       builder: (context) => SigInScreen(
                                //         userType: "employer",
                                //       ),
                                //     ),
                                //   );
                                // });
                              }
                            },
                          ),
                        ),
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                        space,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
