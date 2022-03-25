

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/network.dart';

class StripeRepo{
  static Future<dynamic> stripeInfo() async {

    return await NetworkService().get(url: ApiConstants.baseUrl + ApiConstants.get_stripe_key).then((response) {
      if (response.statusCode == 200) {
        var encodedOrder = json.decode(response.body);
        return encodedOrder;
      } else {
        return [];
      }
    });

  }

  Future<dynamic> payForMySubscription(int subscriptionId) async {

    Map data = {
      'subscription_id': subscriptionId,
    };

    String body = json.encode(data);
    var response = await Dio().post(ApiConstants.baseUrl + ApiConstants.create_payment_intent, data: body, options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json'
        }
    ));
    return response;

  }

}