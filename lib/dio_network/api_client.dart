import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';

import 'APis.dart';
import 'api_response.dart';
import 'api_route.dart';
import 'decodable.dart';

abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    @required APIRouteConfigurable? route,
    @required Create<T> create,
  });
}

class APIClient implements BaseAPIClient {
  Dio? instance;
  bool isCache;
  String baseUrl;
  String contentType;
  bool isDialoigOpen;

  APIClient(
      {this.isCache = true,
      this.baseUrl = ApiConstants.baseUrl,
      this.isDialoigOpen = true,
      this.contentType = 'application/json'}) {
    instance = Dio();

    if (instance != null) {
      instance!.interceptors.add(LogInterceptor());
      if (isCache) {
        List<String> allowedSHa = [];
        //   allowedSHa.add('KEZJOdneURbhMeANe+HVaw0mcmPp6zKFKr6jHc85o0E=');
        // instance!.interceptors.add(DioCacheInterceptor(
        //     options: CacheOption(CachePolicy.forceCache).options));
        //  instance!.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedSHa));
      } else {
        // instance!.interceptors.add(DioCacheInterceptor(options: CacheOption(CachePolicy.noCache).options));
      }
    }
  }

  Map<String, dynamic> headers = {
    // 'Authorization':
    //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTI1MzM0N2Y2ODFmNTRlZTdhZDBkZjYzNmQxMmQzZmQ2ZjcwMTgwNDJiNjE5OTVlZGVhZjZkZWNjOWU3YzEzZjU1NGI5YzBjYmE5MDI1ZjkiLCJpYXQiOjE2NDQ4NTU0MjguMDA4NjA0LCJuYmYiOjE2NDQ4NTU0MjguMDA4NjA2LCJleHAiOjE2NjA0OTM4MjguMDAwNzc0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.mwSj2JzSnws9nmSXQssN8DeLOCash-HMMZVy4xc5BnkVM2R1XQfAi9s5eZ_bowcNEafrIpwZwvRnMDtydYtI_-VyyzBXeuK4Hlw4Mdq1H0Aiboe_8_qeEYKSUFAixpJfjwHUTGYmUG3nRvHqDlKV35IbuG2etbdJFn0XHcxwRcHPPQgwKsMSAt0ly3EKUojgeHGm0RkWb1zJ1ZeTYBHENsCmq3fG4p8IYr6cewK7iF7SdrnFAxxc2TcVPir3Jtzsn7VRNwZYKOmVr0G0HMtQLvfRwKqL_CD_W9jT7QgCFbXKOV719pVx8Ev5uRN7ficPXhjK-bGzlofvEAHJGt2XKWSXLGn3xeTrFZX2JnLn_flLZR4RXNpYeohFsSJbCDBn4i8PZC12FaIlR5TSt99VLL9lvFL6HwI39_z9wyfXFuZ-uV7b__nAxRboK3vGx2co9kLNgp2oIHhtS4WP4CJTVls42Z5zSgd0qlloVz6LIA0JQu9WdU7esXTqnbhX6I1_7cNNB2Jw93wj5f6aBm7HwnAVDyuJivF4Zp3I9S1tYN_Ex3KGT6hVXhkzUMrTul3VsacXig9CpuD8fUa_9AY_T5NgyNPgNK8PCZxvB76A3Mc-bCiDmPBKSuoOAoLyTvxIcO9aq_RO2yI6T5fQ87XBTGVZ-Rw0F7nbcUWF5qlsBco',
    // 'charset': 'utf-8'
    'Authorization': 'Bearer ${UserDefaults.getToken() ?? ""}'
  };

  @override
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    @required APIRouteConfigurable? route,
    @required Create<T>? create,
    Function? apiFunction,
  }) async {
    print(headers);

    final config = route!.getConfig();
    config.baseUrl = baseUrl;
    config.headers = headers;
    config.connectTimeout = 60000;
    config.receiveTimeout = 60000;
    config.followRedirects = false;
    config.validateStatus = (status) {
      return status! <= 500;
    };

    final response = await instance!.fetch(config).catchError((error) {
      // AppPopUps().dissmissDialog();
      print("error in response ${error.toString()}");

      if ((error as DioError).type == DioErrorType.connectTimeout) {
        print('Connection TimeOut ${config.path}');
        if (kDebugMode) {}

        throw error;
      }
    });

    final responseData = response.data;

    print('\n*****response CODE=*******\n' +
        response.statusCode.toString() +
        " \n******************\n");
    printWrapped('\n************response Data=***********\n' +
        response.data.toString() +
        " \n**************\n");

    int statusCode = response.statusCode!;

    switch (statusCode) {
      case 422:
        final errorResponse = ErrorResponse.fromJson(responseData);
        throw errorResponse;

      case 200:
        if (responseData["errors"] != null) {
          final errorResponse = ErrorResponse.fromJson(responseData);
          throw errorResponse;
        }

        var finalResponse =
            ResponseWrapper.init(create: create, json: responseData);
        if (finalResponse.error != null) {
          if (kDebugMode) {
            print('Response Error');
          }
          final errorResponse = finalResponse.error!;
          throw errorResponse;
        } else {
          return ResponseWrapper.init(create: create, json: responseData);
        }
      default:
        final errorResponse = ErrorResponse.fromJson(responseData);
        throw errorResponse;
    }
  }
}
