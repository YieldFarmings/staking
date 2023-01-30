part of 'connect_wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}
class ConnectWallet extends WalletEvent {
  @override
  List<Object?> get props => [];
}