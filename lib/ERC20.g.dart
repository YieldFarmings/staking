// // Generated code, do not modify. Run `build_runner build` to re-generate!
// // @dart=2.12
// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:web3dart/web3dart.dart' as _i1;
// import 'dart:typed_data' as _i2;
//
// final _contractAbi = _i1.ContractAbi.fromJson(
//   '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"burn","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_value","type":"uint256"}],"name":"burnFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"},{"name":"_extraData","type":"bytes"}],"name":"approveAndCall","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"initialSupply","type":"uint256"},{"name":"tokenName","type":"string"},{"name":"tokenSymbol","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Burn","type":"event"}]',
//   'ERC20',
// );
//
// class ERC20 extends _i1.GeneratedContract {
//   ERC20({
//     required _i1.EthereumAddress address,
//     required _i1.Web3Client client,
//     int? chainId,
//   }) : super(
//           _i1.DeployedContract(
//             _contractAbi,
//             address,
//           ),
//           client,
//           chainId,
//         );
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> name({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[0];
//     assert(checkSignature(function, '06fdde03'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> approve(
//     _i1.EthereumAddress _spender,
//     BigInt _value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[1];
//     assert(checkSignature(function, '095ea7b3'));
//     final params = [
//       _spender,
//       _value,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> totalSupply({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[2];
//     assert(checkSignature(function, '18160ddd'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> transferFrom(
//     _i1.EthereumAddress _from,
//     _i1.EthereumAddress _to,
//     BigInt _value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[3];
//     assert(checkSignature(function, '23b872dd'));
//     final params = [
//       _from,
//       _to,
//       _value,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> decimals({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[4];
//     assert(checkSignature(function, '313ce567'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> burn(
//     BigInt _value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[5];
//     assert(checkSignature(function, '42966c68'));
//     final params = [_value];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> balanceOf(
//     _i1.EthereumAddress $param6, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[6];
//     assert(checkSignature(function, '70a08231'));
//     final params = [$param6];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> burnFrom(
//     _i1.EthereumAddress _from,
//     BigInt _value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[7];
//     assert(checkSignature(function, '79cc6790'));
//     final params = [
//       _from,
//       _value,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> symbol({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[8];
//     assert(checkSignature(function, '95d89b41'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> transfer(
//     _i1.EthereumAddress _to,
//     BigInt _value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[9];
//     assert(checkSignature(function, 'a9059cbb'));
//     final params = [
//       _to,
//       _value,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> approveAndCall(
//     _i1.EthereumAddress _spender,
//     BigInt _value,
//     _i2.Uint8List _extraData, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[10];
//     assert(checkSignature(function, 'cae9ca51'));
//     final params = [
//       _spender,
//       _value,
//       _extraData,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> allowance(
//     _i1.EthereumAddress $param14,
//     _i1.EthereumAddress $param15, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[11];
//     assert(checkSignature(function, 'dd62ed3e'));
//     final params = [
//       $param14,
//       $param15,
//     ];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// Returns a live stream of all Transfer events emitted by this contract.
//   Stream<Transfer> transferEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Transfer');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Transfer(decoded);
//     });
//   }
//
//   /// Returns a live stream of all Burn events emitted by this contract.
//   Stream<Burn> burnEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Burn');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Burn(decoded);
//     });
//   }
// }
//
// class Transfer {
//   Transfer(List<dynamic> response)
//       : from = (response[0] as _i1.EthereumAddress),
//         to = (response[1] as _i1.EthereumAddress),
//         value = (response[2] as BigInt);
//
//   final _i1.EthereumAddress from;
//
//   final _i1.EthereumAddress to;
//
//   final BigInt value;
// }
//
// class Burn {
//   Burn(List<dynamic> response)
//       : from = (response[0] as _i1.EthereumAddress),
//         value = (response[1] as BigInt);
//
//   final _i1.EthereumAddress from;
//
//   final BigInt value;
// }
