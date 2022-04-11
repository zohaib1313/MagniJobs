import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/dio_network/api_client.dart';
import 'package:magnijobs_rnr/dio_network/api_response.dart';
import 'package:magnijobs_rnr/dio_network/api_route.dart';
import 'package:magnijobs_rnr/models/get_all_packges.dart';

import '../models/my_subscription_model.dart';
import '../routes.dart';

class MySubscriptionViewModel extends ChangeNotifier {
  Subscriptions? mySubScription;
  List<Packages>? allPackages;

  getAllPackages({completion}) async {
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.get_all_packages,
              // body: body,
            ),
            create: () =>
                APIResponse<PackagesModel>(create: () => PackagesModel()),
            apiFunction: getAllPackages)
        .then((response) {
      AppPopUps().dissmissDialog();
      allPackages = response.response?.data?.packages ?? [];

      completion();
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
    });
  }

  void getSubscriptions({onCompleteA}) {
    AppPopUps().showProgressDialog(context: myContext!);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.my_subscriptions,
              body: {},
            ),
            create: () => APIResponse<MySubScriptionModel>(
                create: () => MySubScriptionModel()),
            apiFunction: getSubscriptions)
        .then((response) {
      if (response.response?.data?.subscriptions != null) {
        if (response.response!.data!.subscriptions!.isNotEmpty) {
          mySubScription = response.response!.data!.subscriptions!.last;
        }
      }
      getAllPackages(completion: () {
        onCompleteA();
        setMyPackge();
      });
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();

      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
    });
  }

  Packages? myPackage;

  setMyPackge() {
    if (mySubScription != null) {
      print("my package id= ${mySubScription!.packageId}");
      print("my package id= ${mySubScription!.packageId}");

      allPackages?.forEach((element) {
        if ((element.id ?? -1).toString() ==
            (mySubScription!.packageId ?? "-11")) {
          myPackage = element;
        }
      });
    }
  }
}
