import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AskPermissions {
  Future<String?> requestPermission() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

      if (build.version.sdkInt >= 33) {
        // var status = await Permission.manageExternalStorage.request();
        // if (status.isGranted) {
        return "true";
        // } else if (status.isDenied) {
        //   return "false";
        // } else {
        //   return "denied";
        // }
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
      const permission = Permission.photos;

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
