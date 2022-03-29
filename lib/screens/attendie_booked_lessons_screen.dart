import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/attendie_profile_view_model.dart';
import 'package:provider/provider.dart';

class AttendieBookedLessonScreen extends StatefulWidget {
  AttendieBookedLessonScreen({Key? key}) : super(key: key);
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
        child: Scaffold(
          appBar: myAppBar(
              context: context, title: "My Booked Lessons", actions: []),
          backgroundColor: AppColor.alphaGrey,
          body: Container(
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
            child: view.myLessonModel == null
                ? const Center(
                    child: Text('No Booking Found'),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: 3,
                    itemCount: view.myLessonModel?.bookings?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Lesson name"),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
