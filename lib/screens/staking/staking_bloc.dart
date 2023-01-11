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
    var stakingAbi = '[{"inputs": [{"internalType": "address","name": "_owner","type": "address"}],"stateMutability": "nonpayable","type": "constructor"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "owner","type": "address"},{"indexed": true,"internalType": "address","name": "spender","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Approval","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "from","type": "address"},{"indexed": true,"internalType": "address","name": "to","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Transfer","type": "event"},{"inputs": [{"internalType": "address","name": "owner","type": "address"},{"internalType": "address","name": "spender","type": "address"}],"name": "allowance","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "approve","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "account","type": "address"}],"name": "balanceOf","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "_token","type": "address"},{"internalType": "address","name": "_owner","type": "address"},{"internalType": "address","name": "_factoryContract","type": "address"},{"internalType": "uint256","name": "_rewards","type": "uint256"},{"internalType": "uint256","name": "_decimals","type": "uint256"},{"internalType": "uint256","name": "_rewardsDuration","type": "uint256"}],"name": "createPool","outputs": [{"internalType": "contract Staking","name": "pool","type": "address"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [],"name": "decimals","outputs": [{"internalType": "uint8","name": "","type": "uint8"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "subtractedValue","type": "uint256"}],"name": "decreaseAllowance","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "addedValue","type": "uint256"}],"name": "increaseAllowance","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [],"name": "name","outputs": [{"internalType": "string","name": "","type": "string"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "uint256","name": "","type": "uint256"}],"name": "poolAddress","outputs": [{"internalType": "address","name": "","type": "address"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "poolId","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "symbol","outputs": [{"internalType": "string","name": "","type": "string"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "totalSupply","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "to","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "transfer","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "from","type": "address"},{"internalType": "address","name": "to","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "transferFrom","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "uint256","name": "_poolId","type": "uint256"}],"name": "withdrawRewardToken","outputs": [],"stateMutability": "nonpayable","type": "function"}]';
    final jsonStakingInterface = Interface(stakingAbi);
    final contract = Contract(contractAddress, jsonStakingInterface, web3provider.getSigner());
    return contract;
  }
}
