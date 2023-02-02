import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../../Repositories/staking_repository.dart';

part 'staking_event.dart';
part 'staking_state.dart';

class StakingBloc extends Bloc<StakingEvent, StakingState> {
  final StakingRepository stakingRepository;
  late Web3Provider web3provider;
  String address = '';
  bool isAllowed = false;

  StakingBloc({required this.stakingRepository}) : super(StakingInitial()) {
    on<StakingConnectWallet>(_mapWalletConnectToState);
    on<StakingCheck>(_checkToState);
    on<StakingAmount>(_mapStakingAmountToState);
  }

  FutureOr<void> _checkToState(StakingCheck event, Emitter<StakingState> emit) async {}

  FutureOr<void> _mapWalletConnectToState(StakingConnectWallet event, Emitter<StakingState> emit) async {
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
              name: 'BNB Smart Chain Testnet',
              symbol: 'tBNB',
              decimals: 18,
            ),
            rpcUrls: ['https://data-seed-prebsc-1-s1.binance.org:8545/'],
          );
        }
        final accounts = await ethereum!.requestAccount();
        web3provider = Web3Provider.fromEthereum(ethereum!);
        address = accounts.first;

        if (accounts.isNotEmpty) {
          BigInt amount= await web3provider.getBalance(address);
          double amountsd=amount.toDouble();
          emit(StakingTotalBalance(amount: amountsd));
          emit(StakingConnected(address: accounts.first));
        } else if (accounts.isEmpty) {
          emit(StakingConnected(address: accounts.first));
        }
      } on EthereumUserRejected {
        emit(const StakingError(error: 'User closed modal'));
      }
    } else {
      try {
        final wc = WalletConnectProvider.fromRpc(
          {97: "https://data-seed-prebsc-1-s1.binance.org:8545/"},
          chainId: 97,
        );
        await wc.connect();
        web3provider = Web3Provider.fromWalletConnect(wc);
        address = wc.accounts.first;

        if (wc.accounts.isNotEmpty) {
          emit(StakingConnected(address: wc.accounts.first));
        } else if (wc.accounts.isEmpty) {
          emit(StakingConnected(address: wc.accounts.first));
        }
      } catch (e) {
        emit(const StakingError(error: 'User closed modal'));
      }
    }
  }

  FutureOr<void> _mapStakingAmountToState(StakingAmount event, Emitter<StakingState> emit) async {

    /// Check if user allowed contract to access funds.
    String bsbotAddress = "0x678DD16C17A410A50fe23790C421ee931dC37b7D";
    final stakingAddress = "0xB49791eBF15188c13B0577130D2B6506342d9bD2";
    var userAdd = await web3provider.getSigner().getAddress();
    late Contract erc20;
    BigInt amount = BigInt.from(event.amount * pow(10, 18));
    erc20 = erc20Contract(contractAddress: bsbotAddress);
    BigInt allowance = await erc20.call<BigInt>('allowance', [userAdd,stakingAddress]);
   // Contract stakingInfo = stakingContract(contractAddress: event.poolAddress);
  //  BigInt previewAmount = await stakingInfo.call<BigInt>("stakeBalanceOfUser",[userAdd]);

        // emit(StakingStatus(previewAmount: previewAmount));
        // if(previewAmount >= BigInt.from(0) && event.from=="unstaking"){
        //   emit(const StakingLoading(msg: "UnStaking.."));
        //
        //   try {
        //     emit(const StakingLoading(msg: "Waiting for Transaction Confirmation...."));
        //
        //     /// Create unstacking contract
        //     Contract unStaking = stakingContract(contractAddress: event.poolAddress);
        //     TransactionResponse data = await unStaking.send('withdraw', [BigInt.from(event.amount * pow(10, 18))]);
        //     emit(UnStakingSuccess(msg: "Transaction Succeed with hash : ${data.hash}"));
        //   } catch (e) {
        //     emit(StakingError(error: e.toString(), connect: ''));
        //   }
        // }
        // if(previewAmount >= BigInt.from(0) && event.from=="claim"){
        //   emit(const StakingLoading(msg: "Claiming.."));
        //
        //   try {
        //     emit(const StakingLoading(msg: "Waiting for Transaction Confirmation...."));
        //
        //     /// Create claim contract
        //     Contract claim = factoryContract(contractAddress:"0xCc91F6CC61Ca721A60478B1405d0A738A73Af963");
        //     TransactionResponse data = await claim.send('withdrawRewardToken', [1]);
        //     emit(ClaimSuccess(msg: "Transaction Succeed with hash : ${data.hash}"));
        //   } catch (e) {
        //     emit(StakingError(error: e.toString(), connect: ''));
        //   }
      //  }

    if (allowance >= BigInt.from(10 * pow(10, 18)) || isAllowed) {
      isAllowed = true;
      emit(const StakingLoading(msg: "Staking.."));
      try {
        emit(const StakingLoading(
            msg: "Waiting for Transaction Confirmation...."));

        /// Create stacking contract
        Contract staking = stakingContract(contractAddress: stakingAddress);
        TransactionResponse data = await staking.send(
            'stake', [BigInt.from(event.amount * pow(10, 18))]);
        emit(StakingSuccess(
            msg: "Transaction Succeed with hash : ${data.hash}"));
      } catch (e) {
      //  emit(StakingError(error: e.toString()));
      }
    } else {
      try {
        emit(const StakingLoading(msg: "Waiting for Approval...."));
        TransactionResponse data = await erc20.send('approve', [stakingAddress, BigInt.from(event.amount * pow(10, 40))]);
        _mapStakingAmountToState(event, emit);
        isAllowed = true;
        add(StakingAmount(amount: event.amount));
      } catch (e) {
        emit(StakingError(error: e.toString()));
        return;
      }
    }
  }



