part of 'datepicker_bloc.dart';

sealed class DatepickerEvent extends Equatable {
  const DatepickerEvent();

  @override
  List<Object> get props => [];
}

class DatePickedEvent extends DatepickerBloc{
  final int picked;
  DatePickedEvent({required this.picked});
}
