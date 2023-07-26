abstract class CounterStets {}

class CounterInitialState extends CounterStets {}

class CounterPlusState extends CounterStets {
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStets {
  final int counter;

  CounterMinusState(this.counter);
}
