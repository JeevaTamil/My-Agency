import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'logistic_state.dart';

class LogisticCubit extends Cubit<LogisticState> {
  LogisticCubit() : super(LogisticInitial());
}
