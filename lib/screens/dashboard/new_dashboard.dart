import 'package:bsbot/screens/dashboard/dashboard_screen.dart';
import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:bsbot/screens/staking/staking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';



class DashBoardScreen extends StatefulWidget {

  DashBoardScreen({Key? key}) : super(key: key);

  String address = '';
  bool isConnected = false;

  @override
  State<DashBoardScreen> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<DashBoardScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDCE9FF),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ],
              ),
              SizedBox(height:400.h,),
              Center(
                child:Column(
                  children: [
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize:40.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}