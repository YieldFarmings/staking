import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bsbot/Repositories/swap_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web3/flutter_web3.dart';

part 'swap_event.dart';
part 'swap_state.dart';

class SwapBloc extends Bloc<SwapEvent, SwapState> {
  final SwapRepository swapRepository;
  late Web3Provider web3provider;
  String address = '';

  SwapBloc({required this.swapRepository}) : super(SwapInitial()) {
    on<SwapEvent>((event, emit) {});
    on<SwapCheck>(_checkToState);
    on<SwapConnectWallet>(_mapWalletConnectToState);
    on<SwapAmount>(_mapSwapAmountToState);
    on<SwapPreview>(_mapSwapPreviewToState);
  }

  FutureOr<void> _checkToState(SwapCheck event, Emitter<SwapState> emit) async {
    // if (Ethereum.isSupported) {
    //   if (ethereum!.isConnected()) {
    //     final accounts = await ethereum!.getAccounts();
    //     if (accounts.isNotEmpty) {
    //       emit(SwapConnected(address: accounts.first));
    //     }
    //   }
    // }
  }

  FutureOr<void> _mapWalletConnectToState(SwapConnectWallet event, Emitter<SwapState> emit) async {
    emit(const SwapLoading(msg: "Connecting To Wallet"));

    if (Ethereum.isSupported) {
      try {
        try {
          await ethereum!.walletSwitchChain(56);
        } on EthereumUnrecognizedChainException {
          await ethereum!.walletAddChain(
            chainId: 56,
            chainName: 'Binance',
            nativeCurrency: CurrencyParams(name: 'BNB', symbol: 'BNB', decimals: 18),
            rpcUrls: ['https://bsc-dataseed1.binance.org/'],
          );
        }
        final accounts = await ethereum!.requestAccount();
        web3provider = Web3Provider.fromEthereum(ethereum!);
        address = accounts.first;

        if (accounts.isNotEmpty) {
          emit(SwapConnected(address: accounts.first));
        }
      } on EthereumUserRejected {
        emit(const SwapError(error: 'User closed modal'));
      }
    } else {
      try {
        //final wc = WalletConnectProvider.fromRpc({97: "https://data-seed-prebsc-2-s2.binance.org:8545"}, chainId: 97);
        final wc = WalletConnectProvider.fromRpc({56: "https://bsc-dataseed1.binance.org/"}, chainId: 56);
        await wc.connect();
        web3provider = Web3Provider.fromWalletConnect(wc);
        address = wc.accounts.first;

        if (wc.accounts.isNotEmpty) {
          emit(SwapConnected(address: wc.accounts.first));
        }
      } catch (e) {
        emit(const SwapError(error: 'User closed modal'));
      }
    }
  }

  FutureOr<void> _mapSwapAmountToState(SwapAmount event, Emitter<SwapState> emit) async {
    emit(const SwapLoading(msg: "Swapping.."));
    String bsbotAddress = '0x273edfE2A6aA8Dce9A6FEA380C3D518252D7E82B';
    String usdtAddress = '0x55d398326f99059fF775485246999027B3197955';
    String swapAddress = "0xBEE2Cb6319F11264C8E2187F46dFC356Fa08CC5F";

    var userAdd = await web3provider.getSigner().getAddress();
    late Contract erc20;

    if (event.from == 'bsbot') {
      erc20 = erc20Contract(contractAddress: bsbotAddress);
      BigInt allowance = await erc20.call<BigInt>('allowance', [userAdd, swapAddress]);

      if (allowance >= BigInt.from(10 * pow(10, 18))) {
        try {
          emit(const SwapLoading(msg: "Waiting for Transaction Confirmation...."));
          TransactionResponse data = await swapContract().send('swapBSBOTTOUSDT', [BigInt.from(event.amount * pow(10, 18))]);
          emit(SwapSuccess(msg: "Transaction Succeed with hash : ${data.hash}"));
        } catch (e) {
          emit(SwapError(error: e.toString()));
        }
      } else {
        try {
          emit(const SwapLoading(msg: "Waiting for Approval...."));
          TransactionResponse data = await erc20.send('approve', [swapAddress, BigInt.from(event.amount * pow(10, 40))]);
          _mapSwapAmountToState(event, emit);
        } catch (e) {
          emit(SwapError(error: e.toString()));
          return;
        }
      }
    }

    if (event.from == 'usdt') {
      erc20 = erc20Contract(contractAddress: usdtAddress);
      BigInt allowance = await erc20.call<BigInt>('allowance', [userAdd, swapAddress]);

      if (allowance >= BigInt.from(10 * pow(10, 18))) {
        try {
          emit(const SwapLoading(msg: "Waiting for Transaction Confirmation...."));
          TransactionResponse data = await swapContract().send('swapUSDTTOBSBOT', [BigInt.from(event.amount * pow(10, 18))]);
          emit(SwapSuccess(msg: "Transaction Succeed with hash : ${data.hash}"));
        } catch (e) {
          emit(SwapError(error: e.toString()));
        }
      } else {
        try {
          emit(const SwapLoading(msg: "Waiting for Approval...."));
          TransactionResponse data = await erc20.send('approve', [swapAddress, BigInt.from(event.amount * pow(10, 40))]);
          _mapSwapAmountToState(event, emit);
        } catch (e) {
          emit(SwapError(error: e.toString()));
          return;
        }
      }
    }
  }

