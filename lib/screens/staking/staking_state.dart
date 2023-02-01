part of 'staking_bloc.dart';

abstract class StakingState extends Equatable {
  const StakingState();
}

class StakingInitial extends StakingState {
  @override
  List<Object?> get props => [];
}

class StakingLoading extends StakingState {
  final String msg;
  const StakingLoading({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class StakingError extends StakingState {
  final String error;
  const StakingError({required this.error});

  @override
  List<Object?> get props => [];
}

class StakingStatus extends StakingState {
  final previewAmount;
  const StakingStatus({required this.previewAmount});

  @override
  List<Object?> get props => [];
}

class Approved extends StakingState {
  final msg;
  const Approved({required this.msg});

  @override
  List<Object?> get props => [];
}

class StakingConnected extends StakingState {
  final String address;
  const StakingConnected({required this.address});

  @override
  List<Object?> get props => [];
}

class StakingPreviewSuccess extends StakingState {
  final double previewAmount;
  const StakingPreviewSuccess({required this.previewAmount});

  @override
  List<Object?> get props => [previewAmount];
}

class StakingTotalBalance extends StakingState {
  double amount;

  StakingTotalBalance({
    required this.amount,
  });


  @override
  List<Object?> get props => [amount];
}

class StakingSuccess extends StakingState {
  final String msg;
  const StakingSuccess({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class UnStakingSuccess extends StakingState {
  final String msg;
  const UnStakingSuccess({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class ClaimSuccess extends StakingState {
  final String msg;
  const ClaimSuccess({required this.msg});

  @override
  List<Object?> get props => [msg];
}