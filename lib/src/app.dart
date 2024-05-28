import 'package:flutter/material.dart';
//import 'package:visible/src/screens/dialog.dart';

import 'package:get/get.dart';
//import 'package:visible/src/screens/permission.dart';
import 'package:visible/src/screens/tabbar.dart';

// import 'package:visible/src/screens/webview.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'THD',
      home: HandbookParentView(),
    );
    // return const MaterialApp(
    //   title: 'THD',
    //   home: WebViewExample(),
    // );
  }
}
