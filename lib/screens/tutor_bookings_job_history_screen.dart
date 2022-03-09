import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/models/booking_history_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:provider/provider.dart';

import '../view_models/tutor_booking_job_view_model.dart';

class TutorBookingJobHistory extends StatefulWidget {
  TutorBookingJobHistory({Key? key}) : super(key: key);
  static const id = "TutorCalenderScreen";

  @override
  _TutorBookingJobHistoryState createState() => _TutorBookingJobHistoryState();
}

class _TutorBookingJobHistoryState extends State<TutorBookingJobHistory> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<TutorBookingJobHistoryViewModel>(myContext!);

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
          appBar: myAppBar(title: "Booking History", actions: []),
          backgroundColor: AppColor.alphaGrey,
          body: Builder(builder: (cc) {
            return Container(
              // height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.only(top: 50.h, left: 40.h, right: 40.h),
              decoration: const BoxDecoration(
                color: AppColor.alphaGrey,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bookings",
                          style: AppTextStyles.textStyleBoldSubTitleLarge,
                        ),
                        space,
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: view.bookingsList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return getRow(view.bookingsList![index], cc);
                          },
                        ),
                        space,
                      ],
                    ),
                  ),
                  space,
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  getRow(Bookings booking, BuildContext context) {
    return InkWell(
      onTap: () {
        AppPopUps.showAlertDialog(
            message: 'Are you sure to cancel booking',
            onSubmit: () {
              view.cancelBooking(booking, context);
            });
      },
      child: Card(
        child: ListTile(
          title: Text("Exam Type: ${booking.examType ?? ""}",
              style: AppTextStyles.textStyleBoldBodyMedium),
          subtitle: Text("Exam sub-type: ${booking.examSubType ?? ""}",
              style: AppTextStyles.textStyleBoldBodySmall),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" ${booking.time ?? ""} :Hrs",
                  style: AppTextStyles.textStyleNormalBodyXSmall),
            ],
          ),
          trailing: Text(
              " ${DateFormat('dd-MM-yyyy').format(DateTime.parse(booking.date ?? ''))} ",
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleNormalBodyXSmall),
        ),
      ),
    );
  }
}
