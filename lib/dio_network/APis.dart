enum APIType {
  loginUser,
  get_all_jobs,
  check_my_phone_number,
  verify_my_phone_number,
  get_all_employers,
  get_all_packages,
  get_my_profile,
  get_jobseeker_profile,
  update_my_profile,
  post_a_job,
  update_job_post,
  delete_job,
  get_my_jobs_as_an_employer,
  register_new_applicant,
  register_new_employer,
  register_new_tutor,
  logout,
  all_candidates,
  upload_my_resume,
  upload_my_nurse__certificate,
  upload_my_national_id,
  upload_my_business_registration,
  upload_my_covid_certificate,
  assign_applicant_to_employee,
  forgotPassword,
  sendMailForgotPassword,
  applyForJob,
  all_countries,
  update_tutor_profile,
  update_employer_profile,
  place_booking,
  my_bookings,
  cancelBookings,
  candidateByCountry,
  jobByCountry,
  getMyJobs,
  cancelApplication,
  allLessons,
  bookWithTutor,
  get_stripe_key,
  create_payment_intent,
  confirm_subs_payment,
  my_subscriptions,
  my_lessons,
  cancel_lesson,
  interested_applicants,
  all_job_types,
  all_job_subtypes,
  count_jobs,
  add_new_lesson,
}

class ApiConstants {
  // static const baseUrl = "http://magnijobs.applypressure.co.uk/api/";
  static const baseUrl = "http://app.magnijobs.com/api/";
  static const loginUser = 'login';
  static const get_all_jobs = "all-jobs";
  static const check_my_phone_number = "check-number/";
  static const verify_my_phone_number = "verify-otp";
  static const get_all_employers = "all-employers";
  static const get_all_packages = "all-packages";
  static const get_my_profile = "user";
  static const get_jobseeker_profile = "jobseeker-profile/";
  static const update_my_profile = "update-profile";
  static const post_a_job = "post-job";
  static const update_job_post = "update-job/";
  static const delete_job = "delete-job/";
  static const get_my_jobs_as_an_employer = "employer-jobs";
  static const register_new_applicant = "register";
  static const register_new_employer = "register-employer";
  static const register_new_tutor = "register-tutor";
  static const logout = "logout";
  static const all_candidates = "applicants";
  static const upload_my_resume = "upload-cv";
  static const upload_my_nurse__certificate = "upload-nurse-certificate";
  static const upload_my_national_id = "upload-national-id";
  static const upload_my_business_registration = "upload-business-reg";
  static const upload_my_covid_certificate = "upload-covid-cert";
  static const assign_applicant_to_employee = "assign-applicant";
  static const forgotPassword = "password/reset";
  static const sendMailForgotPassword = "password/email";
  static const applyForJob = "apply-job";
  static const all_countries = "all-countries";
  static const update_tutor_profile = "update-tutor-profile";
  static const update_employer_profile = "update-employer-profile";
  static const place_booking = "place-booking";
  static const my_bookings = "my-bookings";
  static const cancelBookings = "cancel-booking";
  static const candidateByCountry = "candidates-by-country";
  static const jobByCountry = "jobs-in-countries";
  static const getMyJobs = "my-applications";
  static const cancelApplication = "cancel-application";
  static const allLessons = "all-lessons";
  static const bookWithTutor = "book-lesson";
  static const get_stripe_key = "get-stripe-key";
  static const create_payment_intent = "make-stripe-intent";
  static const confirm_subs_payment = "subscribe-plan";
  static const my_subscriptions = "my-subscriptions";
  static const my_lessons = "my-lessons";
  static const cancel_lesson = "cancel-lesson";
  static const all_job_types = "all-job-types";
  static const all_job_subtypes = "all-job-subtypes";

  static const interested_applicants = "interested-applicants";

  static const count_jobs = "count-jobs";
  static const add_new_lesson = "add-new-lesson";

/*  static var profilePicsBaseUrl =
      'http://magnijobs.applypressure.co.uk/profile_pics/';
  static var employer_logos =
      'http://magnijobs.applypressure.co.uk/employer_logos/';*/

  static var profilePicsBaseUrl = 'http://app.magnijobs.com/profile_pics/';
  static var employer_logos = 'http://app.magnijobs.com/employer_logos/';
}
