import 'package:flutter/material.dart';

import '../common_widgets/app_popups.dart';
import '../dio_network/APis.dart';
import '../dio_network/api_client.dart';
import '../dio_network/api_response.dart';
import '../dio_network/api_route.dart';
import '../models/booking_history_model.dart';
import '../routes.dart';

class TutorBookingJobHistoryViewModel extends ChangeNotifier {
  List<Bookings>? bookingsList;

  getBookingHistory({required completion}) async {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};

    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.my_bookings,
              body: body,
            ),
            create: () => APIResponse<BookingHistoryModel>(
                create: () => BookingHistoryModel()),
            apiFunction: getBookingHistory)
        .then((response) {
      bookingsList = response.response?.data?.bookings ?? [];

      AppPopUps().dissmissDialog();
      completion();
    }).catchError((error) {
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
      return Future.value(null);
    });
  }

  void cancelBooking(Bookings booking, BuildContext context) {
    AppPopUps().showProgressDialog(context: myContext);
    Map<String, dynamic> body = {};

    String s = ApiConstants.baseUrl +
        ApiConstants.cancelBookings +
        "/${booking.id ?? 0}";
    var client = APIClient(isCache: false, baseUrl: s);
    client
        .request(
            route: APIRoute(
              APIType.cancelBookings,
              body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: getBookingHistory)
        .then((response) {
      AppPopUps().dissmissDialog();
      if (response.response?.status ?? false) {
        bookingsList?.clear();
        notifyListeners();
        getBookingHistory(completion: () {
          AppPopUps.showSnackvBar(
              context: context, message: 'Booking Canceled');
        });
      }
    }).catchError((error) {
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
      return Future.value(null);
    });
  }
}
