// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visible/src/data/models/agreement_model.dart';
import 'package:visible/src/utils/api_connection.dart';

class DialogController extends GetxController {
  RxBool isChecked = false.obs;
  //bool get isChecked => _isChecked.value;

  @override
  void onInit() {
    if (kDebugMode) {
      print("on init run");
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    getAgreement().then((response) {
      if (response.isNotEmpty) {
        //if (response[0].agreeFlag == false) {
        myDialog(Get.context!, response);
        //}
      } else {
        //print('Failed to fetch data or received null response.');
      }
    });
  }

  Future<List<Agreement>> getAgreement() async {
    List<Agreement> listAgreement = [];

    var res = await http.get(
      Uri.parse(API.getAgreement),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3d3dy5zd2Etamt0LmNvbSIsImlhdCI6MTcxNjU0MzAyNiwiZXhwIjoxNzE2NTQ2NjI2LCJ1c2VybmFtZSI6IkVMTEVOSCJ9.Onod2xjWTOI061W0_hQDyjHz4ww7-gXbXISDH9i2Meg',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      var responseGetAgreement = jsonDecode(res.body);

      if (responseGetAgreement['success'] == true) {
        for (var item in responseGetAgreement['result']) {
          listAgreement.add(Agreement.fromJson(item));
        }
      } else {
        if (responseGetAgreement['error_code'] == "-2") {
          // RememberUserPrefs.removeUserInfo().then((value) {
          //   _currentUser.removeUserInfo();
          //   Get.off(() => LoginView());
          // });
        }
      }
    }

    return listAgreement;
  }

  setAgreement() async {
    var res = await http.post(
      Uri.parse(API.setAgreement),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3d3dy5zd2Etamt0LmNvbSIsImlhdCI6MTcxNjU0MzAyNiwiZXhwIjoxNzE2NTQ2NjI2LCJ1c2VybmFtZSI6IkVMTEVOSCJ9.Onod2xjWTOI061W0_hQDyjHz4ww7-gXbXISDH9i2Meg',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      var resBodyOfSetAgreement = jsonDecode(res.body);
      if (resBodyOfSetAgreement['success'] == true) {
        //print("berhasil set");
      } else {
        if (resBodyOfSetAgreement['error_code'] == "-2") {
          // RememberUserPrefs.removeUserInfo().then((value) {
          //   _currentUser.removeUserInfo();
          //   Get.off(() => LoginView());
          // });
        }
      }
    }
  }

  void myDialog(BuildContext context, List<Agreement> listAgreement) {
    String myMessage = listAgreement[0].message;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Accept Terms"),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: Colors.orange,
                      focusColor: Colors.orange,
                      hoverColor: Colors.orange,
                      value: isChecked.value,
                      onChanged: (bool? value) {
                        isChecked.value = value!;
                        //update();
                      },
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.orange),
                      ),
                    ),
                    const Text(
                      "By checking this box,",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(myMessage,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: <Widget>[
            Obx(
              () => ElevatedButton(
                onPressed: isChecked.value
                    ? () {
                        if (isChecked.value) {
                          setAgreement();
                          Get.back();
                        } else {
                          Get.snackbar(
                            "Message",
                            "You must accept the terms and conditions to proceed",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
