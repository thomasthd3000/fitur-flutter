// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:get/get.dart';

// import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class NewHomeView extends StatelessWidget {
  const NewHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(
        //   color: Colors.white,
        // ),
        backgroundColor: Colors.blue[400],
        title: const Text(
          "HOME",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardMenu(
                title: "FOOD ORDER",
                customColor: const Color.fromARGB(255, 255, 126, 126),
                onTap: () {
                  //print("FOOD ORDER");
                },
                isIcon: false,
                iconTitle: "assets/icon_food.png",
                iconName: Icons.restaurant,
              ),
              const SizedBox(
                height: 8,
              ),
              CardMenu(
                title: "INFOFLASH",
                customColor: const Color.fromARGB(255, 117, 209, 162),
                onTap: () {
                  //print("INFOFLASH");
                },
                isIcon: true,
                iconTitle: "assets/icon_food.png",
                iconName: Icons.info_outlined,
              ),
              const SizedBox(
                height: 8,
              ),
              CardMenu(
                title: "PROFILE",
                customColor: const Color.fromARGB(255, 250, 204, 147),
                onTap: () {
                  //print("PROFILE");
                },
                isIcon: true,
                iconTitle: "assets/icon_food.png",
                iconName: Icons.person_2,
              ),
              const SizedBox(
                height: 8,
              ),
              CardMenu(
                title: "INFOBYTE",
                customColor: const Color.fromARGB(255, 162, 217, 240),
                onTap: () {
                  //print("INFOBYTE");
                },
                isIcon: true,
                iconTitle: "assets/icon_food.png",
                iconName: Icons.info_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.title,
    required this.customColor,
    required this.onTap,
    required this.isIcon,
    required this.iconTitle,
    this.iconName,
  });

  final String title;
  final String iconTitle;
  final Color customColor;
  final IconData? iconName;
  final Function onTap;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(0),
        color: customColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 120,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                isIcon == true
                    ? Icon(
                        iconName,
                        size: 76,
                      )
                    : Image.asset(
                        iconTitle,
                        width: 80, // Adjust the width as needed
                        height: 74,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  //textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
