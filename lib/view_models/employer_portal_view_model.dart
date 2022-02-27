import 'package:flutter/material.dart';

class EmployerPortalViewModel extends ChangeNotifier {
  void logout({onComplete}) {
    onComplete();
    /* AppPopUps().showProgressDialog(context: myContext);
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.logout,
              // body: body,
            ),
            create: () => APIResponse(decoding: false),
            apiFunction: logout)
        .then((response) {
      AppPopUps().dissmissDialog();
      onComplete();
    }).catchError((error) {
      print("error=  ${error.toString()}");
      AppPopUps().dissmissDialog();
      AppPopUps().showErrorPopUp(
          title: 'Error',
          error: error.toString(),
          onButtonPressed: () {
            Navigator.of(myContext!).pop();
          });
      return Future.value(null);
    });*/
  }
}
