import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'talon_state.dart';

class TalonCubit extends Cubit<TalonState> {
  TalonCubit() : super(TalonInitial());
}
