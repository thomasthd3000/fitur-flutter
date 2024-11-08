import 'package:flutter/material.dart';

// class CustomCheckboxDemo extends StatefulWidget {
//   const CustomCheckboxDemo({super.key});

//   @override
//   State<CustomCheckboxDemo> createState() => _CustomCheckboxDemoState();
// }

// class _CustomCheckboxDemoState extends State<CustomCheckboxDemo> {
//   bool _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Checkbox with Padding'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0), // Add padding around the checkbox
//           child: Container(
//             height: 26,
//             width: 26,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey,
//               ),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Transform.scale(
//               scale: 1,
//               child: Checkbox(
//                 value: _isChecked,
//                 side: BorderSide.none,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _isChecked = value ?? false;
//                   });
//                 },
//                 checkColor: Colors.transparent, // Removes the checkmark
//                 fillColor: WidgetStateProperty.resolveWith((states) {
//                   if (states.contains(WidgetState.selected)) {
//                     return Colors.green; // Background color when checked
//                   }
//                   return Colors.transparent; // Background color when unchecked
//                 }),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5), // Rounded corners
//                   side: BorderSide(color: Colors.blue, width: 2), // Custom border
//                 ),
//                 //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Controls hit area
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
