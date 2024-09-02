import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AskPermissions {
  Future<String?> requestPermission() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

      if (build.version.sdkInt >= 33) {
        // const permission = Permission.manageExternalStorage;

        // if (await permission.isDenied) {
        //   final result = await permission.request();
        //   if (result.isGranted) {
        //     return "true";
        //   } else if (result.isDenied) {
        //     return "false";
        //   } else if (result.isPermanentlyDenied) {
        //     return "denied";
        //   }
        // } else {
        //   return "true";
        // }
        return "true";
      } else {
        const permission = Permission.storage;

        if (await permission.isDenied) {
          final result = await permission.request();
          if (result.isGranted) {
            return "true";
          } else if (result.isDenied) {
            return "false";
          } else if (result.isPermanentlyDenied) {
            return "denied";
          }
        } else {
          return "true";
        }
      }
    } else if (Platform.isIOS) {
      const permission = Permission.storage;

      if (await permission.isDenied) {
        final result = await permission.request();
        if (result.isGranted) {
          return "true";
        } else if (result.isDenied) {
          return "false";
        } else if (result.isPermanentlyDenied) {
          return "denied";
        }
      } else {
        return "true";
      }
    }

    return null;
  }
}
