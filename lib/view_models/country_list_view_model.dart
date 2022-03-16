import 'package:flutter/cupertino.dart';

import '../dio_network/APis.dart';
import '../dio_network/api_client.dart';
import '../dio_network/api_response.dart';
import '../dio_network/api_route.dart';
import '../models/countries_model.dart';

class CountriesListViewModel extends ChangeNotifier {
  loadCountries({completion}) {
    var client = APIClient(isCache: false, baseUrl: ApiConstants.baseUrl);
    client
        .request(
            route: APIRoute(
              APIType.all_countries,
              body: {},
            ),
            create: () =>
                APIResponse<CountriesModel>(create: () => CountriesModel()),
            apiFunction: loadCountries)
        .then((response) {
      if (response.response?.data != null) {
        CountriesModel? countriesModel = response.response!.data;
        completion(countriesModel);
      }
    }).catchError((error) {});
  }
}
