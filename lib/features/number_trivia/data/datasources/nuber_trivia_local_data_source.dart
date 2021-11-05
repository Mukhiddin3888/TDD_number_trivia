

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/core/error/exeptions.dart';
import 'package:tdd_test/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{


Future<NumberTriviaModel> getLastNumberTrivia();

Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);

}

const cachedNumberTrivia = "cachedNumberTrivia";

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {

  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({ required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {

    return sharedPreferences.setString(cachedNumberTrivia, jsonEncode(triviaToCache.toJson()));

  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {


    final jsonString = sharedPreferences.getString(cachedNumberTrivia);

    if(jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    }else{
      throw CacheException();
    }

  }

}