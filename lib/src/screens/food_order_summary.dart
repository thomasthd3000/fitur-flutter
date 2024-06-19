// import 'dart:math';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visible/src/data/models/food_model.dart';

// import 'package:visible/src/data/models/food_data.dart';
// import 'package:visible/src/data/models/food_model.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FoodOrderSummary extends StatefulWidget {
  const FoodOrderSummary({super.key});

  @override
  State<FoodOrderSummary> createState() => _FoodOrderSummaryState();
}

class _FoodOrderSummaryState extends State<FoodOrderSummary> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

  bool expandedOrder = true;

  List<AddOrder> orders = [
    AddOrder(
      date: '13 May 2024',
      products: [
        Product(
          itemId: '1',
          itemName: 'Sauteed broccolli and carrot (Tumis Brokoli dan Wortel)',
          itemPrice: 20000,
          itemImage: '', // Add a valid image URL if available
        ),
        Product(
          itemId: '2',
          itemName: 'Chicken Burger',
          itemPrice: 25000,
          itemImage: '', // Add a valid image URL if available
        ),
      ],
    ),
    AddOrder(
      date: '14 May 2024',
      products: [
        Product(
          itemId: '3',
          itemName: 'Beef Burger',
          itemPrice: 30000,
          itemImage: '', // Add a valid image URL if available
        ),
        Product(
          itemId: '4',
          itemName: 'Fish and Chips',
          itemPrice: 35000,
          itemImage: '', // Add a valid image URL if available
        ),
      ],
    ),
  ];

  //final FoodController foodController = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(
        //   color: Colors.white,
        // ),
        backgroundColor: Colors.blue[400],
        title: const Text(
          "ORDER SUMMARY",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade200,
        width: MediaQuery.of(context).size.width * 0.98,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactInformation(context),
                const SizedBox(height: 10),
                _buildMenuOrdered(),
                if (expandedOrder) ...[
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      child: Column(
                        children: [
                          for (var order in orders)
                            Column(
                              children: [
                                _buildMenuItem(order),
                              ],
                            )

                          // for (var order in orders)
                          //   Card(
                          //     color: Colors.white,
                          //     child: Padding(
                          //       padding: const EdgeInsets.fromLTRB(
                          //           12.0, 12.0, 12.0, 12.0),
                          //       child: _buildMenuItem(order),
                          //     ),
                          //   ),

                          // _buildMenuItem(
                          //     '13 May 2024', 'Chicken Burger', 'Rp25.000'),
                          // _buildMenuItem('14 May 2024', 'Miso soup (Sup Miso)',
                          //     'Rp20.000'),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                _buildDetailPayment(),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildInfo(),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 50),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Text(
                              'Pay Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInformation(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.98,
      child: const Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('ellenh@swu.com'),
              Text('081219999999'),
              Text('Student Name: Sonny'),
              Text('Grade Level: Grade 11'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOrdered() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                foregroundColor: Colors.white),
            onPressed: () {
              setState(
                () {
                  expandedOrder = !expandedOrder;
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Menu Ordered',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Icon(
                  color: Colors.black,
                  expandedOrder ? Icons.expand_less : Icons.expand_more,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(AddOrder orders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_month_outlined, color: Colors.blue),
            Text(
              orders.date,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        for (var product in orders.products)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.fastfood, color: Colors.blue),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 252,
                      child: Text(
                        product.itemName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    //const SizedBox(width: 40),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 35),
                    Text(
                      currencyFormat.format(product.itemPrice),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDetailPayment() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            _buildPaymentDetail('Subtotal', 'Rp. 65.000'),
            _buildPaymentDetail('Transaction Fee', 'Rp. 1.326'),
            const Divider(),
            _buildPaymentDetail('Total', 'Rp. 66.326',
                isBold: true, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetail(String label, String amount,
      {bool isBold = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
            'Thank you for submitting Pre Order Purchase, our canteen '
            'will prepare your meals based on your orders. Please pick '
            'your order at Blumbou Court or request delivery to the '
            'Class for these two results.',
            textAlign: TextAlign.justify),
        SizedBox(height: 8),
        Text(
            'This year, we support pre-order using this platform. '
            'Please ensure that your ordered meals need to be paid '
            'in the first day of order submission.',
            textAlign: TextAlign.justify),
        SizedBox(height: 8),
        Text('Thank you for your understanding & cooperation.',
            textAlign: TextAlign.justify),
      ],
    );
  }
}
