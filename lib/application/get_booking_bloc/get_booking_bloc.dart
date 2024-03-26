import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/domain/booking_model.dart';
import 'package:code_geeks_admin/infrastructure/bookings_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_booking_event.dart';
part 'get_booking_state.dart';

class GetBookingBloc extends Bloc<GetBookingEvent, GetBookingState> {
  BookingsRepo bookingsRepo = BookingsRepo();
  GetBookingBloc(this.bookingsRepo) : super(GetBookingInitial()) {
    on<LoadBookingsEvent>(loadBookings);
  }

  FutureOr<void> loadBookings(LoadBookingsEvent event, Emitter<GetBookingState> emit)async{
    emit(GetBookingInitial());
    final bookings = await bookingsRepo.getBookings();
    emit(GetBookingsLoadedState(bookingsList: bookings));
  }
}
