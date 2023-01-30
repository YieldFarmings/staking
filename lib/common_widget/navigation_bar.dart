import 'package:bsbot/screens/calculator/calculator_screen.dart';
import 'package:bsbot/screens/staking/staking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/swaping/swaping_screen.dart';
import '../walletconnect/connect_wallet.dart';

class NavigationBarTab extends StatefulWidget {


  @override
  State<NavigationBarTab> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarTab> {
  int _selectedIndex = 0;
  final ScreenUtil _screenUtil = ScreenUtil();
  late int tappedIndex;
  final titles = ['Dashboard', 'Swapping', 'Staking', 'Calculator'];
  static const _pages = <Widget>[
    DashBoardScreen(),
    SwapScreen(),
    StakingScreen(),
    CalculatorScreen(),
  ];



  void initState() {
    tappedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SingleChildScrollView(
      child:Column(
        children: [
      Stack(
      children: [
        Container(
          width: _screenUtil.screenWidth,
          height: _screenUtil.screenHeight / 13,
          color: Color(0xff2879FF),
          child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:titles.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
    tappedIndex = index;

    }
                    );
                        },
                  child:SizedBox(width:200.w,
                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children:[
                        SizedBox(width:30.w,),
                    InkWell(
                        child:Text(
                          titles[index],
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: tappedIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                    ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
        Center(
          child:Padding(padding:EdgeInsets.only(left:1500.w,top:20.h),
            child:Container(
              alignment:AlignmentDirectional.center,
              width: _screenUtil.screenWidth/13,
              child: InkWell(
                onTap: () {

                },
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color:Color(0xff1C4995),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child:Center(
                    child: Text(
                      ConnectWalletScreen().isConnected==true ? 'Connect Wallet':'Connected',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
            Container(
              width: _screenUtil.screenWidth,
              height: _screenUtil.screenHeight,
            child:_pages.elementAt(tappedIndex),
            ),
    ],
    ),
    ),
    );
  }
}
