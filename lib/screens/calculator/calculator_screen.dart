import 'dart:convert';
import 'dart:math';

import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:bsbot/screens/swaping/bloc/swap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widget/navigation_bar.dart';

class  CalculatorScreen extends StatefulWidget {
  const  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State< CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  String dropdownValue = 'Bsbot';
  String dropdownValues = '30 days';
  double percentage=0.0;
  bool isConnected = false;
  final TextEditingController _amountController = TextEditingController();
  bool isVisible=false;


  // @override
  // void initState() {
  //   _stakingBloc = StakingBloc(
  //     stakingRepository: context.read(),
  //   )..add(StakingCheck());
  //
  //   _stakingBloc.stream.listen((state) {
  //     if (state is StakingConnected) {
  //       setState(() {
  //         address = state.address;
  //         isConnected = true;
  //       });
  //     }
  //
  //     if (state is StakingPreviewSuccess) {
  //       _usdtController.text = state.previewAmount.toString();
  //     }
  //
  //     if (state is StakingSuccess) {
  //       _usdtController.text = '';
  //       _bsbotController.text = '';
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
  //     }
  //
  //     if (state is StakingError) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
  //     }
  //
  //     if (state is StakingLoading) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
  //     }
  //   });
  //
  //   _bsbotController.addListener(() {
  //     if (_bsbotController.text.isNotEmpty) {
  //       _swapBloc.add(SwapPreview(amount: double.parse(_bsbotController.text), from: usdtTobsbot ? 'usdt' : 'bsbot'));
  //     }
  //   });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffDCE9FF),
        body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 130.h),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children:[
       Text(
              'Calculator',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50.sp,
              ),
            ),

            Expanded(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: ScreenUtil().screenWidth / 3.5,
                    height:ScreenUtil().screenHeight / 1.9,
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color:Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Choose Your assest',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 18.sp,
                        //   ),
                        // ),
                        // SizedBox(height:10.h,),
                        // Container(
                        //   width: ScreenUtil().screenWidth / 3.8,
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color:Color(0xffF4F4F4),
                        //   ),
                        //   child:Padding(padding:EdgeInsets.only(
                        //     right:20.w,
                        //     left:20.w,
                        //   ),
                        //     child:TextField(
                        //       enabled:false,
                        //       autofocus: true,
                        //       textAlign: TextAlign.start,
                        //       cursorColor: Colors.black,
                        //       style: const TextStyle(
                        //         color: Colors.black,
                        //       ),
                        //       decoration:InputDecoration(
                        //         filled:true,
                        //         fillColor:Color(0xffF4F4F4),
                        //         hintStyle: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height:10.h,),
                        Padding(padding:EdgeInsets.only(left:10.w),
                        child:Text(
                          'Choose your Pull option :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        ),
                        SizedBox(height:15.h,),
                        // Container(
                        //   width: ScreenUtil().screenWidth / 3.8,
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color:Color(0xffF4F4F4),
                        //   ),
                          SizedBox(
                            width: 495.w,
                            child:TextField(
                              enabled:false,
                              autofocus: true,
                              textAlign: TextAlign.start,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:InputDecoration(
                                hintText:'90 days',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled:true,
                                fillColor:Color(0xffF4F4F4),
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        SizedBox(height:80.h,),
                        Padding(padding:EdgeInsets.only(left:10.w),
                            child: Text(
                          'Enter your amount :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        ),
                        SizedBox(height:15.h,),
                        SizedBox(
                          width: 495.w,
                          child: TextField(
                            controller:_amountController,
                            autofocus: true,
                            textAlign: TextAlign.start,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration:InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled:true,
                              fillColor:Color(0xffF4F4F4),
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height:60.h,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isVisible=true;
                                percentage=int.parse(_amountController.text)*25/100;
                            });
                          },
                          borderRadius: BorderRadius.circular(5.r),
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
                                'Calculate',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:20.h,),
                        if(isVisible==true && _amountController.text.isNotEmpty && dropdownValues.isNotEmpty)
                          text(),
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
  Widget text(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Text('${_amountController.text} bsbot + ${percentage} xbsbot',style: TextStyle(color: Colors.black)),
      ],
    );
  }
}




