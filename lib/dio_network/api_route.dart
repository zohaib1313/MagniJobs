import 'package:dio/dio.dart';

import 'APis.dart';

class APIRoute implements APIRouteConfigurable {
  final APIType? type;
  final String? routeParams;
  Map<String, dynamic>? headers;
  dynamic body;

  APIRoute(this.type, {this.routeParams, this.headers, this.body});

  /// Return config of api (method, url, header)
  @override
  RequestOptions getConfig() {
    // pass extra value to detect public or auth api

    switch (type) {
      case APIType.loginUser:
        return RequestOptions(
          path: ApiConstants.loginUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );

      case APIType.get_all_jobs:
        return RequestOptions(
          path: ApiConstants.get_all_jobs,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.check_my_phone_number:
        return RequestOptions(
          path: "",
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.verify_my_phone_number:
        return RequestOptions(
          path: ApiConstants.verify_my_phone_number,
          headers: headers,
          //  contentType: ContentType.parse(value),
          data: body,
          method: APIMethod.post,
        );
      case APIType.get_all_employers:
        return RequestOptions(
          path: ApiConstants.get_all_employers,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.get_all_packages:
        return RequestOptions(
          path: ApiConstants.get_all_packages,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.get_my_profile:
        return RequestOptions(
          path: ApiConstants.get_my_profile,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.get_jobseeker_profile:
        return RequestOptions(
          path: "",
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.update_my_profile:
        return RequestOptions(
          path: ApiConstants.update_my_profile,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.post_a_job:
        return RequestOptions(
          path: ApiConstants.post_a_job,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.update_job_post:
        return RequestOptions(
          path: ApiConstants.update_job_post,
          headers: headers,
          data: body,
          method: APIMethod.put,
        );
      case APIType.delete_job:
        return RequestOptions(
          path: ApiConstants.delete_job,
          headers: headers,
          data: body,
          method: APIMethod.delete,
        );
      case APIType.get_my_jobs_as_an_employer:
        return RequestOptions(
          path: ApiConstants.get_my_jobs_as_an_employer,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.register_new_applicant:
        return RequestOptions(
          path: ApiConstants.register_new_applicant,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.register_new_employer:
        return RequestOptions(
          path: ApiConstants.register_new_employer,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.register_new_tutor:
        return RequestOptions(
          path: ApiConstants.register_new_tutor,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.logout:
        return RequestOptions(
          path: ApiConstants.logout,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.all_candidates:
        return RequestOptions(
          path: ApiConstants.all_candidates,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.upload_my_resume:
        return RequestOptions(
          path: ApiConstants.upload_my_resume,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.upload_my_nurse__certificate:
        return RequestOptions(
          path: ApiConstants.upload_my_nurse__certificate,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.upload_my_national_id:
        return RequestOptions(
          path: ApiConstants.upload_my_national_id,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.upload_my_business_registration:
        return RequestOptions(
          path: ApiConstants.upload_my_business_registration,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.upload_my_covid_certificate:
        return RequestOptions(
          path: ApiConstants.upload_my_covid_certificate,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.assign_applicant_to_employee:
        return RequestOptions(
          path: ApiConstants.assign_applicant_to_employee,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.forgotPassword:
        return RequestOptions(
          path: ApiConstants.forgotPassword,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.sendMailForgotPassword:
        return RequestOptions(
          path: ApiConstants.sendMailForgotPassword,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.applyForJob:
        return RequestOptions(
          path: ApiConstants.applyForJob,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.all_countries:
        return RequestOptions(
          path: ApiConstants.all_countries,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );

      case APIType.update_tutor_profile:
        return RequestOptions(
          path: ApiConstants.update_tutor_profile,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.update_employer_profile:
        return RequestOptions(
          path: ApiConstants.update_employer_profile,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.place_booking:
        return RequestOptions(
          path: ApiConstants.place_booking,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.my_bookings:
        return RequestOptions(
          path: ApiConstants.my_bookings,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.candidateByCountry:
        return RequestOptions(
          path: ApiConstants.candidateByCountry,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.cancelBookings:
        return RequestOptions(
          path: '',
          headers: headers,
          data: body,
          method: APIMethod.delete,
        );
      case APIType.jobByCountry:
        return RequestOptions(
          path: ApiConstants.jobByCountry,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      case APIType.getMyJobs:
        return RequestOptions(
          path: ApiConstants.getMyJobs,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.cancelApplication:
        return RequestOptions(
          path: '',
          headers: headers,
          data: body,
          method: APIMethod.delete,
        );
      case APIType.allLessons:
        return RequestOptions(
          path: ApiConstants.allLessons,
          headers: headers,
          data: body,
          method: APIMethod.get,
        );
      case APIType.bookWithTutor:
        return RequestOptions(
          path: ApiConstants.bookWithTutor,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
      default:
        return RequestOptions(
          path: ApiConstants.loginUser,
          headers: headers,
          data: body,
          method: APIMethod.post,
        );
    }
  }
}

abstract class APIRouteConfigurable {
  RequestOptions getConfig();
}

class APIMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE'; //delete
}
