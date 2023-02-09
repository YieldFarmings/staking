import 'package:bsbot/screens/calculator/calculator_screen.dart';
import 'package:bsbot/screens/staking/staking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../screens/dashboard/dashboard_screen.dart';
import '../screens/dashboard/new_dashboard.dart';
import '../screens/staking/staking_bloc.dart';
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
  final titles = ['Staking', 'Swapping', 'Calculator'];
  late StakingBloc _stakingBloc;
  final _pages = <Widget>[
    StakingScreen(),
    SwapScreen(),
    CalculatorScreen(),
  ];



  void initState() {
    tappedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    body:SingleChildScrollView(
      child:
      Column(
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
                            fontFamily:'Gilroy',
                            fontSize:15,
                            color: tappedIndex == index ? Colors.white :Color(0xffA6C8FF),
                          ),
                        ),

                    )
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
        Padding(padding:EdgeInsets.only(left:40.w,top:10.h,bottom:10.h),
        child:Image.asset('assets/images/bsbot_logo.png',height:60.h,),
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
