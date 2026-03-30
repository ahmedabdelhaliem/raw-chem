import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/app.dart';
import 'package:raw_chem/feature/auth/presentation/view/forgot_password_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/login_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/reset_password_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/signup_success_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/signup_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/success_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/verify_otp_view.dart';
import 'package:raw_chem/feature/home/presentation/view/home_view.dart';
import 'package:raw_chem/feature/main/presentation/view/main_view.dart';
import 'package:raw_chem/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/help_support_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/language_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/notifications_settings_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/orders_history_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/personal_data_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/profile_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/terms_conditions_view.dart';
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
  static const String signupSuccessView = '/signupSuccess';
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
  static const String profileView = '/profile';
  static const String languageView = '/language';
  static const String personalDataView = '/personalData';
  static const String ordersHistoryView = '/ordersHistory';
  static const String notificationsSettingsView = '/notificationsSettings';
  static const String helpSupportView = '/helpSupport';
  static const String termsConditionsView = '/termsConditions';
  

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
      GoRoute(path: AppRouters.signupView, builder: (context, state) => const SignupView()),
      GoRoute(
        path: AppRouters.signupSuccessView,
        builder: (context, state) => const SignupSuccessView(),
      ),
      GoRoute(path: AppRouters.btmNav, builder: (context, state) => const MainView()),
      GoRoute(path: AppRouters.homeView, builder: (context, state) => const HomeView()),
      GoRoute(path: AppRouters.profileView, builder: (context, state) => const ProfileView()),
      GoRoute(path: AppRouters.languageView, builder: (context, state) => const LanguageView()),
      GoRoute(path: AppRouters.personalDataView, builder: (context, state) => const PersonalDataView()),
      GoRoute(path: AppRouters.ordersHistoryView, builder: (context, state) => const OrdersHistoryView()),
      GoRoute(path: AppRouters.notificationsSettingsView, builder: (context, state) => const NotificationsSettingsView()),
      GoRoute(path: AppRouters.helpSupportView, builder: (context, state) => const HelpSupportView()),
      GoRoute(path: AppRouters.termsConditionsView, builder: (context, state) => const TermsConditionsView()),
    ],
  );

  static Widget slideTransition(context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
      child: child,
    );
  }

}
