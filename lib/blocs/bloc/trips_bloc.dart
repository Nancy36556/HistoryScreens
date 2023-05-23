import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/Trip.dart';
import '../../repository/TripRepo.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final TripsRepository tripsRepository;
  TripsBloc(this.tripsRepository) : super(Loadingstate()) {
    on<FetchTripsEvent>((event, emit) async {
      emit(Loadingstate());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final tripData = await tripsRepository.getTrips();
        emit(Loadedstate(tripData));
      } catch (e) {
        emit(Errorstate(e.toString()));
      }
    });
  }
}
