part of 'swap_bloc.dart';

abstract class SwapState extends Equatable {
  const SwapState();
}

class SwapInitial extends SwapState {
  @override
  List<Object?> get props => [];
}

class SwapLoading extends SwapState {
  final String msg;
  const SwapLoading({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class SwapError extends SwapState {
  final String error;
  const SwapError({required this.error});

  @override
  List<Object?> get props => [];
}

class SwapConnected extends SwapState {
  final String address;
  const SwapConnected({required this.address});

  @override
  List<Object?> get props => [];
}

class SwapPreviewSuccess extends SwapState {
  final double previewAmount;
  const SwapPreviewSuccess({required this.previewAmount});

  @override
  List<Object?> get props => [previewAmount, Random().nextInt(500)];
}

class SwapSuccess extends SwapState {
  final String msg;
  const SwapSuccess({required this.msg});

  @override
  List<Object?> get props => [msg];
}
