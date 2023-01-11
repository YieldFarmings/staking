import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bsbot/Repositories/swap_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../../Repositories/staking_repository.dart';

part 'staking_event.dart';
part 'staking_state.dart';

class StakingBloc extends Bloc<StakingEvent, StakingState> {
  final StakingRepository stakingRepository;
  late Web3Provider web3provider;
  String address = '';

  StakingBloc({required this.stakingRepository}) : super(StakingInitial()) {
    on<StakingConnectWallet>(_mapWalletConnectToState);
    on<StakingCheck>(_checkToState);
  }

  FutureOr<void> _checkToState(StakingCheck event, Emitter<StakingState> emit) async {

  }

  FutureOr<void> _mapWalletConnectToState(StakingConnectWallet event,
      Emitter<StakingState> emit) async {
    emit(const StakingLoading(msg: "Connecting To Wallet"));

    if (Ethereum.isSupported) {
      try {
        try {
          await ethereum!.walletSwitchChain(97);
        } on EthereumUnrecognizedChainException {
          await ethereum!.walletAddChain(
            chainId: 97,
            chainName: 'Binance',
            nativeCurrency: CurrencyParams(
                name: 'BNB Smart Chain Testnet', symbol: 'tBNB', decimals: 18),
            rpcUrls: ['https://data-seed-prebsc-1-s3.binance.org:8545/'],
          );
        }
        final accounts = await ethereum!.requestAccount();
        web3provider = Web3Provider.fromEthereum(ethereum!);
        address = accounts.first;

        if (accounts.isNotEmpty) {
          emit(StakingConnected(address: accounts.first));
        }
      } on EthereumUserRejected {
        emit(const StakingError(error: 'User closed modal'));
      }
    } else {
      try {
        final wc = WalletConnectProvider.fromRpc(
            {97: "https://data-seed-prebsc-1-s3.binance.org:8545/"}, chainId: 97);
        await wc.connect();
        web3provider = Web3Provider.fromWalletConnect(wc);
        address = wc.accounts.first;

        if (wc.accounts.isNotEmpty) {
          emit(StakingConnected(address: wc.accounts.first));
        }
      } catch (e) {
        emit(const StakingError(error: 'User closed modal'));
      }
    }
  }
  Contract stakingContract() {
    String contractAddress = "0x8d0bD17F6B4484b06A1Bb581EF6B6526c515e4d0";
    var stakingAbi = '';
    final jsonStakingInterface = Interface(stakingAbi);
    final contract = Contract(contractAddress, jsonStakingInterface, web3provider.getSigner());
    return contract;
  }
}
