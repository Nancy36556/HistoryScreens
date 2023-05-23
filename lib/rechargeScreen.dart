import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_pagination/blocs/bloc/recharge_bloc.dart';
import 'Model/Recharge.dart';


class RechargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<TripsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('History Charges')),
      ),
      body: BlocBuilder<RechargeBloc, RechargeState>(
        // ignore: missing_return
        builder: (context, State) {
          if (State is LoadinRechargegstate) {
            return Center(child: Text('Loading...'));
          } else if (State is LoadedRechargestate) {
            List<Recharge> data = State.recharge;

            return ListView.builder(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                      Text(data[index].amount),
                      Text(data[index].paymentMethod)
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
