part of 'staking_bloc.dart';

abstract class StakingEvent extends Equatable {
  const StakingEvent();
}

class StakingConnectWallet extends StakingEvent {


  @override
  List<Object?> get props => [];
}

class StakingDisConnectWallet extends StakingEvent {


  @override
  List<Object?> get props => [];
}

class StakingCheck extends StakingEvent {
  @override
  List<Object?> get props => [];
}

class StakingAmount extends StakingEvent {
  late final double amount;


  StakingAmount({
    required this.amount,

  });

  @override
  List<Object?> get props => [amount];
}

class ApproveAmount extends StakingEvent {
  final double amount;


  ApproveAmount({
    required this.amount,

  });

  @override
  List<Object?> get props => [amount];
}


class StakingPreview extends StakingEvent {
  final double amount;
  final String from;

  const StakingPreview({
    required this.amount,
    required this.from,
  });
  @override
  List<Object?> get props => [amount, from];
}