part of 'recharge_bloc.dart';

abstract class RechargeEvent extends Equatable {
  const RechargeEvent();

  @override
  List<Object> get props => [];
}

class FetchRechargeEvent extends RechargeEvent {
  FetchRechargeEvent();
}
