import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visible/src/controllers/dialog_controller.dart';

class DialogView extends StatelessWidget {
  DialogView({super.key});

  final dialogController = Get.put(DialogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top News'),
          backgroundColor: Colors.lime,
        ),
        body: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text('Dialog Page'),
            ],
          ),
        ));
  }
}
