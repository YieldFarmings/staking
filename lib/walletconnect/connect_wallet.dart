import 'package:bsbot/screens/dashboard/dashboard_screen.dart';
import 'package:bsbot/screens/staking/staking_bloc.dart';
import 'package:bsbot/screens/staking/staking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../common_widget/navigation_bar.dart';
import 'bloc/connect_wallet_bloc.dart';


class ConnectWalletScreen extends StatefulWidget {
  String address = '';
  bool isConnected = false;

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWalletScreen> {


  late WalletBloc _walletBloc;


  @override
  void initState() {

    _walletBloc = WalletBloc(
          walletRepository: context.read(),
    );

  _walletBloc.stream.listen((state) {
    if (state is WalletConnected) {
      setState(() {
        widget.address = state.address;
        widget.isConnected = true;
      });
    }
  },
  );
      }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (BuildContext context) => _walletBloc,
      child: Scaffold(
        backgroundColor: const Color(0xffDCE9FF),
        body: Padding(
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
                  ],
                ),
                SizedBox(height:400.h,),
                Center(
                  child:Column(
                    children: [
                  Text(
                    'Start Staking to See Transaction',
                    style: TextStyle(
                      fontSize:40.sp,
                      color: Colors.white,
                    ),
                  ),

                  ],
    ),
      ),
      ],
      ),
    ),
      ),
    );
  }
}