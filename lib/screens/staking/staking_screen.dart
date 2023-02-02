import 'dart:convert';

import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Repositories/staking_repository.dart';
import '../../Services/staking_service.dart';

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
  final stakingAddress = ['0xda7b3B56A4549e824487179ebfb97738Dcb50e74'];
  final titles = ["90"];
  final subtitles = ["25"];
  late int tappedIndex;
  int amounts=0;
  String msg="";
  int count=0;
  late Dialog leadDialog;
  late Dialog leadDialogs;
  late Dialog leadDialogss;
  late Dialog leadDialogsss;


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
    leadDialogsss = Dialog(
      child: Container(
        height: 200.0,
        width: 360.0,
        color: Colors.purpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('PLease Enter Amount',
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
      child: Scaffold(
        backgroundColor: const Color(0xffDCE9FF),
        body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 100.h),
    child:Column(
    mainAxisAlignment:MainAxisAlignment.center,
    crossAxisAlignment:CrossAxisAlignment.center,
    children:[
    Text(
    'Staking',
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
    height:ScreenUtil().screenHeight / 1.6,
    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.r),
    color:Colors.white,
    ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'STAKE BSBOT',
                                  style: TextStyle(
                                    color: Color(0xff9B9B9B),
                                    fontSize: 20.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    // InkWell(
                                    //   onTap: () {},
                                    //   borderRadius: BorderRadius.circular(0),
                                    //   child: Container(
                                    //     height: 57,
                                    //     padding: EdgeInsets.symmetric(
                                    //       horizontal: 15.w,
                                    //       vertical: 15.h,
                                    //     ),
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(6),
                                    //         bottomLeft: Radius.circular(6),
                                    //       ),
                                    //       color: Color(0xff373E65),
                                    //     ),
                                    //     child: const Center(
                                    //       child: Text(
                                    //         'BSBOT',
                                    //         style: TextStyle(
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                    },
                                        controller: _bsbotController,
                                        textAlign: TextAlign.start,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xffF4F4F4),
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
                                          color:Color(0xff2879FF),
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
                               Container(
                                 height:150.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: titles.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          width:500.w,
                                          height:10.h,
                                          child: Card(
                                           // shape: tappedIndex == index ? new RoundedRectangleBorder(side: new BorderSide(color: Colors.purpleAccent, width: 2.0), borderRadius: BorderRadius.circular(4.0)) : new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                                            color: Color(0xffF4F4F4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  titles[index] + " " + "days  - ",
                                                  style: TextStyle(
                                                    fontSize: 22.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width:20.w,),
                                                Text(
                                                  subtitles[index] + "% APR",
                                                  style: TextStyle(
                                                    fontSize: 22.sp,
                                                    color: Colors.black,
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
                                  height: 40.h,
                                ),
        if (address.isNotEmpty) ...[
                                InkWell(
                                  onTap: () {
                                      if(msg=="Transaction Succeed with hash") {
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
                                        _stakingBloc.add(StakingAmount(amount: double.parse(_bsbotController.text)));
                                      }
                                    }
                                    else if(_bsbotController.text.isEmpty){
                                      showDialog(
                                          context: context,
                                          builder: (
                                              BuildContext context)
                                          =>
                                          leadDialogsss
                                      );
                                    }

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
                                    child:Center(
                                       child:Text('Stake',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
      ],
      SizedBox(height:30.h,),
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
              height: 43.h,
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
      ),
    );
  }
}