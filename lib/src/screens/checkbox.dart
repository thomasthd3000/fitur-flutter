import 'package:flutter/material.dart';

class CustomCheckboxDemo extends StatefulWidget {
  const CustomCheckboxDemo({super.key});

  @override
  State<CustomCheckboxDemo> createState() => _CustomCheckboxDemoState();
}

class _CustomCheckboxDemoState extends State<CustomCheckboxDemo> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Checkbox with Padding'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding around the checkbox
          child: Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Transform.scale(
              scale: 1,
              child: Checkbox(
                value: _isChecked,
                side: BorderSide.none,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                checkColor: Colors.transparent, // Removes the checkmark
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.green; // Background color when checked
                  }
                  return Colors.transparent; // Background color when unchecked
                }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                  side: const BorderSide(color: Colors.blue, width: 2), // Custom border
                ),
                //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Controls hit area
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListTile with Underline')),
        body: ListView(
          children: const [
            CustomListTile(title: 'Item 1', subtitle: 'Subtitle 1'),
            CustomListTile(title: 'Item 2', subtitle: 'Subtitle 2'),
            CustomListTile(title: 'Item 3', subtitle: 'Subtitle 3'),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_upward),
        ),
        const Divider(thickness: 1, height: 1, color: Colors.grey),
      ],
    );
  }
}



// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class Product {
//   final String title;
//   final double price;

//   Product({required this.title, required this.price});
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Sample data
//     Map<String, Map<String, List<Product>>> menuItemsByCategoryAndDate = {
//       'Daily Set': {
//         '2024-11-08': [
//           Product(title: 'Daily Special A', price: 10.0),
//           Product(title: 'Daily Special B', price: 12.0),
//         ],
//       },
//       'Pasta': {
//         '2024-11-08': [
//           Product(title: 'Spaghetti Carbonara', price: 15.0),
//           Product(title: 'Fettuccine Alfredo', price: 14.0),
//         ],
//       },
//       'Breakfast & Stall': {
//         '2024-11-08': [
//           Product(title: 'Egg Sandwich', price: 5.0),
//           Product(title: 'Nasi Lemak', price: 6.0),
//         ],
//       },
//     };

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Menu Example')),
//         body: ListView(
//           children: menuItemsByCategoryAndDate.entries.map((categoryEntry) {
//             String categoryTitle = categoryEntry.key;
//             Map<String, List<Product>> dateProducts = categoryEntry.value;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     categoryTitle,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 ...dateProducts.entries.expand((dateEntry) {
//                   List<Product> products = dateEntry.value;

//                   return List.generate(products.length, (index) {
//                     Product product = products[index];
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 4.0),
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: index == 0 ? Colors.white : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(8.0),
//                         border: Border.all(color: Colors.grey.shade300),
//                       ),
//                       child: index == 0
//                           ? Text(
//                               product.title,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           : Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.title,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8.0),
//                                 Text(
//                                   'Price: \$${product.price.toStringAsFixed(2)}',
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     );
//                   });
//                 }).toList(),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
