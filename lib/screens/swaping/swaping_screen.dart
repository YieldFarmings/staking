import 'dart:convert';
import 'dart:math';

import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:bsbot/screens/swaping/bloc/swap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widget/navigation_bar.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  bool previewSuccess = false;
  bool usdtTobsbot = false;
  final ScreenUtil _screenUtil = ScreenUtil();
  late StakingBloc _stakingBloc;
  late SwapBloc _swapBloc;
  final TextEditingController _bsbotController = TextEditingController();
  final TextEditingController _usdtController = TextEditingController();
  String address = '';
  bool isConnected = false;


  @override
  void initState() {
    _swapBloc = SwapBloc(
      swapRepository: context.read(),
    )..add(SwapCheck());

    _swapBloc.stream.listen((state) {
      if (state is SwapConnected) {
        setState(() {
          address = state.address;
          isConnected = true;
        });
      }

      if (state is SwapPreviewSuccess) {
        _usdtController.text = state.previewAmount.toString();
      }

      if (state is SwapSuccess) {
        _usdtController.text = '';
        _bsbotController.text = '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }

      if (state is SwapError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is SwapLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
    });

    _bsbotController.addListener(() {
      if (_bsbotController.text.isNotEmpty) {
        _swapBloc.add(SwapPreview(amount: double.parse(_bsbotController.text), from: usdtTobsbot ? 'usdt' : 'bsbot'));
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwapBloc>(
      create: (BuildContext context) => _swapBloc,
      child: Scaffold(
        backgroundColor: const Color(0xffDCE9FF),
        body: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
                Expanded(
                  child: Center(
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Swapping',
                        style: TextStyle(
                          fontFamily:'Gilroy',
                          color: Colors.black,
                          fontSize: 50.sp,
                        ),
                      ),
                      SizedBox(height:30.h,),
                      Container(
                        width: ScreenUtil().screenWidth / 3.5,
                        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                         color:Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Swap',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    Text(
                                      'Trade tokens in an instant',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You Sell',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: usdtTobsbot ? const AssetImage('assets/images/usdt_logo.png') : const AssetImage('assets/images/bsbot_logo.png'),
                                            radius: 20.r,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            usdtTobsbot ? 'USDT' : 'BSBOT',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 295.w,
                                        child: TextField(
                                          controller: _bsbotController,
                                          autofocus: true,
                                          enabled: isConnected,
                                          textAlign: TextAlign.end,
                                          cursorColor: Colors.black,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '0.0',
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      usdtTobsbot = !usdtTobsbot;
                                      _bsbotController.text = '';
                                      _usdtController.text = '';
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:Color(0XFFF4F4F4),
                                    radius: 25.r,
                                    child: Transform.rotate(
                                      angle: pi / 2,
                                      child: Image.asset(
                                        'assets/images/ic_exchange.png',
                                        color: Colors.black,
                                        scale: 5,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Color(0XFFF4F4F4),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You Get',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: usdtTobsbot ? const AssetImage('assets/images/bsbot_logo.png') : const AssetImage('assets/images/usdt_logo.png'),
                                            radius: 20.r,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            usdtTobsbot ? 'BSBOT' : 'USDT',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 295.w,
                                        child: TextField(
                                          controller: _usdtController,
                                          autofocus: true,
                                          enabled: false,
                                          textAlign: TextAlign.end,
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '0.0',
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            InkWell(
                              onTap: () {
                                if (_bsbotController.text.isNotEmpty) {
                                  if ((double.tryParse(_bsbotController.text) ?? 0) > 0) {
                                    _swapBloc.add(SwapAmount(amount: double.parse(_bsbotController.text), from: usdtTobsbot ? 'usdt' : 'bsbot'));
                                  }
                                }
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                decoration: BoxDecoration(
                                  color:Color(0xff2879FF),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: const Center(
                                  child: Text(
                                    'SWAP',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height:20.h,),
                            if (address.isEmpty) ...[
                              InkWell(
                                onTap: () {
                                  _swapBloc.add(SwapConnectWallet());
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 15.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color:Color(0xff2879FF),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Connect Wallet',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (address.isNotEmpty) ...[
                              Container(
                                width: _screenUtil.screenWidth / 2,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:Color(0xff2879FF),
                                  ),
                                  color:Color(0xff2879FF),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.h, bottom: 5.w,left:150.w),
                                      child: CircleAvatar(
                                        foregroundImage: NetworkImage('https://avatars.dicebear.com/api/jdenticon/${utf8.encode(address.substring(4, 12))}.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        '${address.substring(0, 8)}.....${address.substring(address.length - 4, address.length)}',
                                        style: TextStyle(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                ),
              ],
            ),
          ),
    );
  }
}
