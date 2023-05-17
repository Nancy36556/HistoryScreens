import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'blocs/ReservationBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataListBloc dataListBloc;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    dataListBloc = DataListBloc();
    dataListBloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Reservation history")),
          backgroundColor: Colors.green),
      body: Column(
        children: [
          StreamBuilder<List<DocumentSnapshot>>(
            stream: dataListBloc.ReservStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(snapshot.data[index]["tripid"]),
                          subtitle: Container(
                            child: Column(children: [
                              Text(snapshot.data[index]["startdatetime"]),
                              Text(snapshot.data[index]["enddatetime"]),
                              Text(snapshot.data[index]["numberofstations"]),
                              Text(snapshot.data[index]["startstationid"]),
                              Text(snapshot.data[index]["endstationid"]),
                              Text(snapshot.data[index]["paid"]),
                            ]),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      dataListBloc.fetchNext();
    }
  }
}
