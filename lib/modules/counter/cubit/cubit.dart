import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStets> {
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }
}
