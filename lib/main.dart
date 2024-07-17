import 'package:flutter/material.dart';
import 'src/app.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // const permission = Permission.notification;

  // if (await permission.isDenied) {
  //   final result = await permission.request();
  //   if (result.isGranted) {
  //     print("true");
  //   } else if (result.isDenied) {
  //     print("false");
  //   } else if (result.isPermanentlyDenied) {
  //     print("denied");
  //   }
  // }
  // await Permission.notification.isDenied.then((value) {
  //   print(value);
  //   if (value) {
  //     print("Request Permission");
  //     Permission.notification.request();
  //   }
  // });

  runApp(const App());
}
