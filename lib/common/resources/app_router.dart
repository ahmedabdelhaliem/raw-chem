import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/features/auth/view/forgot_password_view.dart';
import 'package:raw_chem/features/auth/view/login_view.dart';
import 'package:raw_chem/features/auth/view/reset_password_view.dart';
import 'package:raw_chem/features/auth/view/signup_success_view.dart';
import 'package:raw_chem/features/auth/view/signup_view.dart';
import 'package:raw_chem/features/auth/view/success_view.dart';
import 'package:raw_chem/features/auth/view/verify_otp_view.dart';

import 'package:raw_chem/features/categories/view/category_items_view.dart';
import 'package:raw_chem/features/chat/presentation/view/chat_inbox_view.dart';
import 'package:raw_chem/features/chat/presentation/cubit/chat_inbox_cubit.dart';
import 'package:raw_chem/features/payment/view/fawaterk_webview.dart';
import 'package:raw_chem/features/chat/presentation/view/chat_view.dart';
import 'package:raw_chem/features/home/view/home_view.dart';
import 'package:raw_chem/features/main/view/main_view.dart';
import 'package:raw_chem/features/onboarding/view/onboarding_view.dart';
import 'package:raw_chem/features/price_tracker/view/price_tracker_view.dart';
import 'package:raw_chem/features/profile/view/about_us_view.dart';
import 'package:raw_chem/features/profile/view/help_support_view.dart';
import 'package:raw_chem/features/profile/view/language_view.dart';
import 'package:raw_chem/features/profile/view/notifications_settings_view.dart';
import 'package:raw_chem/features/profile/view/orders_history_view.dart';
import 'package:raw_chem/features/profile/view/personal_data_view.dart';
import 'package:raw_chem/features/profile/view/profile_view.dart';
import 'package:raw_chem/features/profile/view/terms_conditions_view.dart';
import 'package:raw_chem/features/raw_materials/view/connect_supplier_view.dart';
import 'package:raw_chem/features/raw_materials/view/raw_material_details_view.dart';
import 'package:raw_chem/features/raw_materials/view/raw_materials_view.dart';
import 'package:raw_chem/features/recipes/view/recipe_details_view.dart';
import 'package:raw_chem/features/recipes/view/recipes_view.dart';
import 'package:raw_chem/features/splash/view/splash_view.dart';
import 'package:raw_chem/features/suppliers/view/supplier_details_view.dart';
import 'package:raw_chem/features/suppliers/view/suppliers_view.dart';

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
  static const String aboutUsView = '/aboutUs';
  static const String termsConditionsView = '/termsConditions';

  static const String rawMaterialsView = '/rawMaterials';
  static const String rawMaterialDetailsView = '/rawMaterialDetails';
  static const String recipesView = '/recipes';
  static const String recipeDetailsView = '/recipeDetails';
  static const String connectSupplierView = '/connectSupplier';
  static const String orderDetailsView = '/orderDetails';
  static const String suppliersView = '/suppliers';
  static const String supplierDetailsView = '/supplierDetails';
  static const String priceTrackerView = '/priceTracker';
  static const String categoryItemsView = '/categoryItems';
  static const String chatView = '/chat';
  static const String chatInboxView = '/chatInbox';
  static const String fawaterkWebView = '/fawaterkWebView';

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
      GoRoute(
        path: AppRouters.verifyOtpView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final phone = extra?['phone'] as String? ?? '';
          final isForgotPassword = extra?['isForgotPassword'] as bool? ?? false;
          final autoResend = extra?['autoResend'] as bool? ?? false;

          if (isForgotPassword) {
            return BlocProvider(
              create: (context) => instance<ForgotPwdCubit>(),
              child: VerifyOtpView(phone: phone, isForgotPassword: true, autoResend: autoResend),
            );
          }

          return BlocProvider(
            create: (context) => instance<VerifyOtpCubit>(),
            child: VerifyOtpView(phone: phone, isForgotPassword: false, autoResend: autoResend),
          );
        },
      ),
      GoRoute(
        path: AppRouters.resetPasswordView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final phone = extra?['phone'] as String? ?? '';
          final token = extra?['token'] as String? ?? '';
          return ResetPasswordView(phone: phone, token: token);
        },
      ),
      GoRoute(path: AppRouters.successView, builder: (context, state) => const SuccessView()),
      GoRoute(path: AppRouters.signupView, builder: (context, state) => const SignupView()),
      GoRoute(
        path: AppRouters.signupSuccessView,
        builder: (context, state) => const SignupSuccessView(),
      ),
      GoRoute(
        path: AppRouters.btmNav,
        builder: (context, state) =>
            BlocProvider.value(value: instance<ProfileCubit>(), child: const MainView()),
      ),

      GoRoute(path: AppRouters.homeView, builder: (context, state) => const HomeView()),
      GoRoute(path: AppRouters.profileView, builder: (context, state) => const ProfileView()),
      GoRoute(path: AppRouters.languageView, builder: (context, state) => const LanguageView()),
      GoRoute(
        path: AppRouters.personalDataView,
        builder: (context, state) =>
            BlocProvider.value(value: instance<ProfileCubit>(), child: const PersonalDataView()),
      ),

      GoRoute(
        path: AppRouters.ordersHistoryView,
        builder: (context, state) => const OrdersHistoryView(),
      ),
      GoRoute(
        path: AppRouters.notificationsSettingsView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<NotificationsCubit>()..fetchNotifications(),
          child: const NotificationsSettingsView(),
        ),
      ),
      GoRoute(
        path: AppRouters.helpSupportView,
        builder: (context, state) =>
            BlocProvider(create: (context) => instance<FaqCubit>(), child: const HelpSupportView()),
      ),
      GoRoute(
        path: AppRouters.aboutUsView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<StaticPagesCubit>(),
          child: const AboutUsView(),
        ),
      ),
      GoRoute(
        path: AppRouters.termsConditionsView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<StaticPagesCubit>(),
          child: const TermsConditionsView(),
        ),
      ),
      GoRoute(
        path: AppRouters.rawMaterialsView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<RawMaterialsCubit>()..fetchMaterials(),
          child: const RawMaterialsView(),
        ),
      ),
      GoRoute(
        path: AppRouters.rawMaterialDetailsView,
        builder: (context, state) {
          RawMaterialModel material;
          bool isFromPriceTracker = false;

          if (state.extra is RawMaterialModel) {
            material = state.extra as RawMaterialModel;
          } else {
            final map = state.extra as Map<String, dynamic>;
            material = map['material'] as RawMaterialModel;
            isFromPriceTracker = map['isFromPriceTracker'] as bool? ?? false;
          }

          return BlocProvider(
            create: (context) =>
                instance<RawMaterialDetailsCubit>()
                  ..getMaterialDetails(material.id, isFromPriceTracker: isFromPriceTracker),
            child: RawMaterialDetailsView(
              material: material,
              isFromPriceTracker: isFromPriceTracker,
            ),
          );
        },
      ),
      GoRoute(path: AppRouters.recipesView, builder: (context, state) => const RecipesView()),
      GoRoute(
        path: AppRouters.recipeDetailsView,
        builder: (context, state) {
          final recipe = state.extra as RecipeModel;
          return BlocProvider(
            create: (context) => instance<RecipeDetailsCubit>()..getRecipeDetails(recipe.id),
            child: RecipeDetailsView(recipe: recipe),
          );
        },
      ),
      GoRoute(
        path: AppRouters.orderDetailsView,
        builder: (context, state) {
          final order = state.extra as PurchaseOrderModel;
          return ConnectSupplierView(order: order);
        },
      ),
      GoRoute(
        path: AppRouters.connectSupplierView,
        builder: (context, state) {
          if (state.extra is PurchaseOrderModel) {
            return ConnectSupplierView(order: state.extra as PurchaseOrderModel);
          }
          final materialId = state.extra as int;
          return ConnectSupplierView(materialId: materialId);
        },
      ),
      GoRoute(
        path: AppRouters.suppliersView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<SuppliersCubit>()..fetchSuppliers(),
          child: const SuppliersView(),
        ),
      ),
      GoRoute(
        path: AppRouters.supplierDetailsView,
        builder: (context, state) {
          final supplier = state.extra as SupplierModel;
          return BlocProvider(
            create: (context) => instance<SuppliersMaterialsCubit>()..fetchMaterials(supplier.id),
            child: SupplierDetailsView(supplier: supplier),
          );
        },
      ),
      GoRoute(
        path: AppRouters.priceTrackerView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<PriceTrackerCubit>()..fetchSupplierMaterials(),
          child: const PriceTrackerView(),
        ),
      ),
      GoRoute(
        path: AppRouters.categoryItemsView,
        builder: (context, state) {
          final category = state.extra as CategoryModel;
          return CategoryItemsView(category: category);
        },
      ),
      GoRoute(
        path: AppRouters.chatView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final chatId = extra['chatId'] as int;
          final supplierName = extra['supplierName'] as String;
          return BlocProvider(
            create: (context) => instance<ChatCubit>(),
            child: ChatView(chatId: chatId, supplierName: supplierName),
          );
        },
      ),
      GoRoute(
        path: AppRouters.chatInboxView,
        builder: (context, state) => BlocProvider(
          create: (context) => instance<ChatInboxCubit>(),
          child: const ChatInboxView(),
        ),
      ),
      GoRoute(
        path: AppRouters.fawaterkWebView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final url = extra['url'] as String;
          final successUrl = extra['successUrl'] as String?;
          final failureUrl = extra['failureUrl'] as String?;
          
          return FawaterkWebView(
            url: url,
            successUrl: successUrl,
            failureUrl: failureUrl,
          );
        },
      ),
    ],
  );
}
