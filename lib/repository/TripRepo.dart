import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/Trip.dart';
class TripsRepository {
  final FirebaseFirestore _firestore;

  TripsRepository(this._firestore);

  Future<List<Trip>> getTrips() async {
    final query = _firestore
        .collection('trips')
        .orderBy('startdatetime', descending: true)
        .limit(10);

    final snapshots = await query.get();

    return snapshots.docs.map((doc) {
      final data = doc.data();

      return Trip(
        // startdatetime: doc.toString(),
        tripid: data['tripid'],
        startdatetime: data['startdatetime'],
        enddatetime: data['enddatetime'],
        startstationid: data['startstationid'],
        endstationid: data['endstationid'],
        paid: data['paid'],

      );
    }).toList();
  }
}
