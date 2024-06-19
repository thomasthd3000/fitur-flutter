import 'package:flutter/material.dart';

class OrderData {
  final String email;
  final String phoneNumber;
  final String studentName;
  final String gradeLevel;
  final List<MenuItem> menuItems;
  final double subtotal;
  final double transactionFee;
  final double total;

  OrderData({
    required this.email,
    required this.phoneNumber,
    required this.studentName,
    required this.gradeLevel,
    required this.menuItems,
    required this.subtotal,
    required this.transactionFee,
    required this.total,
  });
}

class MenuItem {
  final String date;
  final String name;
  final double price;

  MenuItem({
    required this.date,
    required this.name,
    required this.price,
  });
}

class OrderSummaryScreen extends StatelessWidget {
  final OrderData orderData;

  const OrderSummaryScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactInformation(),
            SizedBox(height: 20),
            _buildMenuOrdered(),
            SizedBox(height: 20),
            _buildDetailPayment(),
            SizedBox(height: 20),
            _buildInfo(),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(orderData.email),
        Text(orderData.phoneNumber),
        Text('Student Name: ${orderData.studentName}'),
        Text('Grade Level: ${orderData.gradeLevel}'),
      ],
    );
  }

  Widget _buildMenuOrdered() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Ordered',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...orderData.menuItems.map((item) =>
            _buildMenuItem(item.date, item.name, item.price.toString())),
      ],
    );
  }

  Widget _buildMenuItem(String date, String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$date - $name'),
        Text(price),
      ],
    );
  }

  Widget _buildDetailPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Payment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildPaymentDetail('Subtotal', 'Rp. ${orderData.subtotal}'),
        _buildPaymentDetail(
            'Transaction Fee', 'Rp. ${orderData.transactionFee}'),
        Divider(),
        _buildPaymentDetail('Total', 'Rp. ${orderData.total}', isBold: true),
      ],
    );
  }

  Widget _buildPaymentDetail(String label, String amount,
      {bool isBold = false}) {
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
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Thank you for submitting Pre Order Purchase, our canteen '
          'will prepare your meals based on your orders. Please pick '
          'your order at Blumbou Court or request delivery to the '
          'Class for these two results.',
        ),
        SizedBox(height: 8),
        Text(
          'This year, we support pre-order using this platform. '
          'Please ensure that your ordered meals need to be paid '
          'in the first day of order submission.',
        ),
        SizedBox(height: 8),
        Text(
          'Thank you for your understanding & cooperation.',
        ),
      ],
    );
  }
}
