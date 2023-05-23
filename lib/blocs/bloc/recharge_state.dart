part of 'recharge_bloc.dart';

abstract class RechargeState extends Equatable {
  const RechargeState();
  
  @override
  List<Object> get props => [];
}

class ErrorRechargestate extends RechargeState {
  final String error;
  ErrorRechargestate(this.error);
  @override
  List<Object> get props => [error];
}
class LoadinRechargegstate extends RechargeState {
  @override
  List<Object> get props => [];
}
class LoadedRechargestate extends RechargeState {
  final List<Recharge> recharge;

  LoadedRechargestate(
    this.recharge
  );
  @override
  List<Object> get props => [recharge];

}

