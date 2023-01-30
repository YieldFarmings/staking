part of 'connect_wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object?> get props => [];
}

class WalletLoading extends WalletState {
  final String msg;
  const WalletLoading({required this.msg});

  @override
  List<Object?> get props => [msg];
}
class WalletError extends WalletState {
  final String error;
  const WalletError({required this.error});

  @override
  List<Object?> get props => [];
}

class WalletConnected extends WalletState {
  final String address;
  const WalletConnected({required this.address});

  @override
  List<Object?> get props => [];
}