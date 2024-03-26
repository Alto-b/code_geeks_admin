part of 'get_booking_bloc.dart';

sealed class GetBookingState extends Equatable {
  const GetBookingState();
  
  @override
  List<Object> get props => [];
}

final class GetBookingInitial extends GetBookingState {}

class GetBookingsLoadedState extends GetBookingState{
  final List<BookingModel> bookingsList;
  GetBookingsLoadedState({
    required this.bookingsList
  });
}