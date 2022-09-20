import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit2 extends Cubit<int> {
  CounterCubit2() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}