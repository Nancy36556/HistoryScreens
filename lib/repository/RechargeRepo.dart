import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_pagination/Model/Recharge.dart';

class RechargeRepository {
  final FirebaseFirestore _firestore;

  RechargeRepository(this._firestore);

  Future<List<Recharge>> getRecharge() async {
    final query = _firestore
        .collection('wallet_charge_history')
        .limit(10);

    final snapshots = await query.get();

    return snapshots.docs.map((doc) {
      final data = doc.data();

      return Recharge(
    amount:data['amount'],
    paymentMethod:data['paymentMethod']

      );
    }).toList();
  }
}