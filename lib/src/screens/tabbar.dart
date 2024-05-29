import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visible/src/data/models/handbook_model.dart';

import 'package:visible/src/screens/tabbar_one.dart';
import 'package:visible/src/screens/tabbar_two.dart';
import 'package:visible/src/utils/api_connection.dart';
import 'package:http/http.dart' as http;

class HandbookParentView extends StatelessWidget {
  const HandbookParentView({Key? key}) : super(key: key);

  //final _currentUser = Get.put(HomeController());

  Future<ListHandbook> getListHandbook() async {
    ListHandbook emptyHandbook = ListHandbook(
      dataEyes: [],
      dataMshs: [],
      type: '',
    );

    //String myType = await RememberUserPrefs.readAgreement();
    String myType = "B";

    String accessToken =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3d3dy5zd2Etamt0LmNvbSIsImlhdCI6MTcxNjk2NTY4NywiZXhwIjoxNzE2OTcyODg3LCJ1c2VybmFtZSI6IkVMTEVOSCJ9._Ks4aZP8ypJpnm_77su5g7qeYsdoRWlbGcYZFhL5Vo0';
    try {
      var res = await http.post(
        Uri.parse(API.listAgreement),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          "type": myType,
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfHandbooks = jsonDecode(res.body);

        if (responseBodyOfHandbooks["success"] == true) {
          return ListHandbook.fromJson(responseBodyOfHandbooks['result']);
        }
      } else {
        Fluttertoast.showToast(msg: "Please Try Again Later");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Please Try Again Later");
    }

    return emptyHandbook;
  }

  @override
  Widget build(BuildContext context) {
    String type = "B";

    return Scaffold(
      body: FutureBuilder(
        future: getListHandbook(),
        builder: (context, AsyncSnapshot<ListHandbook> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue[400],
                title: const Text(
                  "Handbooks Parent",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: const Center(
                child: Text(
                  "Empty, No Data.",
                ),
              ),
            );
          }
          if (dataSnapShot.data!.dataEyes.isNotEmpty ||
              dataSnapShot.data!.dataMshs.isNotEmpty) {
            return type == "E" || type == "M"
                ? TabBarOne(data: dataSnapShot.data!)
                : TabBarTwo(data: dataSnapShot.data!);
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue[400],
                title: const Text(
                  "Handbooks Parent",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: const Center(
                child: Text(
                  "Empty, No Data.",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
