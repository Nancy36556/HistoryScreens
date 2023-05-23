part of 'trips_bloc.dart';

abstract class TripsState extends Equatable {
  const TripsState();
  
  @override
  List<Object> get props => [];
}


class Errorstate extends TripsState {
  final String error;
  Errorstate(this.error);
  @override
  List<Object> get props => [error];
}
class Loadingstate extends TripsState {
  @override
  List<Object> get props => [];
}
class Loadedstate extends TripsState {
  final List<Trip> trips;

  Loadedstate(
    this.trips
  );
  @override
  List<Object> get props => [trips];

}
