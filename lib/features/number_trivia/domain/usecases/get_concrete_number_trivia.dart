

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/usecases/usecase.dart';
import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:tdd_test/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTriviaEntity,Params>{

  final NumberTriviaRepository repository;


  GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(Params params) async {

    return await repository.getConcreteNumberTrivia(params.number);
  }



}


class Params extends Equatable{

  final int number;

  const Params({ required this.number});

  @override
  List<Object> get props => [number];

}