// import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   final AuthLocalDataSource localDataSource;
//   final NetworkInfo networkInfo;

//   AuthRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, User>> login(String email, String password) async {
//     // Check if the device is online
//     if (await networkInfo.isConnected) {
//       try {
//         final remoteUser = await remoteDataSource.login(email, password);
//         localDataSource.cacheUser(remoteUser);
//         return Right(remoteUser);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       return Left(NetworkFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> register(String email, String password) async {
//     // Similar implementation as login method, handling registration
//   }

//   @override
//   Future<Either<Failure, User>> getCurrentUser() async {
//     // Implementation to retrieve the currently logged-in user from local storage
//   }

//   @override
//   Future<void> logout() async {
//     // Implementation to log out the user, clear local data, etc.
//   }
// }