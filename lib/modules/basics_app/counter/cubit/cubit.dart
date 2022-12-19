import 'package:FlutterApplications/modules/basics_app/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  static get(context) => BlocProvider.of<CounterCubit>(context);

  int counter = 1;

  void minus() {
    --counter;
    emit(CounterMinusState(counter));
  }

  void plus() {
    ++counter;
    emit(CounterPlusState(counter));
  }
}
