import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:visible/src/data/models/info_model.dart';

import 'package:visible/src/screens/tabbar_one.dart';
import 'package:visible/src/screens/tabbar_two.dart';
import 'package:visible/src/utils/api_connection.dart';
import 'package:http/http.dart' as http;

class HandbookParentView extends StatelessWidget {
  const HandbookParentView({Key? key}) : super(key: key);

  Future<List<Posts>> getAllInfoFav() async {
    List<Posts> allInfoList = [];

    try {
      var res = await http.post(
        Uri.parse(API.readFavorite),
        body: {
          "user_id": "1",
          "student": "50017440,50017441,50017456",
          //"fcm_id": fcmToken
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfAllInfos = jsonDecode(res.body);

        if (responseBodyOfAllInfos["success"] == true) {
          for (var eachRecord
              in (responseBodyOfAllInfos["infosData"] as List)) {
            allInfoList.add(Posts.fromJson(eachRecord));
          }
        }
      } else {
        Fluttertoast.showToast(msg: "Please Try Again Later");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Please Try Again Later");
    }

    return allInfoList;
  }

  @override
  Widget build(BuildContext context) {
    String type = "B";

    return Scaffold(
      body: FutureBuilder(
        future: getAllInfoFav(),
        builder: (context, AsyncSnapshot<List<Posts>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "Empty, No Data.",
              ),
            );
          }
          if (dataSnapShot.data!.isNotEmpty) {
            return type == "E" || type == "M"
                ? TabBarOne(type: type)
                : TabBarTwo(type: type);
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Empty, No Data.")],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
