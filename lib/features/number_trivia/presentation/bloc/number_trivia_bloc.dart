import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/core/usecases/usecase.dart';
import 'package:tdd_test/core/util/input_converter.dart';
import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:tdd_test/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_test/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  final GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {
       required this.getConcreteNumberTriviaUseCase,
      required this.getRandomNumberTriviaUseCase,
      required this.inputConverter}) : super(NumberTriviaInitial());


  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async*{
    if(event is GetTriviaForConcreteNumberEvent) {

      final inputEither  = inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
              (failure) async* {
        yield const NumberTriviaError(message: 'Invalid Input Failure Message');
      },
              (integer) async*{
        yield NumberTriviaLoading();

        final failureOrTrivia = await getConcreteNumberTriviaUseCase(Params(number: integer));

        yield* _eitherLoadedOrErrorState(failureOrTrivia);

      });


    }
    if (event is GetTriviaForRandomNumberEvent){
      yield NumberTriviaLoading();
      final failureOrTrivia = await getRandomNumberTriviaUseCase(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }


  Stream<NumberTriviaState> _eitherLoadedOrErrorState( Either<Failure,NumberTriviaEntity> failureOrTrivia) async*{

    yield failureOrTrivia.fold(
            (failure) => NumberTriviaError(message: _mapFailureToMessage(failure)),
            (trivia) => NumberTriviaLoaded(numberTriviaEntity: trivia));
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return 'Server Failure';

      case CacheFailure:
        return "Cache Failure";

      default:
        return "UnExpected Error";
    }
  }


}









