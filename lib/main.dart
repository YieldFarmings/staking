import 'package:bsbot/Repositories/swap_repository.dart';
import 'package:bsbot/Services/swap_service.dart';
import 'package:bsbot/screens/dashboard/dashboard_screen.dart';
import 'package:bsbot/screens/swaping/swaping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

import 'Repositories/staking_repository.dart';
import 'Services/staking_service.dart';
import 'common_widget/bottom_navigation_bar.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BSBOT',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryTextTheme: GoogleFonts.poppinsTextTheme(),
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          home:child
        );
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => SwapRepository(
              swapService: SwapService(),
            ),
          ),
          RepositoryProvider(
            create: (_) => StakingRepository(
              stakingService: StakingService(),
            ),
          ),
        ],
        child: BottomNaviagtionBar(),
      ),
    );
  }
}
