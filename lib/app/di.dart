part of 'imports.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.allowReassignment = true;

  // 1. SharedPreferences (مرة واحدة بس)
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // 2. CurrentUser (مع تحميل النوع فورًا)
  
  // // internet connection checker
  // instance.registerLazySingleton<InternetConnectionChecker>(
  //     () => InternetConnectionChecker());

  // app preferences
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));

  // dio
  instance.registerLazySingleton<Dio>(() => Dio()
    ..options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 60),
      // receiveTimeout: const Duration(seconds: 60),
      // sendTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    )
    ..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = instance<AppPreferences>().getToken();
          final isAuthPath = options.path.contains(EndPoints.login) || 
                             options.path.contains(EndPoints.register);

          if (token.isNotEmpty && !isAuthPath) {
            options.headers["Authorization"] = "Bearer $token";
          }
          options.headers["Accept-Language"] = instance<AppPreferences>().getAppLanguage();
          return handler.next(options);
        },
      ),
  
      if (!kReleaseMode)
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            compact: true,
            maxWidth: 90,
            enabled: true)
    ]));

  // api consumer
  instance.registerLazySingleton<ApiConsumer>(() => BaseApiConsumer(dio: instance()));

  // data source
  instance.registerLazySingleton<GenericDataSource>(() => GenericDataSource(instance()));

  // Register AuthRepo
  instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));
  instance.registerLazySingleton<CategoriesRepo>(() => CategoriesRepo(instance()));
  instance.registerLazySingleton<RecipesRepo>(() => RecipesRepo(instance()));
  instance.registerLazySingleton<RawMaterialsRepo>(() => RawMaterialsRepo(instance()));
  instance.registerLazySingleton<HomeRepo>(() => HomeRepo(instance()));
  instance.registerLazySingleton<OnboardingRepo>(() => OnboardingRepo(instance()));
  instance.registerLazySingleton<PriceTrackerRepo>(() => PriceTrackerRepo(instance()));
  instance.registerLazySingleton<SuppliersRepo>(() => SuppliersRepo(instance()));

  // Register Cubits
  instance.registerFactory<SignupCubit>(() => SignupCubit(instance()));
  instance.registerFactory<VerifyOtpCubit>(() => VerifyOtpCubit(instance(), instance()));
  instance.registerFactory<ForgotPwdCubit>(() => ForgotPwdCubit(instance()));
  instance.registerFactory<LoginCubit>(() => LoginCubit(instance(), instance()));
  instance.registerLazySingleton<ProfileCubit>(() => ProfileCubit(instance(), instance()));
  instance.registerFactory<StaticPagesCubit>(() => StaticPagesCubit(instance()));
  instance.registerFactory<FaqCubit>(() => FaqCubit(instance()));
  instance.registerFactory<CategoriesCubit>(() => CategoriesCubit(instance()));
  instance.registerFactory<RecipesCubit>(() => RecipesCubit(instance()));
  instance.registerFactory<RecipeDetailsCubit>(() => RecipeDetailsCubit(instance()));
  instance.registerFactory<RawMaterialsCubit>(() => RawMaterialsCubit(instance()));
  instance.registerFactory<RawMaterialDetailsCubit>(() => RawMaterialDetailsCubit(instance()));
  instance.registerFactory<BannersCubit>(() => BannersCubit(instance()));
  instance.registerFactory<OnboardingCubit>(() => OnboardingCubit(instance()));
  instance.registerFactory<PriceTrackerCubit>(() => PriceTrackerCubit(instance()));
  instance.registerFactory<SuppliersCubit>(() => SuppliersCubit(instance()));
}
