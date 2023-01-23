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
  final titles = ["90", "120", "180", "260"];
  final subtitles = ["25% APY", "40% APY", "55% APY", "75% APY"];
  late int tappedIndex;
  int amounts=0;
  String msg="";
  late Dialog leadDialog;
  late Dialog leadDialogs;
  late Dialog leadDialogss;
  late Dialog leadDialogsss;
  String dropdownValue = 'Bsbot';
  String dropdownValues = '30 days';
  double percentage=0.0;
  int count=0;
  double balance=0;
  final TextEditingController _amountController = TextEditingController();
  bool isVisible=false;


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
      if (state is StakingTotalBalance) {
        setState(() {
          balance=state.amount;
        });
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
                  //   if (address.isEmpty) ...[
                  //     InkWell(
                  //       onTap: () {
                  //         _stakingBloc.add(StakingConnectWallet());
                  //       },
                  //       borderRadius: BorderRadius.circular(15.r),
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: 15.w,
                  //           vertical: 15.h,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           gradient: const LinearGradient(
                  //             colors: [
                  //               Color(0xFF3C3D99),
                  //               Color(0xFF41275B),
                  //             ],
                  //           ),
                  //           borderRadius: BorderRadius.circular(30.r),
                  //         ),
                  //         child: const Center(
                  //           child: Text(
                  //             'Connect Wallet',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //   if (address.isNotEmpty) ...[
                  //     Container(
                  //       width: _screenUtil.screenWidth / 8,
                  //       height: 43.h,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(14.r),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.only(top: 5.h, bottom: 5.w),
                  //             child: CircleAvatar(
                  //               foregroundImage: NetworkImage('https://avatars.dicebear.com/api/jdenticon/${utf8.encode(address.substring(4, 12))}.png'),
                  //               backgroundColor: Colors.white,
                  //             ),
                  //           ),
                  //           FittedBox(
                  //             child: Text(
                  //               '${address.substring(0, 8)}.....${address.substring(address.length - 4, address.length)}',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 16.sp,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ]
                  ],
                ),
                SizedBox(height:0.h,),
                Padding(padding:EdgeInsets.only(left:500.w,right:50.w,top:20.h),
                child:Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth / 3.5,
                            height: ScreenUtil().screenHeight / 1.3,
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
                                          hintText:'Enter your amount',
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

                                          width: ScreenUtil().screenWidth / 16,
                                          height: ScreenUtil().screenHeight / 35,
                                          child: Card(
                                            shape: tappedIndex == index ? new RoundedRectangleBorder(side: new BorderSide(color: Colors.purpleAccent, width: 2.0), borderRadius: BorderRadius.circular(4.0)) : new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                                            color: Color(0xff373E65),
                                            child: Stack(
                                            alignment:AlignmentDirectional.center,
                                            children:[
                                              if(tappedIndex != index )
                                              Icon(
                                            Icons.lock,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                                Padding(padding:EdgeInsets.only(top:2.h),
                                                child:Text(tappedIndex == index ?
                                                  titles[index] + " " + "days":" ",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                ),
                                          Padding(padding:EdgeInsets.only(top:60.h),
                                            child:Text(tappedIndex == index ?
                                                  subtitles[index] : " ",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                  ),
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
                                          color:Color(0xFF2196F3),
                                      borderRadius: BorderRadius.circular(20.r),
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
                                           SizedBox(height:10.h),
                                           Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Choose Your assest',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                            SizedBox(height:10.h,),
                                            Container(
                                              height:ScreenUtil().screenHeight /24 ,
                                              width: ScreenUtil().screenWidth / 3.8,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color:Color(0xff373E65),
                                              ),
                                              child:Padding(padding:EdgeInsets.only(
                                                right:20.w,
                                                left:20.w,
                                              ),
                                                child:DropdownButton<String>(
                                                  dropdownColor:Color(0xff373E65),
                                                  isExpanded: true,
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  underline: SizedBox(),
                                                  // Step 3.
                                                  value: dropdownValue,
                                                  // Step 4.
                                                  items: <String>['Bsbot']
                                                      .map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child:Text(
                                                        value,
                                                        style: TextStyle(fontSize: 20,color:Colors.white),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // Step 5.
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownValue = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Choose your Pull option',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                            SizedBox(height:10.h,),
                                            Container(
                                              height:ScreenUtil().screenHeight /24 ,
                                              width: ScreenUtil().screenWidth / 3.8,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color:Color(0xff373E65),
                                              ),
                                              child:Padding(padding:EdgeInsets.only(
                                                right:20.w,
                                                left:20.w,
                                              ),
                                                child:DropdownButton<String>(
                                                  dropdownColor:Color(0xff373E65),
                                                  isExpanded: true,
                                                  alignment:AlignmentDirectional.centerEnd,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.white, // <-- SEE HERE
                                                  ),
                                                  underline: SizedBox(),
                                                  // Step 3.
                                                  value: dropdownValues,
                                                  // Step 4.
                                                  items: <String>['30 days','90 days', '120 days', '180 days','260 days']
                                                      .map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child:Text(
                                                        value,
                                                        style: TextStyle(fontSize: 20,color:Colors.white),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // Step 5.
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownValues = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(height:20.h,),
                                            Text(
                                              'Enter your amount',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                            SizedBox(height:10.h,),
                                            SizedBox(
                                              width: 495.w,
                                              height:ScreenUtil().screenHeight /24 ,
                                              child: TextField(
                                                controller:_amountController,
                                                autofocus: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration:InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled:true,
                                                  fillColor:Color(0xff373E65),
                                                  hintStyle: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height:45.h,),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isVisible=true;
                                                  if(dropdownValues=="30 days")
                                                    percentage=int.parse(_amountController.text)*10/100;
                                                  else if(dropdownValues=="90 days")
                                                    percentage=int.parse(_amountController.text)*25/100;
                                                  else if(dropdownValues=="120 days")
                                                    percentage=int.parse(_amountController.text)*40/100;
                                                  else if(dropdownValues=="180 days")
                                                    percentage=int.parse(_amountController.text)*55/100;
                                                  else if(dropdownValues=="260 days")
                                                    percentage=int.parse(_amountController.text)*75/100;
                                                });
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
                                                  borderRadius: BorderRadius.circular(15.r),
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
      ],
                                      ),

                ),
                                  ],
                                ),
    // Row(
    // mainAxisAlignment:MainAxisAlignment.spaceBetween,
    // children:[
    // Text(
    // 'Reward earned:',
    // style: TextStyle(
    // color: Colors.white,
    // ),
    // ),
    // Text(
    // '29.4 Token',
    // style: TextStyle(
    // color: Colors.white,
    // ),
    // ),
    // ],
    //
    //             ),
    //                           SizedBox(height:10.h,),
    //                             Row(
    //                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
    //                             children:[
    //                               Text(
    //                                 'Your staked amount:',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 '100 Token',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             ],
    //
    //                           ),
    //                             SizedBox(height:10.h,),
    //                             Row(
    //                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
    //                               children:[
    //                                 Text(
    //                                   'Total token staked:',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   '602 Token',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ],
    //
    //                             ),
    //                             SizedBox(height:10.h,),
    //                             Row(
    //                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
    //                               children:[
    //                                 Text(
    //                                   'Reward Percent:',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   '10%',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ],
    //
    //                             ),
    //                             SizedBox(height:10.h,),
    //                             Row(
    //                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
    //                               children:[
    //                                 Text(
    //                                   'Total Duration:',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   '2 Minutes',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ],
    //
    //                             ),
    //                             SizedBox(height:10.h,),
    //                             Row(
    //                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
    //                               children:[
    //                                 Text(
    //                                   'Pool Token:',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                                 Text(
    //                                   'xffcy',
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ],
    //
    //                             ),
    //                           ],

                ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth / 3.5,
                            height: ScreenUtil().screenHeight / 2.5,
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
child:Column(
  children:[
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
                                        color:Color(0xFF2196F3),
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
],

SizedBox(height:30.h,),
    if (address.isEmpty) ...[
            Container(
              width: ScreenUtil().screenWidth / 3.8,
              height: ScreenUtil().screenHeight / 4,
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
               color: Color(0xff373E65),
                ),
              child:Center(
              child:Text('connect Wallet to proceed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ),
    ],
    if (address.isNotEmpty) ...[
    Column(
                                  children:[
    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                  children:[
                                    Text(
                                      'Open Balance',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Total Locked',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],

                                ),
                                    SizedBox(height:10.h,),
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
    children:[
                                    Container(
                                      width: ScreenUtil().screenWidth / 9.8,
                                      height: ScreenUtil().screenHeight / 7,
                                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                                      decoration: BoxDecoration(
                                        color: Color(0xff373E65),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child:Center(
                                        child:Text('${balance}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().screenWidth / 9.8,
                                      height: ScreenUtil().screenHeight / 7,
                                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: Color(0xff373E65),
                                      ),
                                      child:Center(
                                        child:Text('100 Token',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],

                                ),
SizedBox(height:20.h,),
                                    InkWell(
                                      onTap: () {

                                      },
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 15.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color:Color(0xFF2196F3),
                                          borderRadius: BorderRadius.circular(30.r),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '90 Days - 100 Tokens',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:10.h,),
                                    Divider(
    color:Color(0xff373E65),

                                    ),
                                    Padding(padding:EdgeInsets.only(right:300.w),
                                    child:Text(
                                      'Transactions History',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    ),


                                    


    ],
    ),
                          ],
      ],
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
              color:Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(15.r),
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
              color:Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(15.r),
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
  Widget text(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Text('${_amountController.text} bsbot + ${percentage} xbsbot',style: TextStyle(color: Colors.white)),
      ],
    );
  }
}