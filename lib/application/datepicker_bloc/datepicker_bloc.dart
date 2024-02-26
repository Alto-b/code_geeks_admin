import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'datepicker_event.dart';
part 'datepicker_state.dart';

class DatepickerBloc extends Bloc<DatepickerEvent, DatepickerState> {
  DatepickerBloc() : super(DatepickerInitial()) {
    on<DatepickerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
