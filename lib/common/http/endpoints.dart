import 'package:raw_chem/app/app_prefs.dart';
import 'package:raw_chem/app/imports.dart';

abstract interface class Endpoints {
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOTP = '/auth/verify-otp';
  static const String field = '/settings/fields';
  //---welcomeScreens
  static const String welcomeScreens = "/settings/welcome-screens";
  static const String settings = "/settings";
  //---parentChildren
  static const String parentChildren = "/parent/children";
  static const String linkPlayerByCode = '/parent/players/link-by-code';
  //=={{url}}/settings/specialists/5
  static String specialists(int id) => '/settings/specialists/$id';
  //==={{url}}/settings/trainig-categories/5
  static String trainingCategories(int id, {String? type}) {
    String url = '/settings/training-categories/$id';
    if (type != null) url += '?type=$type';
    return url;
  }

  //---{{url}}/settings/regions/1
  static String regions(int id) => '/settings/regions/$id';
  //==={{url}}/coach/training-categories/40/factors
  static String trainingCategoryFactors(int id, {String? period}) {
    String url = '/coach/training-categories/$id/factors';
    if (period != null) url += '?period=$period';
    return url;
  }

  //===slider
  static const String slider = '/settings/sliders';
  //==={{url}}/player/sport-coaches/1
  static String sportCoaches(int id) => '/player/sport-coaches/$id';
  //=={{url}}/coach/players
  static const String coachPlayers = '/coach/players';
  static String changeTrainingRequestStatus(int id) => '/coach/training-requests/$id/status';
  static String deleteTrainingRequest(int id) => '/coach/training-requests/$id';
  //=={{url}}/coach/packages?max_players=30
  static String packages([int? maxPlayers]) =>
      maxPlayers != null ? '/coach/packages?max_players=$maxPlayers' : '/coach/packages';
  static const String subscribePackage = "/coach/packages/subscribe";

  //=={{url}}/player/sports/1/coaches/1
  static String sportCoachDetails(int sportId, int coachId, {int? childId}) {
    return '/player/sports/$sportId/coaches/$coachId';
  }

  //=={{url}}/coach/player-details/9
  static String playerDetails(int id) => '/coach/player-details/$id';
  //===/player/coaches
  //=== playerstatistics  /coach/player/1/statistics
  static String playerStatistics(int id, {String? period}) {
    String url = '/coach/player/$id/statistics';
    if (period != null) url += '?period=$period';
    return url;
  }

  static const String coaches = '/player/coaches';
  //==coachGroups
  static const String coachGroups = '/coach/groups';

  static const String socialLogin = '/social_login';
  //==={{url}}/settings/cities/1
  static String cities(int id) => '/settings/cities/$id';
  static const String countries = '/settings/countries';
  //--createGroup
  static const String createGroup = '/coach/group/create';
  //===/player/schedule?date=2026-1-1
  static const String schedule = '/player/schedule';
  static const String coachTrainingRequests = "/coach/training-requests";
  static String playerReportStatistics(int playerId, {String? period}) {
    String url = '/coach/player/$playerId/report/statistics';
    if (period != null) url += '?period=$period';
    return url;
  }

  static String playerStatisticsPeriods(int playerId) =>
      '/coach/player/$playerId/statistics/periods';
  //==/coach/player/4/report/attendance
  static String playerReportAttendance(int playerId, {String? period}) {
    String url = '/coach/player/$playerId/report/attendance';
    if (period != null) url += '?period=$period';
    return url;
  }

  //==/coach/player/3/report/financials
  static String playerReportFinancials(int playerId, {String? period}) {
    String url = '/coach/player/$playerId/report/financials';
    if (period != null) url += '?period=$period';
    return url;
  }

  //=={{url}}/coach/player/4/statistics
  // static String playerStatistics(int playerId) => '/coach/player/$playerId/statistics';

