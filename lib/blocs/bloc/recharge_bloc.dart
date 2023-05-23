import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_pagination/Model/Recharge.dart';
import 'package:flutter_firebase_pagination/repository/RechargeRepo.dart';

part 'recharge_event.dart';
part 'recharge_state.dart';

class RechargeBloc extends Bloc<RechargeEvent, RechargeState> {
    final RechargeRepository rechargeRepository;
  RechargeBloc(this.rechargeRepository) : super(LoadinRechargegstate()) {
    on<RechargeEvent>((event, emit) async{
      emit(LoadinRechargegstate());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final rechargeData = await rechargeRepository.getRecharge();
        emit(LoadedRechargestate(rechargeData));
      } catch (e) {
        emit(ErrorRechargestate(e.toString()));
      }
    });
  }
}

