import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rsk_talon/features/auth/data/datasources/remote_datasource.dart';
import 'package:rsk_talon/features/auth/data/repositories/repositories.dart';
import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';
import 'package:rsk_talon/features/auth/domain/usecases/usecases.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/cubit.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/reset/reset_cubit.dart';
import 'package:rsk_talon/features/user/data/datasources/datasources.dart';
import 'package:rsk_talon/features/user/data/repositories/repositories.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';
import 'package:rsk_talon/features/user/domain/usecases/usecases.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GET_IT INSTANCE
final sl = GetIt.instance;

// DEPENDENCY INJECTION
Future<void> init() async {
  // CUBIT (BLOC)

  // USER CUBITS
  sl.registerFactory(
    () => BranchCubit(
      getAllBranches: sl(),
    ),
  );

  sl.registerFactory(
    () => LanguageCubit(
      changeLangUseCase: sl(),
      getCachedLangUseCase: sl(),
    ),
  );

  sl.registerFactory(() => ConnectionCubit());

  sl.registerFactory(
    () => TalonCubit(
      createTalonUseCase: sl(),
      getServicesUseCase: sl(),
      getTokenFromCacheUseCase: sl(),
      sendReviewToServerUseCase: sl(),
      getUserTalonUseCase: sl(),
      tokenToCacheUseCase: sl(),
      removeTalonFromServerUseCase: sl(),
      getUserFromCacheUseCase: sl(),
    ),
  );

  // AUTH CUBITS
  sl.registerFactory(
    () => SignInCubit(
      signInUseCase: sl(),
      getAuthTokenFromCache: sl(),
      getUserFromCacheUseCase: sl(),
      logoutUseCase: sl(),
      refreshTokenUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => SignUpCubit(
      signUpUseCase: sl(),
      activateAccountUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ResetCubit(
      restorePasswordUseCase: sl(),
      setRestorePasswordUseCase: sl(),
    ),
  );

  // USER USECASES
  sl.registerLazySingleton(() => GetAllBranches(repository: sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateTalonUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedLangUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendReviewToServerUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserTalonUseCase(repository: sl()));
  sl.registerLazySingleton(() => TokenToCacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTokenFromCacheUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => RemoveTalonFromServerUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserFromCacheUseCase(repository: sl()));

  // AUTH USECASES
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAuthTokenFromCache(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivateAccountUseCase(repository: sl()));
  sl.registerLazySingleton(() => RestorePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetRestorePasswordUseCase(repository: sl()));

  // USER REPOSITORIES
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      dio: sl(),
      prefs: sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSources>(
    () => LocalDataSourcesImpl(
      prefs: sl(),
    ),
  );

  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      remoteDataSource: sl(),
      localDataSources: sl(),
    ),
  );

  // AUTH REPOSITORIES
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl(), prefs: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: "http://rskseo.pythonanywhere.com",
      ),
    ),
  );
}
