part of 'swap_bloc.dart';

abstract class SwapEvent extends Equatable {
  const SwapEvent();
}

class SwapCheck extends SwapEvent {
  @override
  List<Object?> get props => [];
}

class SwapConnectWallet extends SwapEvent {
  @override
  List<Object?> get props => [];
}

class SwapAmount extends SwapEvent {
  final double amount;
  final String from;

  const SwapAmount({
    required this.amount,
    required this.from,
  });

  @override
  List<Object?> get props => [amount];
}

class SwapPreview extends SwapEvent {
  final double amount;
  final String from;

  const SwapPreview({
    required this.amount,
    required this.from,
  });

  @override
  List<Object?> get props => [amount, from];
}
