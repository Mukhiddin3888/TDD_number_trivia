

import 'package:dartz/dartz.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/usecases/usecase.dart';
import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:tdd_test/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTriviaUseCase implements UseCase<NumberTriviaEntity, NoParams>{

  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUseCase({required this.repository});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams params)async {


    return await repository.getRandomNumberTrivia();

  }


}