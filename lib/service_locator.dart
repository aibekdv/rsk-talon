import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/datasources/datasources.dart';
import 'package:rsk_talon/feature/data/repositories/repositories.dart';
import 'package:rsk_talon/feature/domain/repositories/repositories.dart';
import 'package:rsk_talon/feature/domain/usecases/usecases.dart';
import 'package:rsk_talon/feature/presentation/cubit/cubit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // CUBIT (BLOC)
  sl.registerFactory(() => BranchCubit(getAllBranches: sl.call()));

  sl.registerFactory(
    () => LanguageCubit(
      changeLangUseCase: sl.call(),
      getCachedLangUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => TalonCubit(
      createTalonUseCase: sl.call(),
      getServicesUseCase: sl.call(),
      getTalonsUseCase: sl.call(),
      getCachedTalonsUseCase: sl.call(),
      talonToCacheUseCase: sl.call(),
      deleteTalonFromCacheUseCase: sl.call(),
    ),
  );

  // USECASES
  sl.registerLazySingleton(() => GetAllBranches(repository: sl.call()));
  sl.registerLazySingleton(() => GetServicesUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetTalonsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateTalonUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCachedLangUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCachedTalonsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => TalonToCacheUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ChangeLangUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteTalonFromCacheUseCase(repository: sl.call()));

  // REPOSITORY
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: http.Client(),
      prefs: sl.call(),
    ),
  );

  sl.registerLazySingleton<LocalDataSources>(
    () => LocalDataSourcesImpl(
      prefs: sl.call(),
    ),
  );
  
  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      remoteDataSource: sl.call(),
      localDataSources: sl.call(),
    ),
  );

  // CORE
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl.call()),
  );

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
