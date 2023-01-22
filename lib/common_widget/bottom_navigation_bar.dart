import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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

class _BottomNaviagtionBarState extends State<BottomNaviagtionBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _bodyView = <Widget>[
    StakingScreen(),
    SwapScreen(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync:this,length: 2);
  }


  final List<String> _labels = ['Stake', 'Swap'];


  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
        margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        decoration: !isSelected
            ? null
            : BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            child,
            Text(label, style: TextStyle(fontSize:11.sp)),
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = const [
      Icon(Icons.stacked_line_chart_sharp,size:22,),
      Icon(Icons.swap_horiz,size:22,),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF000222),
    body:Center(
        child: _bodyView.elementAt(_selectedIndex),
    ),

      bottomNavigationBar:Padding(
    padding: EdgeInsets.only(left: 820.w,right:820.w,bottom:10.h),
      child:Container(
    height: 100,
    padding: const EdgeInsets.all(12),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
    color: Color(0xff999EF9),
              child:TabBar(
                  onTap: (x) {
                    setState(() {
                      _selectedIndex = x;
                    });
                  },
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                  ),
                  tabs: [
                    for (int i = 0; i < _icons.length; i++)
                      _tabItem(
                        _icons[i],
                        _labels[i],
                        isSelected: i == _selectedIndex,
                      ),
                  ],
                  controller: _tabController),
            ),
        ),
      ),
      ),
    );
  }
}
