import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class JobPostedScreen extends StatefulWidget {
  JobPostedScreen({Key? key}) : super(key: key);
  static const id = "JobPostedScreen";

  @override
  _JobPostedScreenState createState() => _JobPostedScreenState();
}

class _JobPostedScreenState extends State<JobPostedScreen> {
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
          appBar: myAppBar(title: "Jobs Posted", actions: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                space,
                space,
                space,
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                child: Text(
                                  "Recent",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.w, right: 40.w),
                        color: AppColor.alphaGrey,
                        width: 2,
                        height: 50.h,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.arrow_upward,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  size: 20,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                "Sort",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.w, right: 40.w),
                        color: AppColor.alphaGrey,
                        width: 2,
                        height: 50.h,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.filter_alt_rounded),
                            Expanded(
                              child: Text(
                                "Filter",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                space,
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        getRowJob(),
                        getRowJob(),
                        getRowJob(),
                        getRowJob(),
                        getRowJob(),
                        getRowJob(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getRowJob() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(50.r),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 45,
                child: Image.asset(
                  "assets/images/app_logo_img.png",
                ),
              )),
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: 45.r, left: 20.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Certified Nursing Assistant",
                      style: AppTextStyles.textStyleBoldSubTitleLarge,
                    ),
                    Text(
                      "London, United Kingdom",
                      style: AppTextStyles.textStyleBoldBodyMedium
                          .copyWith(color: AppColor.primaryBlueColor),
                    ),
                    Text(
                      "\$20k/ Year",
                      style: AppTextStyles.textStyleBoldBodyMedium
                          .copyWith(color: AppColor.primaryBlueColor),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
