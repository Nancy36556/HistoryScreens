import 'package:cloud_firestore/cloud_firestore.dart';

class TripsProvider {
  Future<List<DocumentSnapshot>> fetchFirstList() async {
    return (await FirebaseFirestore.instance
            .collection("trips")
            .orderBy("startdatetime")
            .limit(10)
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList) async {
    return (await FirebaseFirestore.instance
            .collection("trips")
            .orderBy("startdatetime")
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;
  }
}
