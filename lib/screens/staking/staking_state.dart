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

class StakingConnected extends StakingState {
  final String address;
  const StakingConnected({required this.address});

  @override
  List<Object?> get props => [];
}

class SwapPreviewSuccess extends StakingState {
  final double previewAmount;
  const SwapPreviewSuccess({required this.previewAmount});

  @override
  List<Object?> get props => [previewAmount];
}

class StakingSuccess extends StakingState {
  final String msg;
  const StakingSuccess({required this.msg});

  @override
  List<Object?> get props => [msg];
}
