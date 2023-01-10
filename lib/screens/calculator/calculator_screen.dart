import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../swaping/bloc/swap_bloc.dart';
import '../swaping/swaping_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatingState();
}

class _CalculatingState extends State<CalculatorScreen> {
  late SwapBloc _swapBloc;
  String dropdownValue = 'Bsbot';
  String dropdownValues = '30 days';
  bool isConnected = false;


  @override
  void initState() {
    _swapBloc = SwapBloc(
      swapRepository: context.read(),
    )
      ..add(SwapCheck());

    _swapBloc.stream.listen((state) {
      if (state is SwapConnected) {
        setState(() {
          isConnected = true;
        });
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwapBloc>(
      create: (BuildContext context) => _swapBloc,
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
                        _swapBloc.add(SwapConnectWallet());
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
                  'CALCULATE YOUR EARNINGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.sp,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenUtil().screenWidth / 3.5,
                        height:ScreenUtil().screenHeight / 1.8,
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
                                value: dropdownValue,
                                // Step 4.
                                items: <String>['Bsbot', 'IBAT', 'BNB', 'CAKE']
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
                            SizedBox(height:40.h,),
                            Text(
                              'Choose your Pull option',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height:10.h,),
                            Container(
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
                                  items: <String>['30 days', '20 days', '10 days', '5 days']
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
                            SizedBox(height:40.h,),
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
                          child: TextField(
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
                              borderRadius: BorderRadius.circular(5.r),
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
}