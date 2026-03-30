import 'package:go_router/go_router.dart';
import 'package:raw_chem/feature/auth/presentation/view/forgot_password_view.dart';
import 'package:raw_chem/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/login_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/reset_password_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/signup_success_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/signup_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/success_view.dart';
import 'package:raw_chem/feature/auth/presentation/view/verify_otp_view.dart';
import 'package:raw_chem/feature/cart/presentation/view/cart_view.dart';
import 'package:raw_chem/feature/cart/presentation/view/order_success_view.dart';
import 'package:raw_chem/feature/home/presentation/view/home_view.dart';
import 'package:raw_chem/feature/main/presentation/view/main_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/help_support_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/language_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/notifications_settings_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/order_details_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/orders_history_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/personal_data_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/profile_view.dart';
import 'package:raw_chem/feature/profile/presentation/view/terms_conditions_view.dart';
import 'package:raw_chem/feature/raw_materials/presentation/view/connect_supplier_view.dart';
import 'package:raw_chem/feature/raw_materials/presentation/view/raw_material_details_view.dart';
import 'package:raw_chem/feature/raw_materials/presentation/view/raw_materials_view.dart';
import 'package:raw_chem/feature/recipes/presentation/view/recipe_details_view.dart';
import 'package:raw_chem/feature/recipes/presentation/view/recipes_view.dart';
import 'package:raw_chem/feature/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRouters {
  static const String root = '/';
  static const String splashView = '/splash';
  static const String onBoardingView = '/onBoarding';
  static const String btmNav = '/btmNav';
  static const String loginView = '/login';
  static const String forgotPasswordView = '/forgotPassword';
  static const String resetPasswordView = '/resetPassword';
  static const String signupView = '/signup';
  static const String signupSuccessView = '/signupSuccess';
  static const String verifyOtpView = '/verifyOtp';
  static const String successView = '/success';
  static const String homeView = '/home';
  static const String profileView = '/profile';
  static const String languageView = '/language';
  static const String personalDataView = '/personalData';
  static const String ordersHistoryView = '/ordersHistory';
  static const String notificationsSettingsView = '/notificationsSettings';
  static const String helpSupportView = '/helpSupport';
  static const String termsConditionsView = '/termsConditions';
  static const String cartView = '/cart';
  static const String orderSuccessView = '/orderSuccess';
  static const String rawMaterialsView = '/rawMaterials';
  static const String rawMaterialDetailsView = '/rawMaterialDetails';
  static const String recipesView = '/recipes';
  static const String recipeDetailsView = '/recipeDetails';
  static const String connectSupplierView = '/connectSupplier';
  static const String orderDetailsView = '/orderDetails';
  

  static final GoRouter router = GoRouter(
    initialLocation: AppRouters.splashView,
    routes: [
      GoRoute(path: AppRouters.root, builder: (context, state) => const SplashView()),
      GoRoute(path: AppRouters.splashView, builder: (context, state) => const SplashView()),
      GoRoute(path: AppRouters.onBoardingView, builder: (context, state) => const OnBoardingView()),
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
      GoRoute(path: AppRouters.cartView, builder: (context, state) => const CartView()),
      GoRoute(path: AppRouters.orderSuccessView, builder: (context, state) => const OrderSuccessView()),
      GoRoute(path: AppRouters.rawMaterialsView, builder: (context, state) => const RawMaterialsView()),
      GoRoute(
        path: AppRouters.rawMaterialDetailsView,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return RawMaterialDetailsView(
            imageUrl: data?['imageUrl'] ?? '',
            title: data?['title'] ?? '',
            category: data?['category'] ?? '',
            description: data?['description'] ?? '',
            casNumber: data?['casNumber'] ?? '',
            averagePrice: data?['averagePrice'] ?? '',
            supplier: data?['supplier'] ?? '',
            heroTag: data?['heroTag'] ?? '',
          );
        },
      ),
      GoRoute(path: AppRouters.recipesView, builder: (context, state) => const RecipesView()),
      GoRoute(
        path: AppRouters.recipeDetailsView,
        builder: (context, state) {
          final heroTag = state.extra as String?;
          return RecipeDetailsView(heroTag: heroTag);
        },
      ),
      GoRoute(path: AppRouters.orderDetailsView, builder: (context, state) => const OrderDetailsView()),
      GoRoute(path: AppRouters.connectSupplierView, builder: (context, state) => const ConnectSupplierView()),
    ],
  );
}
