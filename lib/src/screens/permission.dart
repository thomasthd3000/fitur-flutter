import 'dart:io';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visible/src/utils/ask_permission.dart';
import 'package:get/get.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({super.key});

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  final AskPermissions _askPermissions =
      AskPermissions(); // Create an instance of AskPermissions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top News'),
          backgroundColor: Colors.lime,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  saveFile();
                  // snackbar();
                },
                child: const Text("Download"),
              )
            ],
          ),
        ));
  }

  Future<String> getFilePath() async {
    String supportPath = '';

    if (Platform.isAndroid) {
      Directory? directory = Directory('/storage/emulated/0/Download');
      bool hasExisted = await directory.exists();
      if (!hasExisted) {
        directory.create();
      }
      supportPath = directory.path;
    } else {
      Directory docDir = await getApplicationDocumentsDirectory();
      supportPath = docDir.path;
    }

    var time = DateTime.now().microsecondsSinceEpoch;
    String filePath = '$supportPath/image-$time.jpg';

    //print(filePath);
    return filePath;
  }

  void saveFile() async {
    String? statusPermission = await _askPermissions.requestPermission();

    if (statusPermission == "true") {
      var file = File(await getFilePath());
      var res = await http.get(
        Uri.parse(
            "https://fastly.picsum.photos/id/82/200/200.jpg?hmac=ATNAhTLN2dA0KmTzSE5D9XiPe3GMX8uwxpFlhU7U5OY"),
      );

      file.writeAsBytes(res.bodyBytes);
    } else if (statusPermission == "denied") {
      await openAppSettings();
    } else {
      Get.snackbar(
        'Warning',
        "",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(
          Icons.add_alert_sharp,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: Get.width,
        mainButton: TextButton(
          child: const Text(
            'Open App Settings',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            openAppSettings();
          },
        ),
        messageText: const Text(
          "Permission denied",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );
    }
  }

  Future<String> getFilePathTest() async {
    // Directory? appDocumentsDirectory = await getDownloadsDirectory(); // 1
    // String appDocumentsPath = appDocumentsDirectory.path; // 2
    // String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    //Directory support = await getApplicationSupportDirectory();
    // String supportPath = support.path;
    // String filePath = '$supportPath/demoTextFile2.txt';

    // var directories =
    //     await getExternalStorageDirectories(type: StorageDirectory.documents);
    // var dir = directories![0];
    // String filePath = '${dir.path}/demoTextFile.txt';

    // final Directory? external = await getDownloadsDirectory();
    // String externalPath = external!.path;
    // String filePath = '$externalPath/demoTextFile.txt';

    //IOS
    // Directory docDir = await getApplicationDocumentsDirectory();
    // String docPath = docDir.path;
    // String filePath = '$docPath/demoTextFile2.txt';

    String supportPath = '';

    if (Platform.isAndroid) {
      Directory? directory = Directory('/storage/emulated/0/Download');
      bool hasExisted = await directory.exists();
      if (!hasExisted) {
        directory.create();
      }
      supportPath = directory.path;
    } else {
      Directory docDir = await getApplicationDocumentsDirectory();
      supportPath = docDir.path;
    }

    var time = DateTime.now().microsecondsSinceEpoch;
    String filePath = '$supportPath/image-$time.jpg';

    print(filePath);
    return filePath;
  }

  void snackbar() {
    Get.snackbar(
      'Warning',
      "",
      colorText: Colors.white,
      backgroundColor: Colors.lightBlue,
      icon: const Icon(
        Icons.add_alert_sharp,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Get.width,
      mainButton: TextButton(
        child: const Text(
          'Open App Settings',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          openAppSettings();
        },
      ),
      messageText: const Text(
        "Permission denied",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  downloadFile() async {
    // File file = File(await getFilePath()); // 1
    // file.writeAsString("demo file : demoTextFile.txt"); // 2

    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await http.get(
      Uri.parse(
          "https://fastly.picsum.photos/id/82/200/200.jpg?hmac=ATNAhTLN2dA0KmTzSE5D9XiPe3GMX8uwxpFlhU7U5OY"),
    );

    file.writeAsBytes(res.bodyBytes);
  }

  // static Future saveFile2(String fileName, List<int> bytes) async {
  //   Directory? directory;
  //   File? file;
  //   try {
  //     if (defaultTargetPlatform == TargetPlatform.android) {
  //       //downloads folder - android only - API>30
  //       directory = Directory('/storage/emulated/0/download');
  //     } else {
  //       directory = await getApplicationDocumentsDirectory();
  //     }

  //     bool hasExisted = await directory.exists();
  //     if (!hasExisted) {
  //       directory.create();
  //     }

  //     //file to saved
  //     file = File("${directory.path}${Platform.pathSeparator}$fileName.pdf");
  //     if (!file.existsSync()) {
  //       await file.create();
  //     }
  //     await file.writeAsBytes(bytes);
  //   } catch (e) {
  //     if (file != null && file.existsSync()) {
  //       file.deleteSync();
  //     }
  //     rethrow;
  //   }
  // }
}