  //==sports
  static const String sports = '/player/home/sports';
  static const String clickCounterFacebook = '/user_actions/facebook/';
  static const String clickCounterProfile = '/user_actions/profile/';
  static const String clickCounterWhatsApp = '/user_actions/whatsapp/';
  static const String clickCounterWebsite = '/user_actions/website/';
//=={{url}}/sponsors?sponsor_category_id=
  static String sponsors(int id) => '/sponsors?sponsor_category_id=$id';
//  //=={{url}}/coach/schedule?date=2025-12-15
  static const String coachSchedule = "/coach/schedule";
  //=={{url}}/coach/statistics
  static const String coachStatistics = "/coach/statistics";
  //=="/coach/group/$groupId/update?specialist_id=$specialistId"
  //==
  // {{url}}/coach/group/1/update
  static String updateGroup(int groupId) => '/coach/group/$groupId/update';
  static String deleteGroup(int groupId) => '/coach/group/$groupId';

  static const String todaySchedule = '/player/today-schedule';

  static const String trainingRequest = '/player/training-requests';
  //==/coach/training-requests?type=pending

  static const String shareApp = '/share-app';

  //=={{url}}/player/sessions/4/excuse
  static String excuse(int sessionId, {int? childId}) {
    return '/player/sessions/$sessionId/excuse';
  }

  //===/player/reports/sessions?type=done
  static String coachGroup(int groupId) => '/coach/group/$groupId';
  //==/coach/notifications/send
  static const String sendNotification = '/coach/notifications/send';
  //==/player/notifications
  static const String playerNotifications = '/player/notifications';
  //==/coach/notifications
  static const String coachNotifications = '/coach/notifications';
  static String sendPlayerNotification(int playerId) =>
      '/coach/players/$playerId/notifications/send';

  static String report({
    required String type,
    String? month,
    String? date,
    int? childId,
    int? perPage,
  }) {
    String url = '/player/reports/sessions?type=$type';
    if (perPage != null) url += '&per_page=$perPage';
    if (month != null) url += '&month=$month';
    if (date != null) url += '&date=$date';
    return url;
  }
//==/sponsor-categories

  static const String sponsorCategories = '/sponsor-categories';
  static const String coupons = '/coupon';
  static const String booking = '/booking';
  static const String privateBooking = '/special_trip';
  static String myTrips(String status) => '/history_trip?status_trip=$status';
  static const String cost = '/cost';
  static const String cancelTrip = '/cancel_trip';
  static const String cancelReasons = '/reason_cancel_trip';

