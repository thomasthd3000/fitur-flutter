import 'package:flutter/material.dart';

// class MenuOrderedScreen extends StatelessWidget {
//   final List<Order> orders = [
//     Order(date: '13 May 2024', itemName: 'Singapore Laksa', price: 20000),
//     Order(date: '13 May 2024', itemName: 'Chicken Burger', price: 25000),
//     Order(date: '14 May 2024', itemName: 'Miso Soup', price: 20000),
//   ];

//   MenuOrderedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Menu Ordered'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: OrderList(orders: orders),
//       ),
//     );
//   }
// }

// class OrderList extends StatelessWidget {
//   final List<Order> orders;

//   const OrderList({super.key, required this.orders});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         if (orders.length > 2)
//           ExpansionTile(
//             title: const Text('Menu Ordered'),
//             children: orders.map((order) => OrderTile(order: order)).toList(),
//           )
//         else
//           Column(
//             children: orders.map((order) => OrderTile(order: order)).toList(),
//           ),
//       ],
//     );
//   }
// }

// class OrderTile extends StatelessWidget {
//   final Order order;

//   const OrderTile({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(order.itemName),
//       subtitle: Text(order.date),
//       trailing: Text('Rp${order.price}'),
//     );
//   }
// }

// class Order {
//   final String date;
//   final String itemName;
//   final int price;

//   Order({required this.date, required this.itemName, required this.price});
// }

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool allChecked = false;
  bool week1Checked = false;
  bool week2Checked = false;
  List<bool> week1Items = [false, false, false];
  List<bool> week2Items = [false, false, false];

  void _onAllCheckedChanged(bool? value) {
    setState(() {
      allChecked = value!;
      week1Checked = value;
      week2Checked = value;
      week1Items = week1Items.map((_) => value).toList();
      week2Items = week2Items.map((_) => value).toList();
    });
  }

  void _onWeek1CheckedChanged(bool? value) {
    setState(() {
      week1Checked = value!;
      week1Items = week1Items.map((_) => value).toList();
      if (!value) {
        allChecked = false;
      } else if (week2Checked) {
        allChecked = true;
      }
    });
  }

  void _onWeek2CheckedChanged(bool? value) {
    setState(() {
      week2Checked = value!;
      week2Items = week2Items.map((_) => value).toList();
      if (!value) {
        allChecked = false;
      } else if (week1Checked) {
        allChecked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('All'),
              value: allChecked,
              onChanged: _onAllCheckedChanged,
            ),
            CheckboxListTile(
              title: const Text('Week 1'),
              value: week1Checked,
              onChanged: _onWeek1CheckedChanged,
            ),
            ...week1Items.asMap().entries.map((entry) {
              int index = entry.key;
              bool value = entry.value;
              return CheckboxListTile(
                title: Text('Week 1 Item ${index + 1}'),
                value: value,
                onChanged: (bool? value) {
                  setState(() {
                    week1Items[index] = value!;
                    if (week1Items.contains(false)) {
                      week1Checked = false;
                      allChecked = false;
                    } else {
                      week1Checked = true;
                      if (week2Checked) {
                        allChecked = true;
                      }
                    }
                  });
                },
              );
            }).toList(),
            CheckboxListTile(
              title: const Text('Week 2'),
              value: week2Checked,
              onChanged: _onWeek2CheckedChanged,
            ),
            ...week2Items.asMap().entries.map((entry) {
              int index = entry.key;
              bool value = entry.value;
              return CheckboxListTile(
                title: Text('Week 2 Item ${index + 1}'),
                value: value,
                onChanged: (bool? value) {
                  setState(() {
                    week2Items[index] = value!;
                    if (week2Items.contains(false)) {
                      week2Checked = false;
                      allChecked = false;
                    } else {
                      week2Checked = true;
                      if (week1Checked) {
                        allChecked = true;
                      }
                    }
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
