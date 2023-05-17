import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'blocs/RechargeBloc.dart';
class RechargeHistory extends StatefulWidget {
  const RechargeHistory({Key key}) : super(key: key);

  @override
  State<RechargeHistory> createState() => _RechargeHistoryState();
}

class _RechargeHistoryState extends State<RechargeHistory> { 
  RechargeListBloc rechargeListBloc;
 
  ScrollController controller = ScrollController();
 @override
  void initState() {
    super.initState();
    rechargeListBloc = RechargeListBloc();
    rechargeListBloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Center(child: Text("Recharge history")),
       backgroundColor: Colors.green,),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: rechargeListBloc.DataStream,
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
                      title:  Column(
                        children: [
                          Text(snapshot.data[index]["amount"]),
                          Text(snapshot.data[index]["paymentMethod"]),
                        ],
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
    );
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      rechargeListBloc.fetchNext();
    }
  }
}
  