  static const String forgetPassword = '/auth/forgot-password';
  static const String changePassword = '/auth/change-password';
  static const String sendOTP = '/send_otp';
  static const String confirmOTP = '/confirmation-otp';
  static const String resetPassword = '/auth/change-password';
  static const String verifyAccount = '/verify_account';
  static const String logout = '/auth/logout';
  static const String grades = '/grades';
  static const String resendOTP = '/auth/resend-otp';
  static const String verifyOTPForgetPassword = '/auth/verify-otp';
  static const String resendOTPForgetPassword = '/forgot/resend-otp';
  static String assignStudent = instance<AppPreferences>().getUserType() == "teacher"
      ? '/teacher/subscribe-student'
      : '/parent-student/assign';
  static String teacherStudents = '/teacher/my-students';
  static String parentStudents = "/parent-student/students";
  static const String addCourse = '/create/course';
  static String editCourse(int id) => '/course/$id/update';
  static const String teacherCourses = '/my-courses';
  static const String subjects = '/subjects';
  static String tripDetails(String id) => '/trip/$id';
  static String myTripDetails(String id) => '/details_my_trip/$id';
  static String lessonDetails(String id) =>
      instance<AppPreferences>().getUserType() == "teacher" ? '/lesson/$id' : '/lesson/data/$id';
  static String lessons(int id) => instance<AppPreferences>().getUserType() == "teacher"
      ? '/course/lessons/$id'
      : '/course/lesson/$id';
  static const String addLesson = '/lesson/create';
  static String editLesson(int id) => '/lesson/$id/update';
  static String deleteCourse(int id) => '/course/$id';
  static String toggleActiveCourse(int id) => '/course/$id/toggle-status';
  static String deleteLesson(int id) => '/lesson/$id';
  static String toggleActiveLesson(int id) => '/lesson/$id/toggle-status';
  static String deleteFile(int id) => '/lesson-file/file/$id';
  static const String addHomework = '/homework/upload';
  static String homeworks(int id, {bool isStudentDetails = false}) =>
      instance<AppPreferences>().getUserType() == "teacher" && !isStudentDetails
          ? '/homework/homeworks/$id'
          : instance<AppPreferences>().getUserType() == "student"
              ? "/lesson/homeworks/$id"
              : '/parent/child/$id/homeworks';
  static String exams(int id, {bool isStudentDetails = false}) =>
      instance<AppPreferences>().getUserType() == "teacher" && !isStudentDetails
          ? '/tests/lesson/$id'
          : instance<AppPreferences>().getUserType() == "student"
              ? '/lesson/tests/$id'
              : ('/parent/child/$id/tests');
  static String deleteHomework(int id) => '/homework/homework/$id';
  static String deleteExam(int id) => '/tests/$id';
  static const String myTeachers = '/student/my-teachers';
  static const String allTeachers = '/teachers/all';
  static String editExam(int id) => '/tests/update/$id';
  static const String addExam = '/tests/store';
  static String deleteQuestion(int id) => '/tests/question/$id';
  static String examDetails(int id) =>
      instance<AppPreferences>().getUserType() == "teacher" ? '/test/$id' : "/student/tests/$id";
  static String teacherCoursesById(int id) => '/teacher/courses/$id';
  static String childCoursesById(int id) => '/parent/child/$id/courses';
  static String submitExam(int examId) => '/student/tests/$examId/submit';
  static const String submitHomework = '/homework-submission/submit';
  static String submissionsHomework(int homeworkId) =>
      '/homework-submission/submissions/$homeworkId';
  static const String userData = '/auth/profile';
  static String updateProfile(String userType) {
    if (userType == 'player') return '/auth/update-profile';
    if (userType == 'parent') return '/auth/update-profile';
    return '/auth/update-profile'; // coach or default
  }

  static String gradeSubmission(int submissionId) =>
      '/homework-submission/submission/$submissionId';
  static const String faqs = '/settings/faqs';
  static const String privacyPolicy = '/settings/privacy';
  static const String about = '/settings/about';
  static const String terms = '/settings/terms';
  static const String subscribeTeacher = '/initiate-payment';
  static const String contactUs = '/settings/contact-us';
  static String systemExams(int id) => '/tests/system/all/$id';
  static const String onBoarding = '/sliders';
  static const String banners = '/banner';
  static String search(String text) => '/search?q=$text';
  static String submissionDetails(int submissionId) => "/tests/submission/data/$submissionId";
  static const String deleteAccount = '/auth/delete-account';
  static const String trips = '/captain/trips';
  static const String cars = '/car_type';
  static const String actions = "/captain/trip";
  static String captainTripDetails(String id) => '/captain/trip/$id';
  static String nextStation(int tripId) => '/captain/trip/$tripId';
  static String myTripsCaptain(String status) => '/captain/my_trips?status_trip=$status';
  static String updateBooking(int bookingId) => '/captain/booking/$bookingId';
  static String passengers(int tripId, int dayId) => '/captain/passenger/$tripId/$dayId';
  static String passengersDetails(String id) => '/captain/booking/client/$id';
  static const String evaluation = "/coach/players/rate";
  static const String carCaptain = '/captain/car_captain';
  //----payment
  static const String payment = '/captain/payment';
  //--wallet
  static const String wallet = '/payment';
  static String walletBalance({int? childId}) {
    String url = '/player/wallet/balance';
    if (childId != null) {
      url += '?child_id=$childId';
    }
    return url;
  }

