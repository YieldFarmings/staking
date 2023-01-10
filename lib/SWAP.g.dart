// // Generated code, do not modify. Run `build_runner build` to re-generate!
// // @dart=2.12
// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:web3dart/web3dart.dart' as _i1;
// import 'dart:typed_data' as _i2;
//
// final _contractAbi = _i1.ContractAbi.fromJson(
//   '[{"inputs":[{"internalType":"address","name":"_owner","type":"address"},{"internalType":"address","name":"_usdtToken","type":"address"},{"internalType":"address","name":"_bsbotToken","type":"address"},{"internalType":"uint256","name":"_usdtExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_bsbotExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalUsdt","type":"uint256"},{"internalType":"uint256","name":"_decimalBsbot","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"newExchangeRate","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"decimal","type":"uint256"}],"name":"BSBOTChangeRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"BSBOTTOUSDT","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newAddress","type":"address"}],"name":"BSBOTTokenAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"bool","name":"value","type":"bool"}],"name":"Blacklisted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"oldOwner","type":"address"},{"indexed":false,"internalType":"address","name":"newOwner","type":"address"}],"name":"ChangeOwner","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Paused","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"previousAdminRole","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"newAdminRole","type":"bytes32"}],"name":"RoleAdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleGranted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"role","type":"bytes32"},{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":true,"internalType":"address","name":"sender","type":"address"}],"name":"RoleRevoked","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"newExchangeRate","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"decimal","type":"uint256"}],"name":"USDTChangeRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"user","type":"address"},{"indexed":false,"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"USDTToBSBOT","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newAddress","type":"address"}],"name":"USDTTokenAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Unpaused","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Withdraw","type":"event"},{"inputs":[],"name":"DEFAULT_ADMIN_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"Owner_ROLE","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"bool","name":"value","type":"bool"}],"name":"blacklistMalicious","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"bsbotExchangeRate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"bsbotSwapAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"bsbotToken","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_bsbotExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalBsbot","type":"uint256"}],"name":"changeBSBOTExchangeRate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_bsbotToken","type":"address"}],"name":"changeBSBOTTokenAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_usdtExchangeRate","type":"uint256"},{"internalType":"uint256","name":"_decimalUsdt","type":"uint256"}],"name":"changeUSDTExchangeRate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_usdtToken","type":"address"}],"name":"changeUSDTTokenAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"decimalBsbot","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimalUsdt","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"}],"name":"getRoleAdmin","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"hasRole","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"isBlacklisted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"renounceRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"role","type":"bytes32"},{"internalType":"address","name":"account","type":"address"}],"name":"revokeRole","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_owner","type":"address"}],"name":"setOwner","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"swapBSBOTTOUSDT","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"swapUSDTTOBSBOT","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unpaused","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"usdtExchangeRate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"usdtSwapAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"usdtToken","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_token","type":"address"},{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
//   'SWAP',
// );
//
// class SWAP extends _i1.GeneratedContract {
//   SWAP({
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
//   Future<_i2.Uint8List> DEFAULT_ADMIN_ROLE({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[1];
//     assert(checkSignature(function, 'a217fddf'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i2.Uint8List);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i2.Uint8List> Owner_ROLE({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[2];
//     assert(checkSignature(function, '8293e706'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i2.Uint8List);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> blacklistMalicious(
//     _i1.EthereumAddress account,
//     bool value, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[3];
//     assert(checkSignature(function, 'd8929342'));
//     final params = [
//       account,
//       value,
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
//   Future<BigInt> bsbotExchangeRate({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[4];
//     assert(checkSignature(function, 'f26888f1'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> bsbotSwapAmount(
//     BigInt _amount, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[5];
//     assert(checkSignature(function, '917b5815'));
//     final params = [_amount];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> bsbotToken({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[6];
//     assert(checkSignature(function, '27b5fcfa'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> changeBSBOTExchangeRate(
//     BigInt _bsbotExchangeRate,
//     BigInt _decimalBsbot, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[7];
//     assert(checkSignature(function, 'ef7b58b2'));
//     final params = [
//       _bsbotExchangeRate,
//       _decimalBsbot,
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
//   Future<String> changeBSBOTTokenAddress(
//     _i1.EthereumAddress _bsbotToken, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[8];
//     assert(checkSignature(function, '0085947f'));
//     final params = [_bsbotToken];
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
//   Future<String> changeUSDTExchangeRate(
//     BigInt _usdtExchangeRate,
//     BigInt _decimalUsdt, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[9];
//     assert(checkSignature(function, '40f7ec7f'));
//     final params = [
//       _usdtExchangeRate,
//       _decimalUsdt,
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
//   Future<String> changeUSDTTokenAddress(
//     _i1.EthereumAddress _usdtToken, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[10];
//     assert(checkSignature(function, 'f1a49354'));
//     final params = [_usdtToken];
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
//   Future<BigInt> decimalBsbot({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[11];
//     assert(checkSignature(function, '76a8249a'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> decimalUsdt({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[12];
//     assert(checkSignature(function, '02db721b'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i2.Uint8List> getRoleAdmin(
//     _i2.Uint8List role, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[13];
//     assert(checkSignature(function, '248a9ca3'));
//     final params = [role];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i2.Uint8List);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> grantRole(
//     _i2.Uint8List role,
//     _i1.EthereumAddress account, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[14];
//     assert(checkSignature(function, '2f2ff15d'));
//     final params = [
//       role,
//       account,
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
//   Future<bool> hasRole(
//     _i2.Uint8List role,
//     _i1.EthereumAddress account, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[15];
//     assert(checkSignature(function, '91d14854'));
//     final params = [
//       role,
//       account,
//     ];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<bool> isBlacklisted(
//     _i1.EthereumAddress $param14, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[16];
//     assert(checkSignature(function, 'fe575a87'));
//     final params = [$param14];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[17];
//     assert(checkSignature(function, '8da5cb5b'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> pause({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[18];
//     assert(checkSignature(function, '8456cb59'));
//     final params = [];
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
//   Future<bool> paused({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[19];
//     assert(checkSignature(function, '5c975abb'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> renounceRole(
//     _i2.Uint8List role,
//     _i1.EthereumAddress account, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[20];
//     assert(checkSignature(function, '36568abe'));
//     final params = [
//       role,
//       account,
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
//   Future<String> revokeRole(
//     _i2.Uint8List role,
//     _i1.EthereumAddress account, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[21];
//     assert(checkSignature(function, 'd547741f'));
//     final params = [
//       role,
//       account,
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
//   Future<String> setOwner(
//     _i1.EthereumAddress _owner, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[22];
//     assert(checkSignature(function, '13af4035'));
//     final params = [_owner];
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
//   Future<bool> supportsInterface(
//     _i2.Uint8List interfaceId, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[23];
//     assert(checkSignature(function, '01ffc9a7'));
//     final params = [interfaceId];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> swapBSBOTTOUSDT(
//     BigInt _amount, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[24];
//     assert(checkSignature(function, 'c4cfd8c8'));
//     final params = [_amount];
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
//   Future<String> swapUSDTTOBSBOT(
//     BigInt _amount, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[25];
//     assert(checkSignature(function, '225298de'));
//     final params = [_amount];
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
//   Future<String> unpaused({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[26];
//     assert(checkSignature(function, 'b0b62f5a'));
//     final params = [];
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
//   Future<BigInt> usdtExchangeRate({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[27];
//     assert(checkSignature(function, '30e6d7aa'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> usdtSwapAmount(
//     BigInt _amount, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[28];
//     assert(checkSignature(function, 'd2b2edfc'));
//     final params = [_amount];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }
//
//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> usdtToken({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[29];
//     assert(checkSignature(function, 'a98ad46c'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }
//
//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> withdraw(
//     _i1.EthereumAddress _token,
//     BigInt _amount, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[30];
//     assert(checkSignature(function, 'f3fef3a3'));
//     final params = [
//       _token,
//       _amount,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }
//
//   /// Returns a live stream of all BSBOTChangeRate events emitted by this contract.
//   Stream<BSBOTChangeRate> bSBOTChangeRateEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('BSBOTChangeRate');
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
//       return BSBOTChangeRate(decoded);
//     });
//   }
//
//   /// Returns a live stream of all BSBOTTOUSDT events emitted by this contract.
//   Stream<BSBOTTOUSDT> bSBOTTOUSDTEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('BSBOTTOUSDT');
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
//       return BSBOTTOUSDT(decoded);
//     });
//   }
//
//   /// Returns a live stream of all BSBOTTokenAddress events emitted by this contract.
//   Stream<BSBOTTokenAddress> bSBOTTokenAddressEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('BSBOTTokenAddress');
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
//       return BSBOTTokenAddress(decoded);
//     });
//   }
//
//   /// Returns a live stream of all Blacklisted events emitted by this contract.
//   Stream<Blacklisted> blacklistedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Blacklisted');
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
//       return Blacklisted(decoded);
//     });
//   }
//
//   /// Returns a live stream of all ChangeOwner events emitted by this contract.
//   Stream<ChangeOwner> changeOwnerEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('ChangeOwner');
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
//       return ChangeOwner(decoded);
//     });
//   }
//
//   /// Returns a live stream of all Paused events emitted by this contract.
//   Stream<Paused> pausedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Paused');
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
//       return Paused(decoded);
//     });
//   }
//
//   /// Returns a live stream of all RoleAdminChanged events emitted by this contract.
//   Stream<RoleAdminChanged> roleAdminChangedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('RoleAdminChanged');
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
//       return RoleAdminChanged(decoded);
//     });
//   }
//
//   /// Returns a live stream of all RoleGranted events emitted by this contract.
//   Stream<RoleGranted> roleGrantedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('RoleGranted');
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
//       return RoleGranted(decoded);
//     });
//   }
//
//   /// Returns a live stream of all RoleRevoked events emitted by this contract.
//   Stream<RoleRevoked> roleRevokedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('RoleRevoked');
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
//       return RoleRevoked(decoded);
//     });
//   }
//
//   /// Returns a live stream of all USDTChangeRate events emitted by this contract.
//   Stream<USDTChangeRate> uSDTChangeRateEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('USDTChangeRate');
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
//       return USDTChangeRate(decoded);
//     });
//   }
//
//   /// Returns a live stream of all USDTToBSBOT events emitted by this contract.
//   Stream<USDTToBSBOT> uSDTToBSBOTEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('USDTToBSBOT');
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
//       return USDTToBSBOT(decoded);
//     });
//   }
//
//   /// Returns a live stream of all USDTTokenAddress events emitted by this contract.
//   Stream<USDTTokenAddress> uSDTTokenAddressEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('USDTTokenAddress');
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
//       return USDTTokenAddress(decoded);
//     });
//   }
//
//   /// Returns a live stream of all Unpaused events emitted by this contract.
//   Stream<Unpaused> unpausedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Unpaused');
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
//       return Unpaused(decoded);
//     });
//   }
//
//   /// Returns a live stream of all Withdraw events emitted by this contract.
//   Stream<Withdraw> withdrawEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Withdraw');
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
//       return Withdraw(decoded);
//     });
//   }
// }
//
// class BSBOTChangeRate {
//   BSBOTChangeRate(List<dynamic> response)
//       : newExchangeRate = (response[0] as BigInt),
//         decimal = (response[1] as BigInt);
//
//   final BigInt newExchangeRate;
//
//   final BigInt decimal;
// }
//
// class BSBOTTOUSDT {
//   BSBOTTOUSDT(List<dynamic> response)
//       : user = (response[0] as _i1.EthereumAddress),
//         amount = (response[1] as BigInt);
//
//   final _i1.EthereumAddress user;
//
//   final BigInt amount;
// }
//
// class BSBOTTokenAddress {
//   BSBOTTokenAddress(List<dynamic> response)
//       : newAddress = (response[0] as _i1.EthereumAddress);
//
//   final _i1.EthereumAddress newAddress;
// }
//
// class Blacklisted {
//   Blacklisted(List<dynamic> response)
//       : account = (response[0] as _i1.EthereumAddress),
//         value = (response[1] as bool);
//
//   final _i1.EthereumAddress account;
//
//   final bool value;
// }
//
// class ChangeOwner {
//   ChangeOwner(List<dynamic> response)
//       : oldOwner = (response[0] as _i1.EthereumAddress),
//         newOwner = (response[1] as _i1.EthereumAddress);
//
//   final _i1.EthereumAddress oldOwner;
//
//   final _i1.EthereumAddress newOwner;
// }
//
// class Paused {
//   Paused(List<dynamic> response)
//       : account = (response[0] as _i1.EthereumAddress);
//
//   final _i1.EthereumAddress account;
// }
//
// class RoleAdminChanged {
//   RoleAdminChanged(List<dynamic> response)
//       : role = (response[0] as _i2.Uint8List),
//         previousAdminRole = (response[1] as _i2.Uint8List),
//         newAdminRole = (response[2] as _i2.Uint8List);
//
//   final _i2.Uint8List role;
//
//   final _i2.Uint8List previousAdminRole;
//
//   final _i2.Uint8List newAdminRole;
// }
//
// class RoleGranted {
//   RoleGranted(List<dynamic> response)
//       : role = (response[0] as _i2.Uint8List),
//         account = (response[1] as _i1.EthereumAddress),
//         sender = (response[2] as _i1.EthereumAddress);
//
//   final _i2.Uint8List role;
//
//   final _i1.EthereumAddress account;
//
//   final _i1.EthereumAddress sender;
// }
//
// class RoleRevoked {
//   RoleRevoked(List<dynamic> response)
//       : role = (response[0] as _i2.Uint8List),
//         account = (response[1] as _i1.EthereumAddress),
//         sender = (response[2] as _i1.EthereumAddress);
//
//   final _i2.Uint8List role;
//
//   final _i1.EthereumAddress account;
//
//   final _i1.EthereumAddress sender;
// }
//
// class USDTChangeRate {
//   USDTChangeRate(List<dynamic> response)
//       : newExchangeRate = (response[0] as BigInt),
//         decimal = (response[1] as BigInt);
//
//   final BigInt newExchangeRate;
//
//   final BigInt decimal;
// }
//
// class USDTToBSBOT {
//   USDTToBSBOT(List<dynamic> response)
//       : user = (response[0] as _i1.EthereumAddress),
//         amount = (response[1] as BigInt);
//
//   final _i1.EthereumAddress user;
//
//   final BigInt amount;
// }
//
// class USDTTokenAddress {
//   USDTTokenAddress(List<dynamic> response)
//       : newAddress = (response[0] as _i1.EthereumAddress);
//
//   final _i1.EthereumAddress newAddress;
// }
//
// class Unpaused {
//   Unpaused(List<dynamic> response)
//       : account = (response[0] as _i1.EthereumAddress);
//
//   final _i1.EthereumAddress account;
// }
//
// class Withdraw {
//   Withdraw(List<dynamic> response)
//       : to = (response[0] as _i1.EthereumAddress),
//         amount = (response[1] as BigInt);
//
//   final _i1.EthereumAddress to;
//
//   final BigInt amount;
// }
