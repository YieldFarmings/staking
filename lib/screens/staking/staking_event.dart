part of 'staking_bloc.dart';

abstract class StakingEvent extends Equatable {
  const StakingEvent();
}
class StakingConnectWallet extends StakingEvent {
  @override
  List<Object?> get props => [];
}
class StakingCheck extends StakingEvent {
  @override
  List<Object?> get props => [];
}