  static const String walletDeposit = "/player/wallet/deposit";
  static String walletTransactions({
    String? type,
    String? startDate,
    String? endDate,
    int? childId,
    int perPage = 10,
    int page = 1,
  }) {
    String url = '/player/wallet/transactions?per_page=$perPage&page=$page';
    if (type != null && type.isNotEmpty) url += '&transaction_type=$type';
    if (startDate != null && startDate.isNotEmpty) url += '&start_date=$startDate';
    if (endDate != null && endDate.isNotEmpty) url += '&end_date=$endDate';
    if (childId != null) url += '&child_id=$childId';
    return url;
  }

  static String walletUnpaidItems({int? childId}) {
    String url = '/player/wallet/unpaid-items';
    if (childId != null) url += '?child_id=$childId';
    return url;
  }

  static String walletPayFromWallet({int? childId}) {
    String url = '/player/wallet/pay-from-wallet';
    if (childId != null) url += '?child_id=$childId';
    return url;
  }

  static String financeHistory({
    String? startDate,
    String? endDate,
    int? page,
    int? perPage,
    String? status,
  }) {
    String url = '/coach/payments/history?';
    if (startDate != null && startDate.isNotEmpty) url += 'start_date=$startDate&';
    if (endDate != null && endDate.isNotEmpty) url += 'end_date=$endDate&';
    if (page != null) url += 'page=$page&';
    if (perPage != null) url += 'per_page=$perPage&';
    if (status != null && status.isNotEmpty) url += 'status=$status&';
    return url;
  }

  //---withdrawal
  static const String withdrawal = '/captain/withdrawal_request';

  static String captainMyDetails(String id) => "/captain/details_my_trip/$id";
  static String walletCaptain(int id) => '/captain/wallet/$id';
  //---/captain/is_return/
  static String isReturn(String id) => '/captain/is_return/$id';
  static String changeCar(int carId) => '/captain/change_car/$carId';
  static const String toggleStatus = '/captain/change-status';
  static String coachCreateSession(int groupId) => '/coach/group/$groupId/session/create';
  static String assignPlayerToGroup(int groupId) => '/coach/groups/$groupId/assign-player';
  static const String addPlayersToGroup = '/coach/players/add-players';
  //==/coach/player/{playerId}/attendance
  static String saveAttendanceBatch(int playerId) => '/coach/player/$playerId/attendance';
  //==/coach/player/{playerId}/attendance/{attendanceId}
  static String updateAttendanceRecord(int playerId, int attendanceId) =>
      '/coach/player/$playerId/attendance/$attendanceId';
  //==stopPlayer
  //==/coach/players/{playerId}/groups/{groupId}/stop

  static String stopPlayer(int playerId, int groupId) =>
      '/coach/players/$playerId/groups/$groupId/stop';
  //==deletePlayerFromGroup
  //==/coach/players/{playerId}/groups/delete
  static String deletePlayerFromGroup(int playerId) => '/coach/players/$playerId/groups/delete';

  static String changeSessionStatus(int sessionId) => '/coach/sessions/$sessionId/status';
  static String coachSessionPlayers(int sessionId) => '/coach/sessions/$sessionId/players';
  static String note(int sessionId, {int? childId}) {
    return '/player/sessions/$sessionId/note';
  }

  static const String playerSubscribePayment = '/player/payments/subscribe';
  //==/coach/group/{groupId}/attendance
  static String saveGroupAttendance(int groupId) => '/coach/group/$groupId/attendance';
  //==/coach/players/{groupPlayerId}/payment-status
  static String coachSessionNotes(int sessionId) => '/coach/sessions/$sessionId/notes';

  static String coachSessionExcuses(int sessionId) => '/coach/sessions/$sessionId/excuses';

  static String getPlayerPaymentStatus(int playerId) => '/coach/players/$playerId/payment-status';
  static const String coachEarnings = "/coach/payments/earnings";
  static String requestPayment(int playerId) => '/coach/players/$playerId/payment/request';
}
