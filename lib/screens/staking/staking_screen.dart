import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../swaping/bloc/swap_bloc.dart';
import '../swaping/swaping_screen.dart';

class StakingScreen extends StatefulWidget {
  const StakingScreen({Key? key}) : super(key: key);

  @override
  State<StakingScreen> createState() => _StakingState();
}

class _StakingState extends State<StakingScreen> {
  late StakingBloc _stakingBloc;
  String address = '';
  bool isConnected = false;
  final titles = ["30", "90", "120","180","260"];
  final subtitles = ["10", "25", "40", "55", "75"];
  final TextEditingController _bsbotController = TextEditingController();
  @override
  void initState() {
    _stakingBloc = StakingBloc(
      stakingRepository: context.read(),
    )
      ..add(StakingCheck());

    _stakingBloc.stream.listen((state) {
      if (state is StakingConnected) {
        setState(() {
          isConnected = true;
        });
      }
      if (state is StakingPreviewSuccess) {
        _bsbotController.text = state.previewAmount.toString();
      }
      if (state is StakingError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is StakingLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
      if (state is StakingTotalBalance) {
        _bsbotController.text = state.amount.toString();
      }
    }
    );
    _bsbotController.addListener(() {
      if (_bsbotController.text.isNotEmpty) {
        _stakingBloc.add(StakingPreview(amount: double.parse(_bsbotController.text), from: 'bsbot'));
      }
    });
  }

      @override
  Widget build(BuildContext context) {
    return BlocProvider<StakingBloc>(
      create: (BuildContext context) => _stakingBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFF000222),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.centerLeft,
              radius: 0.7.r,
              colors: const [
                Color(0xFF102340),
                Color(0xFF000222),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/bsbot_logo.png',
                      scale: 3,
                    ),
              if (address.isEmpty) ...[
                    InkWell(
                      onTap: () {
                        _stakingBloc.add(StakingConnectWallet());
                      },
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF3C3D99),
                              Color(0xFF41275B),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30.r),
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
                ],
                ),
                Container(
                  width:450.w,
                  height:160.h,
                  decoration:BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF246740),
                          Color(0xFF1C696B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height:2.h,),
                      Text('TOTAL VALUE LOCKED', style: TextStyle(
                    color: Colors.white,fontSize:30.sp)),
                      Text('3,00000',style: TextStyle(
                        color: Colors.white, fontSize:15.sp)),
                      Text('3=1 BSBOT',style: TextStyle(
                          color: Colors.white,fontSize:15.sp)),
                      SizedBox(height:10.h,),
                    ],
                  )
                ),
                SizedBox(height:10.h,),

                Text('LOCKED STACKING ',style: TextStyle(
                    color: Colors.white,fontSize:40.sp)),
                SizedBox(height:10,),
                Text('Total in Locked staking ',style: TextStyle(
                    color: Colors.white,fontSize:20.sp)),
                Text('100000 BSBOT',style: TextStyle(
                    color:Color(0xFF89D0F3),fontSize:15.sp)),
              Expanded(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
              width: ScreenUtil().screenWidth / 3.5,
          height:ScreenUtil().screenHeight / 2,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF162035),
                Color(0xFF162035).withOpacity(0.5),
                Color(0xFF000222),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'STAKE BSBOT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height:20.h,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('Amount', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),),
                  Text('My balance :bsbot',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),),
                ]
              ),
                SizedBox(height:10.h,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        height:57,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                          color:Color(0xff373E65),
                        ),
                        child: const Center(
                          child: Text(
                            'BSBOT',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                              child: TextField(
                                controller: _bsbotController,
                                textAlign: TextAlign.start,
                                cursorColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration:InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  filled:true,
                                  fillColor:Color(0xff373E65),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                    InkWell(
                      onTap: () {
                      },
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        height:57,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        color:Color(0xff373E65),
                        ),
                        child: const Center(
                          child: Text(
                            'Max',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                          ],
                        ),
              Padding(padding:EdgeInsets.only(right:360.w,top:20.h),
              child:Text(
                'Locking Time',
                textAlign:TextAlign.left,
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),),),
              SizedBox(height:10.h,),
                Expanded(
              child:ListView.builder(
                scrollDirection:Axis.horizontal,
                itemCount:titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return  InkWell(
                      onTap: () {
                  },
                    child:Container(
                      width:ScreenUtil().screenWidth / 16,
                  height:ScreenUtil().screenHeight / 20,
                    child:Card(
                      color:Color(0xff373E65),
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text(titles[index]+" "+"days", style: TextStyle(
                          color: Colors.white,
                        ),),
                        Text(subtitles[index]+"%", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ],
                    ),
                    ),
                    ),
                    );
                },
              ),
                ),
              SizedBox(height:105.h,),
              InkWell(
                onTap: () {
                  if (_bsbotController.text.isNotEmpty) {
                    if ((double.tryParse(_bsbotController.text) ?? 0) > 0) {
                      _stakingBloc.add(StakingAmount(amount: double.parse(_bsbotController.text), from:'bsbot'));
                    }
                  }
                },
                borderRadius: BorderRadius.circular(5.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3C3D99),
                        Color(0xFF41275B),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Enable Staking',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

            ],
              ),
          ),
    ],
    ),
              ),
    ],
    ),
      ),
      ),
      ),
    );
  }
}
