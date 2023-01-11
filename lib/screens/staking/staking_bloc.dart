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
    on<StakingAmount>(_mapStakingAmountToState);
    on<StakingPreview>(_mapStakingPreviewToState);
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
  FutureOr<void> _mapStakingAmountToState(StakingAmount event, Emitter<StakingState> emit) async {
    emit(const StakingLoading(msg: "Staking.."));

    final signer = provider!.getSigner();

// Get account balance
    BigInt total=signer.getBalance() as BigInt;
    double amount=total as double;
    emit(StakingTotalBalance(amount:amount));
    // 315752957360231815

// Get account sent transaction count (not contract call)
    await signer.getTransactionCount(BlockTag.latest); // 1
        }



  FutureOr<void> _mapStakingPreviewToState(StakingPreview event, Emitter<StakingState> emit) async {
      BigInt previewAmount = await stakingContract().call<BigInt>("usdtSwapAmount", [BigInt.from(event.amount * pow(10, 18))]);
      double am = previewAmount.toDouble() / pow(10, 18);
      emit(StakingPreviewSuccess(previewAmount: am));
  }
  Contract stakingContract() {
    String contractAddress = "0x8d0bD17F6B4484b06A1Bb581EF6B6526c515e4d0";
    var stakingAbi ='[{"inputs": [{"internalType": "string","name": "_name","type": "string"},{"internalType": "string","name": "_symbol","type": "string"},{"internalType": "uint256","name": "_decimals","type": "uint256"},{"internalType": "uint256","name": "_supply","type": "uint256"},{"internalType": "address","name": "tokenOwner","type": "address"},{"internalType": "address","name": "_admin","type": "address"}],"payable": false,"stateMutability": "nonpayable","type": "constructor"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "owner","type": "address"},{"indexed": true,"internalType": "address","name": "spender","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Approval","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "blackListed","type": "address"},{"indexed": false,"internalType": "bool","name": "value","type": "bool"}],"name": "Blacklist","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "burner","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Burn","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "from","type": "address"},{"indexed": true,"internalType": "address","name": "to","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Mint","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "previousOwner","type": "address"},{"indexed": true,"internalType": "address","name": "newOwner","type": "address"}],"name": "OwnershipTransferred","type": "event"},{"anonymous": false,"inputs": [],"name": "Pause","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "from","type": "address"},{"indexed": true,"internalType": "address","name": "to","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Transfer","type": "event"},{"anonymous": false,"inputs": [],"name": "Unpause","type": "event"},{"constant": true,"inputs": [],"name": "admin","outputs": [{"internalType": "address","name": "","type": "address"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_admin","type": "address"},{"internalType": "address","name": "_from","type": "address"},{"internalType": "address","name": "_to","type": "address"},{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "adminTokenTransfer","outputs": [{"internalType": "bool","name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [{"internalType": "address","name": "_owner","type": "address"},{"internalType": "address","name": "_spender","type": "address"}],"name": "allowance","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_spender","type": "address"},{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "approve","outputs": [{"internalType": "bool","name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [{"internalType": "address","name": "_owner","type": "address"}],"name": "balanceOf","outputs": [{"internalType": "uint256","name": "balance","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "listAddress","type": "address"},{"internalType": "bool","name": "isBlackListed","type": "bool"}],"name": "blackListAddress","outputs": [{"internalType": "bool","name": "success","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "burn","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "decimals","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_spender","type": "address"},{"internalType": "uint256","name": "_subtractedValue","type": "uint256"}],"name": "decreaseApproval","outputs": [{"internalType": "bool","name": "success","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_spender","type": "address"},{"internalType": "uint256","name": "_addedValue","type": "uint256"}],"name": "increaseApproval","outputs": [{"internalType": "bool","name": "success","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "account","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "mint","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "name","outputs": [{"internalType": "string","name": "","type": "string"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "owner","outputs": [{"internalType": "address","name": "","type": "address"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [],"name": "pause","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "paused","outputs": [{"internalType": "bool","name": "","type": "bool"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "symbol","outputs": [{"internalType": "string","name": "","type": "string"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "totalSupply","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_to","type": "address"},{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "transfer","outputs": [{"internalType": "bool","name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "_from","type": "address"},{"internalType": "address","name": "_to","type": "address"},{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "transferFrom","outputs": [{"internalType": "bool","name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"internalType": "address","name": "newOwner","type": "address"}],"name": "transferOwnership","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [],"name": "unpause","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"}]';
       // '[{"inputs": [{"internalType": "address","name": "_owner","type": "address"}],"stateMutability": "nonpayable","type": "constructor"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "owner","type": "address"},{"indexed": true,"internalType": "address","name": "spender","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Approval","type": "event"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "from","type": "address"},{"indexed": true,"internalType": "address","name": "to","type": "address"},{"indexed": false,"internalType": "uint256","name": "value","type": "uint256"}],"name": "Transfer","type": "event"},{"inputs": [{"internalType": "address","name": "owner","type": "address"},{"internalType": "address","name": "spender","type": "address"}],"name": "allowance","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "approve","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "account","type": "address"}],"name": "balanceOf","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "_token","type": "address"},{"internalType": "address","name": "_owner","type": "address"},{"internalType": "address","name": "_factoryContract","type": "address"},{"internalType": "uint256","name": "_rewards","type": "uint256"},{"internalType": "uint256","name": "_decimals","type": "uint256"},{"internalType": "uint256","name": "_rewardsDuration","type": "uint256"}],"name": "createPool","outputs": [{"internalType": "contract Staking","name": "pool","type": "address"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [],"name": "decimals","outputs": [{"internalType": "uint8","name": "","type": "uint8"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "subtractedValue","type": "uint256"}],"name": "decreaseAllowance","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "spender","type": "address"},{"internalType": "uint256","name": "addedValue","type": "uint256"}],"name": "increaseAllowance","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [],"name": "name","outputs": [{"internalType": "string","name": "","type": "string"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "uint256","name": "","type": "uint256"}],"name": "poolAddress","outputs": [{"internalType": "address","name": "","type": "address"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "poolId","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "symbol","outputs": [{"internalType": "string","name": "","type": "string"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "totalSupply","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "to","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "transfer","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "from","type": "address"},{"internalType": "address","name": "to","type": "address"},{"internalType": "uint256","name": "amount","type": "uint256"}],"name": "transferFrom","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "uint256","name": "_poolId","type": "uint256"}],"name": "withdrawRewardToken","outputs": [],"stateMutability": "nonpayable","type": "function"}]';
    final jsonStakingInterface = Interface(stakingAbi);
    final contract = Contract(contractAddress, jsonStakingInterface, web3provider.getSigner());
    return contract;
  }
  Contract erc20Contract({required String contractAddress}) {
    var erc20Abi =
        '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"burn","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_value","type":"uint256"}],"name":"burnFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"},{"name":"_extraData","type":"bytes"}],"name":"approveAndCall","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"initialSupply","type":"uint256"},{"name":"tokenName","type":"string"},{"name":"tokenSymbol","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Burn","type":"event"}]';
    final erc20 = Contract(contractAddress, Interface(erc20Abi), web3provider.getSigner());
    return erc20;
  }
}