Contract factoryContract({required String contractAddress})
{
  var factoryAbi='''
  [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Approval",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			}
		],
		"name": "allowance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_token",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "_factoryContract",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_rewards",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_decimals",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_rewardsDuration",
				"type": "uint256"
			}
		],
		"name": "createPool",
		"outputs": [
			{
				"internalType": "contract Staking",
				"name": "pool",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"internalType": "uint8",
				"name": "",
				"type": "uint8"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "subtractedValue",
				"type": "uint256"
			}
		],
		"name": "decreaseAllowance",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "spender",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "addedValue",
				"type": "uint256"
			}
		],
		"name": "increaseAllowance",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_poolId",
				"type": "uint256"
			}
		],
		"name": "poolDetails",
		"outputs": [
			{
				"components": [
					{
						"internalType": "address",
						"name": "poolAddress",
						"type": "address"
					},
					{
						"internalType": "address",
						"name": "_token",
						"type": "address"
					},
					{
						"internalType": "address",
						"name": "_owner",
						"type": "address"
					},
					{
						"internalType": "address",
						"name": "_factoryContract",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "_rewards",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "_decimals",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "_rewardsDuration",
						"type": "uint256"
					}
				],
				"internalType": "struct Factory.Pool",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "poolId",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "userPool",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "user",
				"type": "address"
			}
		],
		"name": "userStake",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_poolId",
				"type": "uint256"
			}
		],
		"name": "withdrawRewardToken",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
  ''';
  final jsonFactoryInterface = Interface(factoryAbi);
  final contract = Contract(contractAddress, jsonFactoryInterface, web3provider.getSigner());
  return contract;
}

  Contract stakingContract({required String contractAddress}) {
    var stakingAbi =
        '[{"inputs":[{"internalType":"address","name":"_token","type":"address"},{"internalType":"address","name":"_owner","type":"address"},{"internalType":"address","name":"_factoryContract","type":"address"},{"internalType":"uint256","name":"_rewards","type":"uint256"},{"internalType":"uint256","name":"_decimals","type":"uint256"},{"internalType":"uint256","name":"_rewardsDuration","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"reward","type":"uint256"}],"name":"RewardPaid","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Staked","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Withdrawn","type":"event"},{"inputs":[],"name":"_totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_account","type":"address"}],"name":"earned","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"exit","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"}],"name":"getReward","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bool","name":"_status","type":"bool"}],"name":"pausedContract","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"rewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"rewardsDuration","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"stake","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_user","type":"address"}],"name":"stakeBalanceOfUser","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"token","outputs":[{"internalType":"contract IERC20","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"withdrawRewardToken","outputs":[],"stateMutability":"nonpayable","type":"function"}]';
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
