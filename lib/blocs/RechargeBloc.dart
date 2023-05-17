import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_pagination/RechargeProvider.dart';
import 'package:rxdart/rxdart.dart';

class RechargeListBloc {
  RechargeProvider rechargeProvider;

  bool showIndicator = false;
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> DataController;

  BehaviorSubject<bool> showIndicatorController;

  RechargeListBloc() {
    DataController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
    rechargeProvider = RechargeProvider();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get DataStream => DataController.stream;
  Future fetchFirstList() async {
    try {
      documentList = await rechargeProvider.fetchFirstList();
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

  fetchNext() async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await rechargeProvider.fetchNextList(documentList);
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
