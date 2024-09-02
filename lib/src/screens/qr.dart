import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:visible/src/utils/ask_permission.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final AskPermissions _askPermissions = AskPermissions();
  bool tablistLoading = false;

  //final String qrUrl = 'https://api.qrcode-monkey.com/tmp/8092dc7472d553035a4009b1ae67f2f9.svg?1724988847619';
  final String qrUrl =
      'https://api.qrserver.com/v1/create-qr-code/?color=000000&bgcolor=FFFFFF&data=https%3A%2F%2Fwww.swa-jkt.com%2F&qzone=1&margin=0&size=400x400&ecc=L';

  final String fileName = 'my_qr_code';

  Future<String> getFilePath(String title) async {
    String supportPath = '';

    if (Platform.isAndroid) {
      Directory? directory = Directory('/storage/emulated/0/Download');
      bool hasExisted = await directory.exists();
      if (!hasExisted) {
        directory.create();
      }
      supportPath = directory.path;

      String filePath = '$supportPath/$title.png';

      return filePath;
    } else {
      final docDir = await getApplicationDocumentsDirectory();
      supportPath = docDir.path;

      String filePath = '$supportPath/$title.png';
      // String titleHype2 = title;
      // String filePath = '$supportPath/$titleHype2.pdf';
      // String filePath = '$supportPath/TEST_UPLOAD_PDF.pdf';

      return filePath;
    }
  }

  void notifSnackbar(String status, String message, bool button, {String position = "top"}) {
    Get.snackbar(
      status,
      "",
      colorText: Colors.white,
      backgroundColor: Colors.lightBlue,
      icon: const Icon(
        Icons.add_alert_sharp,
        color: Colors.white,
      ),
      snackPosition: position == "top" ? SnackPosition.TOP : SnackPosition.BOTTOM,
      maxWidth: Get.width,
      mainButton: button == true
          ? TextButton(
              child: const Text(
                'Open App Settings',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openAppSettings();
              },
            )
          : null,
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Future<void> saveFile(String url) async {
    String? statusPermission = await _askPermissions.requestPermission();

    if (statusPermission == "true") {
      //try {
      var res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        var file = File(await getFilePath('QR'));
        await file.writeAsBytes(res.bodyBytes);
        //print('File written successfully to ${file.path}');

        notifSnackbar("Info", "Downloaded Successfully", false, position: "bottom");
      } else {
        notifSnackbar("Info", "Downloaded Failed", false, position: "bottom");
      }
      // } catch (e) {
      //   print(e);
      // }
    } else if (statusPermission == "denied") {
      await openAppSettings();
    } else {
      notifSnackbar("Warning", "Permission Denied", true, position: "bottom");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Scan QR Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.network(
              qrUrl,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Scan QRIS to make payment before',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '20/08/2024 11:00 WIB',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 20), // (8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //SizedBox(height: 10),
                    Text(
                      'Rp. 500.000',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  tablistLoading = true;
                });

                //await saveFile(qrUrl);
                await Future.delayed(const Duration(seconds: 2));

                setState(() {
                  tablistLoading = false;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 55),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: tablistLoading
                  ? SizedBox.fromSize(
                      size: const Size(200, 55),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Download QR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Text(
                      'Download QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
