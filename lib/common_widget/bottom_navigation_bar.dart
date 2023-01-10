import 'package:bsbot/screens/staking/staking_screen.dart';
import 'package:bsbot/screens/swaping/swaping_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/calculator/calculator_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

class BottomNaviagtionBar extends StatefulWidget {
  const BottomNaviagtionBar({Key? key}) : super(key: key);

  @override
  State<BottomNaviagtionBar> createState() => _BottomNaviagtionBarState();
}

class _BottomNaviagtionBarState extends State<BottomNaviagtionBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const _pages = <Widget>[
    DashBoardScreen(),
    StakingScreen(),
    SwapScreen(),
    CalculatorScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000222),
    body:Center(
        child: _pages.elementAt(_selectedIndex),
    ),
      bottomNavigationBar:Padding(
        padding: EdgeInsets.only(left: 700.w,right:700.w,bottom:20.h),
        child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0), topLeft: Radius.circular(0)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      label:'Dashboard',
                      icon: Icon(Icons.dashboard)),
                  BottomNavigationBarItem(
                      label:'Staking',
                      icon: Icon(Icons.swap_calls)),
                  BottomNavigationBarItem(
                      label:'Swap',
                      icon:ImageIcon(
                      AssetImage("images/swaping.png"),
                      ),
                  ),
                  BottomNavigationBarItem(
                      label:'Calculator',
                      icon: Icon(Icons.percent))
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
                backgroundColor:Color(0xff999EF9),
              ),
            )
        ),
      ),
    );
  }
}
