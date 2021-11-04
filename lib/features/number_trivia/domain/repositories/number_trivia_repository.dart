

import 'package:dartz/dartz.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';

abstract class NumberTriviaRepository{

  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia();

}