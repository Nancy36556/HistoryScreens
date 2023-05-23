import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Model/Trip.dart';
import 'blocs/bloc/trips_bloc.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<TripsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('History trips')),
      ),
      body: BlocBuilder<TripsBloc, TripsState>(
        // ignore: missing_return
        builder: (context, State) {
          if (State is Loadingstate) {
            return Center(child: Text('Loading...'));
          } else if (State is Loadedstate) {
            List<Trip> data = State.trips;

            return ListView.builder(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                      Text(data[index].tripid),
                      Text(data[index].startdatetime),
                      Text(data[index].enddatetime),
                      Text(data[index].startstationid),
                      Text(data[index].endstationid),
                      Text(data[index].paid.toString())

                        ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
