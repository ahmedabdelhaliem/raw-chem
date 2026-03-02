import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app.dart';
import 'package:raw_chem/feature/auth/presentation/view/forgot_password_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/login_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/reset_password_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/success_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/verify_otp_view.dart';
import 'package:raw_chem/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:raw_chem/feature/splash/presentation/view/splash_view.dart';

abstract class AppRouters {
  static const String root = '/';
  static const String splashView = '/splash';
  static const String introView = '/intro';
  static const String btmNav = '/btmNav';
  static const String loginView = '/login';
  static const String forgotPasswordView = '/forgotPassword';
  static const String resetPasswordView = '/resetPassword';
  static const String signupView = '/signup';
  static const String verifyOtpView = '/verifyOtp';
  static const String successView = '/success';
  static const String privateTripView = '/PrivateTrip';
  static const String myTripDetailsView = '/myTripDetails';
  static const String tripDetailsView = '/tripDetails';
  static const String mapView = '/map';
  static const String orderDetailsView = '/orderDetails';
  static const String payView = '/pay';
  static const String stationsView = '/stations';
  static const String cancelReasonsView = '/cancelReasons';
  static const String chooseVehicle = '/chooseVehicle';
  static const String drivingLicense = '/drivingLicense';

  static const String homeView = '/Homeview';
  static const String customerWaitingView = '/customerWaiting';
  static const String captainTripDetailsScreen = '/captainTripDetails';
  static const String rideAndRideView = '/rideAndRide';
  static const String balanceView = '/balance';
  static const String passengerDetails = '/passengerDetails';
  static const String captainLastStopView = '/lastStop';
  static const String preferencesTripView = '/preferencesTrip';
  static const String personalDataView = '/personalData';
  static const String editProfileView = '/editProfile';
  // static const String requiredDocumentsView = '/requiredDocumentsView';
  static const String vehicleDataView = '/vehicleDataView';
  static const String carDetailsView = '/carDetailsView';
  static const String vehicleInformationView = '/vehicleInformationView';
  // static const String successView = '/successView';
  static const String tripRegistrationView = '/tripRegistrationView';
  static const String captainWalletView = '/captainWalletView';
  static const String profileView = '/profileView';
  static const String inboxView = '/notificationView';
  static const String identityVerification = '/identityVerification';
  static const String captainVehicleDataView = '/captainVehicleDataView';
  static const String carInfoView = '/carInfoView';
  static const String kDigitalPaymentView = '/paymentView';
  static const String privacyPolicyView = '/privacyPolicyView';
  static const String chooseUserView = '/chooseUserView';
  static const String trainingFormView = '/trainingFormView';
  static const String sportsView = '/sportsView';
  static const String coachesView = '/coachesView';
  static const String coachDetailsView = '/coachDetailsView';
  static const String scheduleView = '/scheduleView';
  static const String coachPaymentView = '/coachPaymentView';
  static const String numbersPlayerView = '/numbersPlayerView';
  static const String homeCoachView = '/homeCoachView';
  static const String playerReportView = '/playerReportView';
  static const String playerStatsView = '/playerStatsView';
  static const String groupManagementView = '/groupManagementView';
  static const String groupsView = '/groupsView';
  static const String groupDetailsView = '/groupDetailsView';
  static const String addGroupView = '/addGroupView';
  //==absenceView
  static const String absenceView = '/absenceView';
  static const String absenceDetailsView = '/absenceDetailsView';
  //==trainingRequestsView
  static const String trainingRequestsView = '/trainingRequestsView';
  static const String feildPlayerView = '/feildPlayerView';
  static const String sponsersDetailsScreen = '/sponsersDetailsScreen';
  static const String aboutUsView = '/aboutUsView';
  //==playerDetailsView

  static const String playerDetailsView = '/playerDetailsView';
  static const String playersAttendanceView = '/playersAttendanceView';
  static const String walletView = '/wallet';
  static const String financeView = '/financeView';

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouters.root,
    routes: [
      GoRoute(path: AppRouters.root, builder: (context, state) => const SplashView()),
      GoRoute(path: AppRouters.introView, builder: (context, state) => const OnBoardingView()),
      GoRoute(path: AppRouters.loginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: AppRouters.forgotPasswordView,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(path: AppRouters.verifyOtpView, builder: (context, state) => const VerifyOtpView()),
      GoRoute(
        path: AppRouters.resetPasswordView,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(path: AppRouters.successView, builder: (context, state) => const SuccessView()),
    ],
  );

  static Widget slideTransition(context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
      child: child,
    );
  }
}
