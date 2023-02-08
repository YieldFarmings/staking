import 'package:bsbot/common_widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'navigation_bar_mobile.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          if (info.deviceScreenType == DeviceScreenType.desktop) {
            return NavigationBarTab();
          }
         else if (info.deviceScreenType == DeviceScreenType.mobile) {
            return Drawers();
          }
          return Text('');
        }
    ),
    );
  }
}

