import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/network.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

class StripeRepo {
  static Future<dynamic> stripeInfo() async {
    return await NetworkService()
        .get(url: ApiConstants.baseUrl + ApiConstants.get_stripe_key)
        .then((response) {
      if (response.statusCode == 200) {
        var encodedOrder = json.decode(response.body);
        return encodedOrder;
      } else {
        return [];
      }
    });
  }

  Future<dynamic> payForMySubscription(int packageId) async {
    Map data = {
      'package_id': packageId,
    };

    String body = json.encode(data);

    var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.create_payment_intent,
        data: body,
        options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${UserDefaults.getToken() ?? ""}'
            }));
    printWrapped(response.toString());
    return response;
  }

  static Future<dynamic> confirmSubscriptionPayment(
      int? packageID, String? price, String paymentId) async {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['package_id'] = packageID;
    data['amount'] = price;
    data['payment_method'] = 'Stripe';
    data['payment_reference'] = paymentId;

    return await NetworkService()
        .post(
            url: ApiConstants.baseUrl + ApiConstants.confirm_subs_payment,
            body: data)
        .then((response) {
      if (response.statusCode == 200) {
        var encodedOrder = json.decode(response.body);
        return encodedOrder;
      } else {
        return [];
      }
    });
  }
}
