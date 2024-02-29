import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KotakWarna(text: "Merah", warna: Colors.red),
              KotakWarna(text: "Blue", warna: Colors.blue),
              KotakWarna(text: "Green", warna: Colors.green),
              KotakWarna(text: "Merah", warna: Colors.red),
              KotakWarna(text: "Blue", warna: Colors.blue),
              KotakWarna(text: "Green", warna: Colors.green),
              KotakWarna(text: "Merah", warna: Colors.red),
              KotakWarna(text: "Blue", warna: Colors.blue),
              KotakWarna(text: "Green", warna: Colors.green),
              KotakWarna(text: "Merah", warna: Colors.red),
              KotakWarna(text: "Blue", warna: Colors.blue),
              KotakWarna(text: "Green", warna: Colors.green),
              KotakWarna(text: "Merah", warna: Colors.red),
              KotakWarna(text: "Blue", warna: Colors.blue),
              KotakWarna(text: "Green", warna: Colors.green),
            ],
          ),
        ));
  }
}

class KotakWarna extends StatelessWidget {
  const KotakWarna({super.key, required this.text, required this.warna});

  final String text;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: warna,
      child: Text(text),
    );
  }
}
