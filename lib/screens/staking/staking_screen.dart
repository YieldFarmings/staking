import 'dart:convert';

import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StakingScreen extends StatefulWidget {
  const StakingScreen({Key? key}) : super(key: key);

  @override
  State<StakingScreen> createState() => _StakingState();
}

class _StakingState extends State<StakingScreen> {
  late StakingBloc _stakingBloc;
  String address = '';
  bool isConnected = false;
  bool selected = false;
  String connect = "Connect Wallet";
  final ScreenUtil _screenUtil = ScreenUtil();
  final stakingAddress = ['0x3AcB17FE5380B58c1D9edF82469288059A745c01','0xda7b3B56A4549e824487179ebfb97738Dcb50e74','0x50a8c3283289648E1Bf26d05f1DA8F7499E816BB','0x5BFFE04370BEc5B6c62615d91FC3E55d9EC88527','0x561A858AD3Ad7BBBA515e41DDbB0af56124ecefF'];
  final titles = ["30", "90", "120", "180", "260"];
  final subtitles = ["10", "25", "40", "55", "75"];
  late int tappedIndex;
  int amounts=0;
  String msg="";
  late Dialog leadDialog;
  late Dialog leadDialogs;
  late Dialog leadDialogss;



  final TextEditingController _bsbotController = TextEditingController();
  @override
  void initState() {
    tappedIndex = 0;
    _stakingBloc = StakingBloc(
      stakingRepository: context.read(),
    )..add(StakingCheck());

    _stakingBloc.stream.listen((state) {
      if (state is StakingConnected) {
        setState(() {
          address = state.address;
          isConnected = true;
        });
      }
      if (state is StakingPreviewSuccess) {
        _bsbotController.text = state.previewAmount.toString();
      }
      if (state is StakingSuccess) {
        setState(() {
          selected=true;
          msg=state.msg;
        });
        textf();
        showDialog(
            context: context,
            builder: (
                BuildContext context) => leadDialog);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
      if (state is UnStakingSuccess) {
        setState(() {
          msg=state.msg;
        });
        showDialog(
            context: context,
            builder: (
                BuildContext context) => leadDialogs);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
      if (state is ClaimSuccess) {
        setState(() {
          msg=state.msg;
        });
        showDialog(
            context: context,
            builder: (
                BuildContext context) => leadDialogss);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
      if (state is StakingError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
      }

      if (state is StakingLoading) {
        setState(() {
          msg=state.msg;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
      if (state is StakingStatus) {
        amounts = state.previewAmount;
      }
    });
    _bsbotController.addListener(() {
      if (_bsbotController.text.isNotEmpty) {
        _stakingBloc.add(StakingPreview(amount: double.parse(_bsbotController.text), from: 'bsbot'));
      }
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    leadDialog = Dialog(
      child: Container(
        height: 200.0,
        width: 360.0,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Staking Successfull',
                style:
                TextStyle(color: Colors.black, fontSize: 22.0),
              ),
            ),
            TextButton(onPressed:(){
              Navigator.of(context).pop();

            }, child:Text('Close',style:TextStyle(color:Colors.white,fontSize:20),))
          ],
        ),
      ),
    );
    leadDialogs = Dialog(
      child: Container(
        height: 200.0,
        width: 360.0,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('UnStaking Successfull',
                style:
                TextStyle(color: Colors.black, fontSize: 22.0),
              ),
            ),
            TextButton(onPressed:(){
              Navigator.of(context).pop();

            }, child:Text('Close',style:TextStyle(color:Colors.white,fontSize:20),))
          ],
        ),
      ),
    );
    leadDialogss = Dialog(
      child: Container(
        height: 200.0,
        width: 360.0,
        color: Colors.purpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('claim Successfull',
                style:
                TextStyle(color: Colors.black, fontSize: 22.0),
              ),
            ),
            TextButton(onPressed:(){
              Navigator.of(context).pop();

            }, child:Text('Close',style:TextStyle(color:Colors.white,fontSize:20),))
          ],
        ),
      ),
    );
    return BlocProvider<StakingBloc>(
      create: (BuildContext context) => _stakingBloc,
      lazy:false,
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
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
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
                    if (address.isNotEmpty) ...[
                      Container(
                        width: _screenUtil.screenWidth / 8,
                        height: 43.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.w),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage('https://avatars.dicebear.com/api/jdenticon/${utf8.encode(address.substring(4, 12))}.png'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                '${address.substring(0, 8)}.....${address.substring(address.length - 4, address.length)}',
                                style: TextStyle(
                                  color: Colors.white,
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
                Container(
                    width: 450.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF246740),
                          Color(0xFF1C696B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Text('TOTAL VALUE LOCKED', style: TextStyle(color: Colors.white, fontSize: 30.sp)),
                        Text('\$342678', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                        Text('1 BSBOT = 10 XBSBOT', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text('LOCKED STACKING ', style: TextStyle(color: Colors.white, fontSize: 40.sp)),
                SizedBox(
                  height: 10,
                ),
                Text('Total in Locked staking ', style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                Text('883,953  BSBOT', style: TextStyle(color: Color(0xFF89D0F3), fontSize: 15.sp)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth / 3.5,
                            height: ScreenUtil().screenHeight / 2,
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
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Text(
                                    'My balance :0.00 BSBOT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(0),
                                      child: Container(
                                        height: 57,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 15.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                          ),
                                          color: Color(0xff373E65),
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
                                      child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                    },
                                        controller: _bsbotController,
                                        textAlign: TextAlign.start,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xff373E65),
                                          hintStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(0),
                                      child: Container(
                                        height: 57,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 15.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          ),
                                          color: Color(0xff373E65),
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
                                Padding(
                                  padding: EdgeInsets.only(right: 360.w, top: 20.h),
                                  child: Text(
                                    'Locking Time',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: titles.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            tappedIndex = index;
                                            selected=false;
                                          });
                                        },
                                        child: Container(
                                          width: ScreenUtil().screenWidth / 20,
                                          height: ScreenUtil().screenHeight / 35,
                                          child: Card(
                                            shape: tappedIndex == index ? new RoundedRectangleBorder(side: new BorderSide(color: Colors.purpleAccent, width: 2.0), borderRadius: BorderRadius.circular(4.0)) : new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                                            color: Color(0xff373E65),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  titles[index] + " " + "days",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  subtitles[index] + "%",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if(msg=="Transaction Succeed with hash") {
                                      setState(() {
                                        selected=true;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (
                                          BuildContext context)
                                      =>
                                      leadDialog
                                    );
                                    }
                                    if (_bsbotController.text.isNotEmpty) {
                                      if ((double.tryParse(_bsbotController.text) ?? 0) > 0) {
                                        _stakingBloc.add(StakingAmount(amount: double.parse(_bsbotController.text), poolAddress: stakingAddress[tappedIndex],from:"Staking"));
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
                                    child:Center(
                                      child: Text('Stake',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height:20.h,),
                                if(selected==true)
                                  textf(),
                                if(selected==false)
                                  Container(),
                              ],

                ),

            ),
          ],
                ),
          ),
    ],
    ),
    ],
      ),
    ),
    ),
      ),
    );
  }
  Widget textf(){
    return  Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children:[
        InkWell(
          onTap: () {

            if (_bsbotController.text.isNotEmpty) {
              if ((double.tryParse(_bsbotController.text) ?? 0) > 0) {
                _stakingBloc.add(StakingAmount(amount: double.parse(_bsbotController.text), poolAddress: stakingAddress[tappedIndex],from:"claim"));
              }
            }

          },
          borderRadius: BorderRadius.circular(5.r),
          child: Container(
            width: ScreenUtil().screenWidth / 10,
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
                'Claim',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {

            if (_bsbotController.text.isNotEmpty) {
              if ((double.tryParse(_bsbotController.text) ?? 0) > 0) {
                _stakingBloc.add(StakingAmount(amount: double.parse(_bsbotController.text), poolAddress: stakingAddress[tappedIndex],from:"unstaking"));
              }
            }
          },
          borderRadius: BorderRadius.circular(5.r),
          child: Container(
            width: ScreenUtil().screenWidth / 10,
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
                'UnStake',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}