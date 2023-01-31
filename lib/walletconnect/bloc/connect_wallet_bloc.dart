import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bsbot/Repositories/swap_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../../Repositories/wallet_repository.dart';

part 'connect_wallet_event.dart';
part 'connect_wallet_state.dart';



class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  late Web3Provider web3provider;
  String address = '';

  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<ConnectWallet>(_mapWalletConnectToState);
  }

  FutureOr<void> _mapWalletConnectToState(ConnectWallet event,
      Emitter<WalletState> emit) async {
    emit(const WalletLoading(msg: "Connecting To Wallet"));

    if (Ethereum.isSupported) {
      try {
        try {
          await ethereum!.walletSwitchChain(56);
        } on EthereumUnrecognizedChainException {
          await ethereum!.walletAddChain(
            chainId: 97,
            chainName: 'Binance',
            nativeCurrency: CurrencyParams(
                name: 'BNB Smart Chain Testnet', symbol: 'BNB', decimals: 18),
            rpcUrls: ['https://data-seed-prebsc-1-s3.binance.org:8545/'],
          );
        }
        final accounts = await ethereum!.requestAccount();
        web3provider = Web3Provider.fromEthereum(ethereum!);
        address = accounts.first;

        if (accounts.isNotEmpty) {
          emit(WalletConnected(address: accounts.first));
        }
      } on EthereumUserRejected {
        emit(const WalletError(error: 'User closed modal'));
      }
    } else {
      try {
        //final wc = WalletConnectProvider.fromRpc({97: "https://data-seed-prebsc-2-s2.binance.org:8545"}, chainId: 97);
        final wc = WalletConnectProvider.fromRpc(
            {97: 'https://data-seed-prebsc-1-s3.binance.org:8545/'},
            chainId: 97);
        await wc.connect();
        web3provider = Web3Provider.fromWalletConnect(wc);
        address = wc.accounts.first;

        if (wc.accounts.isNotEmpty) {
          emit(WalletConnected(address: wc.accounts.first));
        }
      } catch (e) {
        emit(const WalletError(error: 'User closed modal'));
      }
    }
  }
}
