import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd_test/features/number_trivia/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaInitial) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is NumberTriviaLoading) {
                    return const LoadingWidget();
                  } else if (state is NumberTriviaLoaded) {
                    return TriviaDisplay(numberTriviaEntity: state.numberTriviaEntity);
                  } else if (state is NumberTriviaError) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}