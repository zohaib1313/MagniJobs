import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/attendie_profile_view_model.dart';
import 'package:provider/provider.dart';

class AttendieBookedLessonScreen extends StatefulWidget {
  const AttendieBookedLessonScreen({Key? key}) : super(key: key);
  static const id = "AttendieBookedLessonScreen";

  @override
  _AttendieBookedLessonScreenState createState() =>
      _AttendieBookedLessonScreenState();
}

class _AttendieBookedLessonScreenState
    extends State<AttendieBookedLessonScreen> {
  var view = Provider.of<AttendieProfileViewModel>(myContext!, listen: false);

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
        key: UniqueKey(),
        child: Scaffold(
          key: UniqueKey(),
          appBar: myAppBar(
              context: context, title: "My Booked Lessons", actions: []),
          backgroundColor: AppColor.alphaGrey,
          body: Container(
            key: UniqueKey(),
            //  height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              left: 50.w,
              right: 50.w,
            ),
            decoration: BoxDecoration(
              color: AppColor.alphaGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r)),
            ),
            child: view.myLessonModel?.bookings == null
                ? Center(
                    child: Center(
                        child: Text(
                      'No Booking Found',
                      style: AppTextStyles.textStyleBoldBodyMedium,
                    )),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: view.myLessonModel?.bookings?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        key: UniqueKey(),
                        onTap: () {
                          AppPopUps.showAlertDialog(
                              message: 'Are you sure to cancel this lesson',
                              onSubmit: () {
                                Navigator.of(context).pop();

                                setState(() {});
                                view.cancelLesson(
                                    id: view.myLessonModel!.bookings![index]
                                            .id ??
                                        -1,
                                    completion: () {
                                      view.getMyLessonsBooking(
                                          completion: (model) {
                                        setState(() {});
                                      });
                                    });
                              });
                        },
                        child: Card(
                          key: UniqueKey(),
                          child: Container(
                            key: UniqueKey(),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      view.myLessonModel!.bookings![index]
                                              .category ??
                                          '',
                                      style:
                                          AppTextStyles.textStyleBoldBodyMedium,
                                    ),
                                    Text(
                                      view.myLessonModel!.bookings![index]
                                              .description ??
                                          '',
                                      style: AppTextStyles
                                          .textStyleNormalBodyXSmall,
                                    ),
                                    Text(
                                      view.myLessonModel!.bookings![index]
                                              .notes ??
                                          '',
                                      style: AppTextStyles
                                          .textStyleNormalBodyXSmall,
                                    ),
                                  ],
                                )),
                                Column(
                                  children: [
                                    Text(
                                      view.myLessonModel!.bookings![index]
                                              .lessonDate ??
                                          '',
                                      style: AppTextStyles
                                          .textStyleNormalBodyXSmall,
                                    ),
                                    Text(
                                      view.myLessonModel!.bookings![index]
                                              .lessonTime ??
                                          '',
                                      style: AppTextStyles
                                          .textStyleNormalBodyXSmall,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
