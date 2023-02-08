import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../screens/calculator/calculator_screen.dart';
import '../screens/calculator/calculator_screen_mobile.dart';
import '../screens/staking/staking_bloc.dart';
import '../screens/staking/staking_screen.dart';
import '../screens/staking/staking_screen_mobile.dart';
import '../screens/swaping/bloc/swapping_screen_mobile.dart';
import '../screens/swaping/swaping_screen.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawerState();
}

class _DrawerState extends State<Drawers> {
  late StakingBloc _stakingBloc;
  String address = '';
  bool isConnected = false;
  bool selected = false;
  String connect = "Connect Wallet";
  final ScreenUtil _screenUtil = ScreenUtil();
  final stakingAddress = ['0xda7b3B56A4549e824487179ebfb97738Dcb50e74'];
  final titles = ["90"];
  final titless = ['Staking', 'Swapping', 'Calculator'];
  final subtitles = ["25"];
  late int tappedIndex;
  int amounts=0;
  String msg="";
  int count=0;
  late Dialog leadDialog;
  late Dialog leadDialogs;
  late Dialog leadDialogss;
  late Dialog leadDialogsss;
  double balance=0;
  final _pages = <Widget>[
    StakingScreenMobile(),
    SwapScreenMobile(),
    CalculatorScreenMobile(),
  ];


  void initState() {
    tappedIndex = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle:true,
        ),
        drawer:Drawer(
          child:Padding(padding:EdgeInsets.only(top:250.h,left:200.w),
    child:
          ListView.builder(
    itemCount:titless.length,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          setState(() {
            tappedIndex = index;
          }
          );
        },
       child:Column(
         crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Text(
                  titless[index],
                  style: TextStyle(
                    fontSize: 30,
                    color: tappedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height:30.h,),
            ],
          ),
        );
    }
          ),
          ),
        ),
      body: Container(
        width: _screenUtil.screenWidth,
        height: _screenUtil.screenHeight,
        child:_pages.elementAt(tappedIndex),
      ),

    );
  }
}


