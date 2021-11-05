

import 'package:tdd_test/features/number_trivia/domain/entities/number_trivia_entities.dart';

class NumberTriviaModel extends NumberTriviaEntity {
  const NumberTriviaModel({
    required String text,
    required int number,
    }) : super(number: number, text: text);


  factory NumberTriviaModel.fromJson(Map<String, dynamic> json){

    return NumberTriviaModel(text: json["text"], number: (json["number"] as int).toInt() );
  }

  Map<String, dynamic> toJson(){

    return {
      "text": text,
      "number": number,
    };
  }


}