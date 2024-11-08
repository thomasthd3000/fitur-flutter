import 'package:flutter/material.dart';
//import 'package:visible/src/screens/dialog.dart';

import 'package:get/get.dart';
// import 'package:visible/src/screens/checkbox.dart';
import 'package:visible/src/screens/date_button.dart';
// import 'package:visible/src/screens/qr.dart';
// import 'package:visible/src/screens/version.dart';
// import 'package:visible/src/screens/va.dart';
//import 'package:visible/src/screens/scroll.dart';
// import 'package:visible/src/screens/food_order_summary.dart';
// import 'package:visible/src/screens/permission.dart';
// import 'package:visible/src/screens/tabbar.dart';
// import 'package:visible/src/screens/webview.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'THD',
      home: ButtonRowScreen(),
    );
    // return const MaterialApp(
    //   title: 'THD',
    //   home: WebViewExample(),
    // );
  }
}
