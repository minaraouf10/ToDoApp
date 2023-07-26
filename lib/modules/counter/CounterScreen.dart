import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/modules/counter/cubit/cubit.dart';
import 'package:untitled3/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CounterCubit(),
        child: BlocConsumer<CounterCubit, CounterStets>(
          listener: (context, state) {
            if (state is CounterPlusState) {
              //print('plus state ${state.counter} ');
            }

            if (state is CounterMinusState) {
              // print('minus state ${state.counter} ');
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Counter'),
              ),
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                        //print(counter);
                      },
                      child: const Text(
                        'MIUNS',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                        // print(counter);
                      },
                      child: const Text(
                        'PLUS',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
