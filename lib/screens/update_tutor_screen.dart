import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/update_tutor_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../common_widgets/app_popups.dart';

class UpdateTutorProfileScreen extends StatefulWidget {
  UpdateTutorProfileScreen({Key? key}) : super(key: key);
  static const id = "UpdateTutorProfileScreen";

  @override
  _UpdateTutorProfileScreenState createState() =>
      _UpdateTutorProfileScreenState();
}

class _UpdateTutorProfileScreenState extends State<UpdateTutorProfileScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<UpdateTutorProfileViewModel>(myContext!);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    view.setValuesWithSharedPref();
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
            /*   const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )*/
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
                    child: Form(
                      key: view.formKey,
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
                          getInputItem(
                              hint: "First name",
                              validateDate: true,
                              controller: view.firstnameContoller),
                          getInputItem(
                              hint: "Last name",
                              validateDate: true,
                              controller: view.lastNameController),
                          getInputItem(
                              hint: "Email",
                              validateDate: true,
                              enabled: false,
                              controller: view.emailController),
                          getInputItem(
                              hint: "Mobile",
                              enabled: false,
                              validateDate: true,
                              controller: view.mobileController),
                          getInputItem(
                              hint: "Address",
                              validateDate: true,
                              controller: view.addressController),
                          space,
                          getInputItem(
                              hint: "Company Name",
                              validateDate: true,
                              controller: view.companyController),
                          space,
                          space,
                        ],
                      ),
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
                      if (view.formKey.currentState!.validate()) {
                        view.updateProfile(onComplete: () {
                          AppPopUps.showAlertDialog(message: 'Profile updated');
                        });
                      }
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

  getInputItem(
      {required String hint,
      bool enabled = true,
      required controller,
      bool validateDate = false}) {
    return Column(
      children: [
        space,
        MyTextField(
          leftPadding: 0,
          enable: enabled,
          onChanged: (onChange) {},
          controller: controller,
          rightPadding: 0,
          hintText: hint,
          fillColor: AppColor.whiteColor,
          unfocusBorderColor: AppColor.alphaGrey,
          labelColor: AppColor.blackColor,
          textColor: AppColor.blackColor,
          hintColor: AppColor.blackColor,
          validator: (s) {
            if (s!.isEmpty && validateDate) {
              return "enter $hint";
            }
            return null;
          },
        ),
      ],
    );
  }
}
