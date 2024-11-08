import 'package:flutter/material.dart';

class ButtonRowScreen extends StatefulWidget {
  const ButtonRowScreen({super.key});

  @override
  ButtonRowScreenState createState() => ButtonRowScreenState();
}

class ButtonRowScreenState extends State<ButtonRowScreen> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Button Example'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: List.generate(14, (index) {
            final isSelected = _selectedButtonIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedButtonIndex = index;
                      });
                    },
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  if (isSelected) Text('Button ${(index + 1)} clicked'),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class CustomCheckboxDemo extends StatefulWidget {
//   const CustomCheckboxDemo({super.key});

//   @override
//   State<CustomCheckboxDemo> createState() => _CustomCheckboxDemoState();
// }

// class _CustomCheckboxDemoState extends State<CustomCheckboxDemo> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom Checkbox with Padding'),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               isChecked = !isChecked;
//             });
//           },
//           child: Container(
//             padding: const EdgeInsets.all(4), // White space between grey border and green container
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey, // Outer grey border
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(4), // Optional rounded corners
//               color: Colors.white, // White space color
//             ),
//             child: Container(
//               width: 10,
//               height: 10,
//               decoration: BoxDecoration(
//                 color: isChecked ? Colors.green : Colors.white, // Inner green when checked
//                 borderRadius: BorderRadius.circular(2), // Optional inner corner rounding
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

