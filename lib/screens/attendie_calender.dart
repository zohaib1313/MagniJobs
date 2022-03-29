import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/models/all_lessons_model.dart';
import 'package:magnijobs_rnr/screens/tutor_calender_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../view_models/attendie_profile_view_model.dart';

class AttendieCalender extends StatefulWidget {
  bool showBookButton;
  bool isBookingLesson;

  AttendieCalender.AttendieLessonBooking(
      {Key? key, this.showBookButton = true, this.isBookingLesson = true})
      : super(key: key);
  static const id = "AttendieCalender";

  @override
  _AttendieCalenderState createState() => _AttendieCalenderState();
}

class _AttendieCalenderState extends State<AttendieCalender> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<AttendieProfileViewModel>(myContext!, listen: false);

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
          appBar: myAppBar(title: "Lessons", actions: [
            /* const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )*/
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            // margin: EdgeInsets.only(top: 50.h, left: 40.h, right: 40.h),
            decoration: const BoxDecoration(
              color: AppColor.alphaGrey,
            ),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: view.allLessonsList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return rowItem(view.allLessonsList![index]);
                        }),
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

  Widget rowItem(Lessons lesson) {
    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text(lesson.lesson ?? ''),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lesson.lessonTime ?? ''),
            Text(lesson.category ?? ''),
            Text(lesson.description ?? ''),
            Text(DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(lesson.lessonDate ?? ''))
                .toString()),
          ],
        ),
        trailing: (widget.showBookButton)
            ? ElevatedButton(
                child: const Text('Book Lesson'),
                onPressed: () {
                  if (widget.isBookingLesson) {
                    view.bookLesson(
                        id: lesson.id ?? 0,
                        completion: () {
                          AppPopUps.showAlertDialog(message: 'Lesson Booked');
                        });
                  } else {
                    Navigator.of(myContext!).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => TutorCalenderScreen(
                          lessonId: (lesson.id ?? -1).toString(),
                          lessonLink: lesson.meeting_link ?? '',
                        ),
                      ),
                    );
                  }
                },
              )
            : null,
      ),
    );
  }
}
