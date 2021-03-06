


import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/platform/network_info.dart';
import 'package:tdd_test/core/util/input_converter.dart';
import 'package:tdd_test/features/number_trivia/data/datasources/nuber_trivia_local_data_source.dart';
import 'package:tdd_test/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_test/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_test/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_test/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_test/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // features - number trivia

  //Bloc

  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTriviaUseCase: sl(),
      getRandomNumberTriviaUseCase: sl(),
      inputConverter: sl()));

  // Use Cases

  sl.registerLazySingleton(() => GetRandomNumberTriviaUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConcreteNumberTriviaUseCase(repository: sl()));


  //Repository

  sl.registerLazySingleton<NumberTriviaRepository>(
          () => NumberTriviaRepositoryImpl(
              localDataSource: sl(),
              remoteDataSource: sl(),
              networkInfo: sl()));
  
  // Data sources

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
          () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
          () => NumberTriviaRemoteDataSourceImpl(client: sl()));


  // Core

  sl.registerLazySingleton(() => InputConverter());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());


  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => http.Client() );
  
  sl.registerLazySingleton(() => InternetConnectionChecker());



}