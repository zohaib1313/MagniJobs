import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/styles.dart';

import '../routes.dart';

class BottomSheets {
  //bool isDialogShowing = false;
  static final BottomSheets _singleton = BottomSheets._internal();

  factory BottomSheets() {
    return _singleton;
  }

  BottomSheets._internal();

  showBottomSheet({Widget? child, BuildContext? context}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 0,
        isScrollControlled: true,
        enableDrag: false,
        context: context!,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(top: 80.h, left: 30.w, right: 30.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100.r),
                  topLeft: Radius.circular(100.r)),
            ),
            child: Column(
              children: [
                /*    Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Center(
                    child: Container(
                      width: 220.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: AppColor.alphaGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),*/
                Expanded(child: child!)
              ],
            ),
          );
        });
  }

  showAppAlertBottomSheet(
      {isDismissable, Widget? child, BuildContext? context}) {
    //   isDialogShowing =true;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: isDismissable ?? false,
      context: myContext!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return child!;
      },
    ).then((value) {
      //  isDialogShowing = false;
    });
  }
}
