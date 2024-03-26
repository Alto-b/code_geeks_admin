part of 'get_booking_bloc.dart';

sealed class GetBookingEvent extends Equatable {
  const GetBookingEvent();

  @override
  List<Object> get props => [];
}

class LoadBookingsEvent extends GetBookingEvent{}