import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../staking/staking_bloc.dart';
import '../staking/staking_screen.dart';
import '../swaping/bloc/swap_bloc.dart';
import '../swaping/swaping_screen.dart';
import '../../common_widget/navigation_bar.dart';



class DashBoardScreen extends StatefulWidget {

  const DashBoardScreen({Key? key}) : super(key: key);


  @override
  State<DashBoardScreen> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoardScreen> {
  bool isConnected = false;
  final ScreenUtil _screenUtil = ScreenUtil();
  late int tappedIndex;
  final titles = ['Dashboard', 'Swapping', 'Staking', 'Calculator'];
  final cardTitles=['Open Balance','Total Locked','Locked Staking'];
  final cardSubTitles=['\$24661.26212','\$24661.26212','90 Days - 100 Tokens'];
  @override
  void initState() {
    tappedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDCE9FF),
      body:Column(
        mainAxisAlignment:MainAxisAlignment.start,
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Padding(padding:EdgeInsets.symmetric(
          horizontal: 80.w,
          vertical: 80.h,
        ),
        child:Container(
          width: _screenUtil.screenWidth,
          height: _screenUtil.screenHeight/1.4,
    child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,
    mainAxisAlignment:MainAxisAlignment.start,
    children:[
        Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:40.sp,
            color: Colors.black,
          ),
        ),
      SizedBox(height:50.h,),
      Container(
        height:180.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cardTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding:EdgeInsets.only(right:20.w),
              child:InkWell(
              onTap: () {
                setState(() {
                  tappedIndex = index;
                });
              },
              child: Container(
                width: ScreenUtil().screenWidth /5.5,
                height: ScreenUtil().screenHeight / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Card(
                 // shape: tappedIndex == index ? new RoundedRectangleBorder(side: new BorderSide(color: Colors.purpleAccent, width: 2.0), borderRadius: BorderRadius.circular(4.0)) : new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                  color: Colors.white,
                  child:Padding(padding:EdgeInsets.only(left:20.w,bottom:20.h),
                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      if(index!=2)
                      Text(
                        cardTitles[index],
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff9B9B9B),
                        ),
                      )
                      else if(index==2)
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                        Text(
                          cardTitles[index],
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0xff9B9B9B),
                          ),
                        ),
                  Padding(padding:EdgeInsets.only(right:20.w,top:10.h),
                child:Image.asset('assets/images/info.png',height:26.h,),
                  ),
                      ],
                        ),
                      if(index!=2)
                        Text(
                          cardSubTitles[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: Colors.black,
                          ),
                        )
                     else if(index==2)
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children:[
                            Image.asset('assets/images/lock .png',width:26.w,height:26.h,),
                            Text(
                              cardSubTitles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width:30.w,),
                          ],
                        ),

                      if(index==2)
                        Center(
                  child:Container(
                  alignment:AlignmentDirectional.center,
                  width:120.w,
                      height:44.h,
                      child:InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text:cardSubTitles[index]));
                        },
                        borderRadius: BorderRadius.circular(15.r),
                       child:Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          decoration: BoxDecoration(
                            color:Color(0xff2879FF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child:Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children:[
                            Text(
                              'Copy',
                              style: TextStyle(
                                fontSize:10.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width:10.w,),
                              Image.asset('assets/images/copy.png',width:20.w,height:60.h,),
                          ],
                          ),
                        ),
                      ),
                      ),
                  ),
                    ],
                  ),
                ),
              ),
              ),
              ),
            );
          },
        ),
      ),
      SizedBox(height:100.h,),
      Text(
        'Your Transactions',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:40.sp,
          color: Colors.black,
        ),
      ),
      Container(
        height:300.h,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cardTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: ScreenUtil().screenWidth /5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding:EdgeInsets.only(right:900.w,top:30.h),
                      child:Row(
                        children:[
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD9D9D9),
                                )),
                      SizedBox(width:40.w,),
                      Text(
                        'Xbsbot',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight:FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width:295.w,),
                      Text(
                        '\$214.711',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight:FontWeight.bold,
                          fontFamily:'Gilroy-Bold',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
            ),
                      Row(
                      children:[
                        SizedBox(width:100.w,),
                      Text(
                        'Xbsbot2152m2....827',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight:FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                        SizedBox(width:220.w,),
                      Text(
                        '02.02.23',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight:FontWeight.bold,
                          fontFamily:'Gilroy-Bold',
                          color: Colors.black,
                        ),
                      ),
            ],
                      ),
            Padding(padding:EdgeInsets.only(right:1000.w),
                      child:Divider(
                        color:Color(0xffbB5D1FF),

                      ),
            ),
            ],
                  ),
            );
          },
        ),
      ),
],
    ),
    ),
        ),
    ],
      ),
    );
    }
  }

