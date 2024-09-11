// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:visible/src/screens/force_update.dart';

class Version extends StatelessWidget {
  final String accountNumber = '89325400000020002';
  final String accountName = 'Bank BCA';
  final String amount = 'Rp 100.000';
  final String amountNum = '100000';

  const Version({super.key});

  @override
  Widget build(BuildContext context) {
    ForceUpdateChecker().checkForUpdate(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Version',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Make payment before',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                '20/08/2024 11:00 WIB',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Pay to Virtual Account Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
