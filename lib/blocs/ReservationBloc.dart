import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_pagination/ReservationProvider.dart';
import 'package:rxdart/rxdart.dart';

class DataListBloc {
  TripsProvider tripsProvider;

  bool showIndicator = false;
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> DataController;

  BehaviorSubject<bool> showIndicatorController;

  DataListBloc() {
    DataController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
    tripsProvider = TripsProvider();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get ReservStream => DataController.stream;

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList() async {
    try {
      documentList = await tripsProvider.fetchFirstList();
      print(documentList);
      DataController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          DataController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      DataController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      DataController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNext() async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await tripsProvider.fetchNextList(documentList);
      documentList.addAll(newDocumentList);
      DataController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          DataController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      DataController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      DataController.sink.addError(e);
    }
  }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    DataController.close();
    showIndicatorController.close();
  }
}
