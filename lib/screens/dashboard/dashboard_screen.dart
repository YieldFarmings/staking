import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../staking/staking_bloc.dart';
import '../swaping/bloc/swap_bloc.dart';
import '../swaping/swaping_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoardScreen> {
  late StakingBloc _stakingBloc;
  bool isConnected = false;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StakingBloc>(
        create: (BuildContext context) => _stakingBloc,
      child:Scaffold(
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
        ),
      Text(
        'BS FINANCE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 50.sp,
        ),
      ),
      Expanded(
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 230.w),
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
              width: ScreenUtil().screenWidth / 5,
          height:ScreenUtil().screenHeight / 2.1,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/eee.png'),
              Text(
                'Stake',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
      ],
        ),
    ),
      Container(
                  width: ScreenUtil().screenWidth / 5,
                  height:ScreenUtil().screenHeight / 2.1,
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/ppp.png'),
                      Text(
                        'Swap',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().screenWidth / 5,
                  height:ScreenUtil().screenHeight / 2.1,
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
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
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height:50.h,),
                      Text(
                        'COMING SOON',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                        ),
                      ),
                  Text(
                    'LENDING & BORROWING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                    ),
                  ),
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
      ),
    );
  }
}
