import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  int counter = 0;

  void increment() {
    counter++;
    emit(counter);
  }
  void decrement() {
    counter=counter-1;
    emit(counter);
  }
}