import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:get/get.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({super.key});

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
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
                onPressed: () {
                  downloadFile();
                },
                child: const Text("Download"),
              )
            ],
          ),
        ));
  }

  downloadFile() async {
    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await get(
      Uri.parse(
          "https://fastly.picsum.photos/id/82/200/200.jpg?hmac=ATNAhTLN2dA0KmTzSE5D9XiPe3GMX8uwxpFlhU7U5OY"),
    );

    file.writeAsBytes(res.bodyBytes);
  }
}
