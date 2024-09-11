import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:visible/src/utils/api_connection.dart';

class ForceUpdateChecker {
  Future<void> checkForUpdate(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String latestVersion = '1.0.0';
    String forceUpdate = 'N';

    print(currentVersion);

    final response = await http.get(Uri.parse(API.getVersions));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (Platform.isAndroid) {
        latestVersion = data['android_version'];
        forceUpdate = data['android_force'];
      } else if (Platform.isIOS) {
        latestVersion = data['ios_version'];
        forceUpdate = data['ios_force'];
      }

      if (!context.mounted) return;

      if (_isVersionOlder(currentVersion, latestVersion)) {
        if (forceUpdate == "Y") {
          print("force update");
          _showForceUpdateDialog(context);
        } else {
          print("optional update");
          _showOptionalUpdateDialog(context);
        }
      }
    } else {
      // Handle API error
      print("Failed to fetch the version information");
    }
  }

  bool _isVersionOlder(String currentVersion, String latestVersion) {
    List<int> currentParts = currentVersion.split('.').map(int.parse).toList();
    List<int> latestParts = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (currentParts[i] < latestParts[i]) {
        return true;
      } else if (currentParts[i] > latestParts[i]) {
        return false;
      }
    }
    return false;
  }

  void _showForceUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Update Required'),
        content: const Text('A newer version of the app is available. Please update to continue.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the app store or update page
              if (Platform.isAndroid) {
                print("go to play store");
                //_redirectToStore(Uri.parse(API.appANDROID));
              } else if (Platform.isIOS) {
                print("go to app store");
                //_redirectToStore(Uri.parse(API.appIOS));
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showOptionalUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Available'),
        content: const Text('A newer version of the app is available. Would you like to update?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the app store or update page
              if (Platform.isAndroid) {
                print("go to play store");
                //_redirectToStore(Uri.parse(API.appANDROID));
              } else if (Platform.isIOS) {
                print("go to app store");
                //_redirectToStore(Uri.parse(API.appIOS));
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // Future<void> _redirectToStore(Uri urlAttach1) async {
  //   if (!await launchUrl(urlAttach1)) {
  //     throw Exception('Could not launch $urlAttach1');
  //   }
  // }
}