  FutureOr<void> _mapSwapPreviewToState(SwapPreview event, Emitter<SwapState> emit) async {
    if (event.from == 'bsbot') {
      BigInt previewAmount = await swapContract().call<BigInt>("usdtSwapAmount", [BigInt.from(event.amount * pow(10, 18))]);
      double am = previewAmount.toDouble() / pow(10, 18);
      emit(SwapPreviewSuccess(previewAmount: am));
    }

    if (event.from == 'usdt') {
      BigInt previewAmount = await swapContract().call<BigInt>("bsbotSwapAmount", [BigInt.from(event.amount * pow(10, 18))]);
      double am = previewAmount.toDouble() / pow(10, 18);
      emit(SwapPreviewSuccess(previewAmount: am));
    }
  }

  Contract swapContract() {
    String contractAddress = "0xBEE2Cb6319F11264C8E2187F46dFC356Fa08CC5F";
    var swapAbi =
        '[{"inputs":[{"internalType":"address","name":"_owner","type":"address"},{"internalType":"address","name":"_usdtToken","type":"address"},{"internalType":"address","name":"_bsbotToken","type":"address"},{"internalType":"uint256","name":"_usdtExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_bsbotExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalUsdt","type":"uint256"},{"internalType":"uint256","name":"_decimalBsbot","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"newExchangeRate","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"decimal","type":"uint256"}],"name":"BSBOTChangeRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"BSBOTTOUSDT","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newAddress","type":"address"}],"name":"BSBOTTokenAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"bool","name":"value","type":"bool"}],"name":"Blacklisted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"oldOwner","type":"address"},{"indexed":false,"internalType":"address","name":"newOwner","type":"address"}],"name":"ChangeOwner","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Paused","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"previousAdminRole","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"newAdminRole","type":"bytes32"}],"name":"RoleAdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleGranted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleRevoked","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"newExchangeRate","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"decimal","type":"uint256"}],"name":"USDTChangeRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"USDTToBSBOT","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newAddress","type":"address"}],"name":"USDTTokenAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Unpaused","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Withdraw","type":"event"},{"inputs":[],"name":"DEFAULT_ADMIN_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"Owner_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"bool","name":"value","type":"bool"}],"name":"blacklistMalicious","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"bsbotExchangeRate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"bsbotSwapAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"bsbotToken","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_bsbotExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalBsbot","type":"uint256"}],"name":"changeBSBOTExchangeRate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_bsbotToken","type":"address"}],"name":"changeBSBOTTokenAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_usdtExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalUsdt","type":"uint256"}],"name":"changeUSDTExchangeRate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_usdtToken","type":"address"}],"name":"changeUSDTTokenAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"decimalBsbot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimalUsdt","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleAdmin","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"hasRole","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"isBlacklisted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"renounceRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"revokeRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_owner","type":"address"}],"name":"setOwner","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"swapBSBOTTOUSDT","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"swapUSDTTOBSBOT","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unpaused","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"usdtExchangeRate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"usdtSwapAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"usdtToken","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_token","type":"address"},{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"}]';
    final jsonSwapInterface = Interface(swapAbi);
    final contract = Contract(contractAddress, jsonSwapInterface, web3provider.getSigner());
    return contract;
  }

  Contract erc20Contract({required String contractAddress}) {
    var erc20Abi =
        '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"burn","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_value","type":"uint256"}],"name":"burnFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"},{"name":"_extraData","type":"bytes"}],"name":"approveAndCall","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"initialSupply","type":"uint256"},{"name":"tokenName","type":"string"},{"name":"tokenSymbol","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Burn","type":"event"}]';
    final erc20 = Contract(contractAddress, Interface(erc20Abi), web3provider.getSigner());
    return erc20;
  }
}
