

import 'package:dartz/dartz.dart';
import 'package:tdd_test/core/error/exeptions.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/platform/network_info.dart';
import 'package:tdd_test/features/number_trivia/data/datasources/nuber_trivia_local_data_source.dart';
import 'package:tdd_test/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:tdd_test/features/number_trivia/domain/repositories/number_trivia_repository.dart';


typedef Future<NumberTriviaEntity> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl  implements NumberTriviaRepository{

  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {
        required this.localDataSource,
        required this.remoteDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(int number)  {


    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() {
    throw UnimplementedError();
  }


  Future<Either<Failure, NumberTriviaEntity>> _getTrivia (
      _ConcreteOrRandomChooser concreteOrRandomChooser
      )async{
    if(await networkInfo.isConnected){

      try{
        final remoteTrivia = await concreteOrRandomChooser();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);

      }on ServerException{
        return Left(ServerFailure());
      }

    }else{

      try{
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      }
      on CacheException{
        return Left(CacheFailure());
      }


    }
  }







}