import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rsk_talon/features/user/data/datasources/datasources.dart';
import 'package:rsk_talon/features/user/data/repositories/repositories.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';
import 'package:rsk_talon/features/user/domain/usecases/usecases.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // CUBIT (BLOC)
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
      getTalonsUseCase: sl(),
      getCachedTalonsUseCase: sl(),
      talonToCacheUseCase: sl(),
      deleteTalonFromCacheUseCase: sl(),
      getTokenFromCacheUseCase: sl(),
      sendReviewToServerUseCase: sl(),
      setTokenToCacheUseCase: sl(),
    ),
  );

  // USECASES
  sl.registerLazySingleton(() => GetAllBranches(repository: sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTalonsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateTalonUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedLangUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedTalonsUseCase(repository: sl()));
  sl.registerLazySingleton(() => TalonToCacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTalonFromCacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTokenFromCacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => TokenToCacheUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendReviewToServerUseCase(repository: sl()));

  // REPOSITORY
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

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
  sl.registerLazySingleton(() => Dio());
}
