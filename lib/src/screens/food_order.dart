// import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:visible/src/data/models/food_data.dart';
import 'package:visible/src/data/models/food_model.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:visible/src/controllers/food_controller.dart';
// import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FoodOrder extends StatefulWidget {
  const FoodOrder({Key? key}) : super(key: key);

  @override
  State<FoodOrder> createState() => _FoodOrderState();
}

class _FoodOrderState extends State<FoodOrder> {
  final formKeyFood = GlobalKey<FormState>();
  final gradeCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  String emailCtrl = 'ellenh@swa.com';
  String phoneCtrl = '081208379295';
  String selectedPaymentMethod = '';
  String? selectedOption;
  bool isShowGrade = false;
  double totalAmount = 0;
  double totalAll = 0;

  final FoodData foodData = FoodData();

  Map<String, bool> menuExpandedMap = {
    'Daily Set': false,
    'Pasta': false,
    'Breakfast & Stall': false,
  };

  Map<String, Map<String, bool>> isExpandedMap = {
    'Daily Set': {},
    'Pasta': {},
    'Breakfast & Stall': {},
  };

  Map<String, bool> isAllSelected = {
    'Daily Set': false,
    'Pasta': false,
    'Breakfast & Stall': false,
  };

  Map<String, bool> isWeek1Selected = {
    'Daily Set': false,
    'Pasta': false,
    'Breakfast & Stall': false,
  };

  Map<String, bool> isWeek2Selected = {
    'Daily Set': false,
    'Pasta': false,
    'Breakfast & Stall': false,
  };

  Map<String, Map<String, List<Product>>> menuItemsByCategoryAndDate = {
    'Daily Set': {},
    'Pasta': {},
    'Breakfast & Stall': {},
  };

  final Map<String, Map<String, bool>> checkedItems = {
    'Daily Set': {},
    'Pasta': {},
    'Breakfast & Stall': {},
  };

  late DailyMenu myDaily;
  late Daily dataDaily;
  int length = 0;

  @override
  void initState() {
    super.initState();
    myDaily = generateFlagIsExpanded();
  }

  NumberFormat currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

  void countTotal(bool value, int price, String selectedPaymentMethod) {
    if (value) {
      totalAmount += price;
    } else {
      totalAmount -= price;
    }

    if (selectedPaymentMethod == 'Bank Transfer') {
      totalAll = totalAmount + 4440;
    } else if (selectedPaymentMethod == 'QRIS/ GoPay') {
      totalAll = (totalAmount * 0.02) + totalAmount;
    } else {
      totalAll = totalAmount;
    }
  }

  bool checkWeek(int min, int max, DailyMenu myDaily, String category, int week) {
    bool shouldBreak = false;
    for (int i = min; i < max && !shouldBreak; i++) {
      if (category == 'Daily Set') {
        length = myDaily.daily[i].products.length;
        dataDaily = myDaily.daily[i];
      }

      if (category == 'Pasta') {
        length = myDaily.pasta[i].products.length;
        dataDaily = myDaily.pasta[i];
      }

      if (category == 'Breakfast & Stall') {
        length = myDaily.daily[i].products.length;
        dataDaily = myDaily.breakfast[i];
      }

      for (int x = 0; x < length; x++) {
        Product productweek = dataDaily.products[x];
        if (checkedItems[category]![productweek.itemId] == false) {
          if (week == 1) {
            isWeek1Selected[category] = false;
          }

          if (week == 2) {
            isWeek2Selected[category] = false;
          }

          isAllSelected[category] = false;
          shouldBreak = true;
          break;
        }
      }

      // if (category == 'Pasta') {
      //   for (int x = 0; x < myDaily.pasta[i].products.length; x++) {
      //     Product productweek = myDaily.pasta[i].products[x];

      //     if (checkedItems[category]![productweek.itemId] == false) {
      //       if (week == 1) {
      //         isWeek1Selected[category] = false;
      //       }

      //       if (week == 2) {
      //         isWeek2Selected[category] = false;
      //       }

      //       isAllSelected[category] = false;
      //       shouldBreak = true;
      //       break;
      //     }
      //   }
      // }
    }

    return shouldBreak;
  }

  DailyMenu generateFlagIsExpanded() {
    final dailyMenus = DailyMenu.fromJson(json.decode(foodData.food));

    for (String category in menuItemsByCategoryAndDate.keys) {
      if (category == 'Daily Set') {
        for (int i = 0; i < dailyMenus.daily.length; i++) {
          isExpandedMap[category]![dailyMenus.daily[i].date] = false;

          menuItemsByCategoryAndDate[category]![dailyMenus.daily[i].date] = dailyMenus.daily[i].products
              .map(
                (e) => Product(
                  itemId: e.itemId,
                  itemPrice: e.itemPrice,
                  itemName: e.itemName,
                  itemImage: e.itemImage,
                ),
              )
              .toList();

          for (var product in dailyMenus.daily[i].products) {
            checkedItems[category]![product.itemId] = false;
          }
        }
      }
      if (category == 'Pasta') {
        for (int i = 0; i < dailyMenus.pasta.length; i++) {
          isExpandedMap[category]![dailyMenus.pasta[i].date] = false;

          menuItemsByCategoryAndDate[category]![dailyMenus.pasta[i].date] = dailyMenus.pasta[i].products
              .map(
                (e) => Product(
                  itemId: e.itemId,
                  itemPrice: e.itemPrice,
                  itemName: e.itemName,
                  itemImage: e.itemImage,
                ),
              )
              .toList();

          for (var product in dailyMenus.pasta[i].products) {
            checkedItems[category]![product.itemId] = false;
          }
        }
      }

      if (category == 'Breakfast & Stall') {
        for (int i = 0; i < dailyMenus.breakfast.length; i++) {
          isExpandedMap[category]![dailyMenus.breakfast[i].date] = false;

          menuItemsByCategoryAndDate[category]![dailyMenus.breakfast[i].date] = dailyMenus.breakfast[i].products
              .map(
                (e) => Product(
                  itemId: e.itemId,
                  itemPrice: e.itemPrice,
                  itemName: e.itemName,
                  itemImage: e.itemImage,
                ),
              )
              .toList();

          for (var product in dailyMenus.breakfast[i].products) {
            checkedItems[category]![product.itemId] = false;
          }
        }
      }
    }
    //print(checkedItems);
    return dailyMenus;
  }

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
          "FOOD ORDER",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.98,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKeyFood,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InputFieldText(
                        title: 'Email',
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        controller: TextEditingController(text: emailCtrl),
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailCtrl = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      const InputFieldText(
                        title: 'Parent Phone Number',
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        controller: TextEditingController(text: phoneCtrl),
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phoneCtrl = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      const InputFieldText(
                        title: 'Student Name',
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.98,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade400, // Set border color
                            //width: 2.0, // Set border width
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration.collapsed(hintText: ''),
                          hint: const Text("Select the student"),
                          isExpanded: true,
                          iconSize: 40,
                          //underline: const SizedBox(),
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue;
                              gradeCtrl.text = foodData.student.firstWhere((item) => item['STEXT'] == newValue)['GRADETXT']!;
                              isShowGrade = true;
                            });
                          },
                          items: foodData.student.map<DropdownMenuItem<String>>((Map<String, String> value) {
                            return DropdownMenuItem<String>(
                              value: value['STEXT'],
                              child: Text(value['STEXT']!),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      isShowGrade
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const InputFieldText(
                                  title: 'Grade',
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: const TextStyle(color: Colors.grey),
                                  controller: gradeCtrl,
                                  textAlignVertical: TextAlignVertical.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a grade';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    gradeCtrl.text = value!;
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.black,
                      ),

                      //BUILD BUTTON FOOD
                      _buildMenuButton('Daily Set'),
                      if (menuExpandedMap['Daily Set']!) ...[
                        const SizedBox(height: 10),
                        _buildCheckbox('Daily Set', myDaily),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Week 1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        ..._buildDateButtonsWeek1('Daily Set', myDaily),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Week 2',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        ..._buildDateButtonsWeek2('Daily Set', myDaily),
                      ],
                      const SizedBox(height: 20),
                      _buildNotesSection(),
                      _buildPaymentSection(),
                      _buildTotalSection(),
                      // _buildMenuButton('Pasta'),
                      // if (menuExpandedMap['Pasta']!) ...[
                      //   const SizedBox(height: 10),
                      //   _buildCheckbox('pasta'),
                      // ],
                      // _buildMenuButton('Breakfast & Stall'),
                      // if (menuExpandedMap['Breakfast & Stall']!) ...[
                      //   const SizedBox(height: 10),
                      //   _buildCheckbox('breakfast'),
                      // ],
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 150,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total', textAlign: TextAlign.left, style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(currencyFormat.format(totalAll), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {},
                child: const Text(
                  'Order Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Divider(
          color: Colors.black,
        ),
        const Text('We accept bank transfer and QRIS for instant payment. Your order will be processed directly after the payment is received.'),
        const SizedBox(height: 10),
        const Text('Note:', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('There will be a fee per transaction'),
        const SizedBox(height: 10),
        _buildPaymentOption('Bank Transfer', '+ Rp.4.440'),
        _buildPaymentOption('QRIS/ GoPay', '+ 2%'),
      ],
    );
  }

  Widget _buildPaymentOption(String paymentMethod, String fee) {
    return Card(
      color: const Color.fromARGB(255, 242, 242, 242),
      child: RadioListTile<String>(
        activeColor: Colors.blue,
        title: Text(
          paymentMethod,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          fee,
          style: const TextStyle(color: Colors.red),
        ),
        value: paymentMethod,
        groupValue: selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            selectedPaymentMethod = value!;

            if (paymentMethod == 'Bank Transfer') {
              totalAll = totalAmount + 4440;
            } else if (paymentMethod == 'QRIS/ GoPay') {
              totalAll = (totalAmount * 0.02) + totalAmount;
            }
          });
        },
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: notesCtrl,
          decoration: InputDecoration(
            hintText: 'Please fill the notes here',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              notesCtrl.text = value;
            });
          },
          onSaved: (value) {
            notesCtrl.text = value ?? '';
          },
        ),
      ],
    );
  }

  List<Widget> _buildDateButtonsWeek1(String category, DailyMenu data) {
    List<Widget> dateButtons = [];

    for (int i = 0; i < 5; i++) {
      dateButtons.add(_buildDateButton(category, myDaily.daily[i].date, data, myDaily.daily[i].isHoliday, myDaily.daily[i].holiday));
    }

    return dateButtons;
  }

  List<Widget> _buildDateButtonsWeek2(String category, DailyMenu data) {
    List<Widget> dateButtons = [];

    for (int i = 5; i < 10; i++) {
      dateButtons.add(_buildDateButton(category, myDaily.daily[i].date, data, myDaily.daily[i].isHoliday, myDaily.daily[i].holiday));
    }

    return dateButtons;
  }

  Widget _buildDateButton(String category, String tanggal, DailyMenu data, bool isHoliday, String holiday) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
            ),
            onPressed: () {
              setState(() {
                isExpandedMap[category]![tanggal] = !isExpandedMap[category]![tanggal]!;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tanggal,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Icon(
                  isExpandedMap[category]![tanggal]! ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          if (isExpandedMap[category]![tanggal]!)
            Column(
              children: isHoliday
                  ? [
                      Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(holiday),
                          // subtitle: Text('\$${menuItem.itemPrice.toStringAsFixed(2)}'),
                        ),
                      )
                    ]
                  : menuItemsByCategoryAndDate[category]![tanggal]!
                      .asMap()
                      .map(
                        (index, menuItem) => MapEntry(
                          index,
                          _buildMenuItem(
                            menuItem,
                            category,
                            tanggal,
                            index,
                            menuItemsByCategoryAndDate[category]![tanggal]!,
                            data,
                          ),
                        ),
                      )
                      .values
                      .toList(),
              // menuItemsByCategoryAndDate[category]![tanggal]!
              //     .map((menuItem) => _buildMenuItem(menuItem, category))
              //     .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Product menuItem, String category, String tanggal, int index, productByDate, DailyMenu data) {
    return Container(
      color: Colors.grey.shade200,
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: (index == 0 && category == 'Daily Set')
              ? Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            menuItem.itemName,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            currencyFormat.format(menuItem.itemPrice),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icon_food.png",
                      width: 60, // Adjust the width as needed
                      height: 60,
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            menuItem.itemName,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(currencyFormat.format(menuItem.itemPrice)),
                        ),
                      ],
                    ),
                  ],
                ),
          // subtitle: Text('\$${menuItem.itemPrice.toStringAsFixed(2)}'),
          leading: SizedBox(
            width: 20,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (!states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.blue;
              }),
              value: checkedItems[category]![menuItem.itemId],
              onChanged: (bool? value) {
                setState(() {
                  checkedItems[category]![menuItem.itemId] = value ?? false;

                  if (category == 'Daily Set') {
                    if (index == 0) {
                      //check all items under daily set
                      for (int i = 1; i < productByDate.length; i++) {
                        Product product = productByDate[i];
                        checkedItems[category]![product.itemId] = value ?? false;
                      }
                      // use price daily set
                      countTotal(
                        value!,
                        menuItem.itemPrice,
                        selectedPaymentMethod,
                      );
                    } else {
                      //check based on date
                      bool flagDaily = true;
                      for (int i = 1; i < productByDate.length; i++) {
                        Product productLoop = productByDate[i];

                        if (checkedItems[category]![productLoop.itemId] == false) {
                          flagDaily = false;
                        }
                      }

                      Product productDailySet = productByDate[0];
                      if (flagDaily == false) {
                        checkedItems[category]![productDailySet.itemId] = false;

                        countTotal(
                          value!,
                          menuItem.itemPrice,
                          selectedPaymentMethod,
                        );
                      } else {
                        checkedItems[category]![productDailySet.itemId] = true;

                        countTotal(
                          value!,
                          menuItem.itemPrice,
                          selectedPaymentMethod,
                        );

                        for (int i = 1; i < productByDate.length; i++) {
                          Product productCheck = productByDate[i];
                          if (checkedItems[category]![productCheck.itemId]! == true) {
                            totalAmount -= productCheck.itemPrice;
                          }
                        }

                        countTotal(
                          value,
                          productDailySet.itemPrice,
                          selectedPaymentMethod,
                        );
                      }
                    }
                  } else {
                    // nambah value jika bukan daily set
                    countTotal(
                      value!,
                      menuItem.itemPrice,
                      selectedPaymentMethod,
                    );
                  }

                  //check all and check week
                  bool week1 = checkWeek(0, 5, myDaily, category, 1);
                  bool week2 = checkWeek(5, 10, myDaily, category, 2);

                  if (week1 == false) {
                    isWeek1Selected[category] = true;
                  }

                  if (week2 == false) {
                    isWeek2Selected[category] = true;
                  }

                  if (week1 == false && week2 == false) {
                    isAllSelected[category] = true;
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String text, DailyMenu data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedCheckboxWithText(
          label: 'All',
          value: isAllSelected[text]!,
          onChanged: (bool? value) {
            setState(() {
              isAllSelected[text] = value ?? false;
              if (isAllSelected[text]!) {
                isWeek1Selected[text] = true;
                isWeek2Selected[text] = true;
              } else {
                isWeek1Selected[text] = false;
                isWeek2Selected[text] = false;
              }

              if (text == 'Daily Set') {
                String tmpCat = 'Daily Set';
                for (int i = 0; i < data.daily.length; i++) {
                  for (int x = 0; x < data.daily[i].products.length; x++) {
                    checkedItems[tmpCat]![data.daily[i].products[x].itemId] = value!;
                    if (x == 0) {
                      countTotal(value, data.daily[i].products[x].itemPrice, selectedPaymentMethod);
                    }
                  }
                }
              }

              if (text == 'Pasta') {
                String tmpCat = 'Pasta';
                for (int i = 0; i < data.pasta.length; i++) {
                  for (var product in data.pasta[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }

              if (text == 'Breakfast & Stall') {
                String tmpCat = 'Breakfast & Stall';
                for (int i = 0; i < data.breakfast.length; i++) {
                  for (var product in data.breakfast[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }
            });
          },
        ),
        RoundedCheckboxWithText(
          label: 'Week 1',
          value: isWeek1Selected[text]!,
          onChanged: (bool? value) {
            setState(() {
              isWeek1Selected[text] = value ?? false;
              if (isWeek1Selected[text]! && isWeek2Selected[text]!) {
                isAllSelected[text] = true;
              } else {
                isAllSelected[text] = false;
              }

              if (text == 'Daily Set') {
                String tmpCat = 'Daily Set';
                for (int i = 0; i < 5; i++) {
                  for (int x = 0; x < data.daily[i].products.length; x++) {
                    checkedItems[tmpCat]![data.daily[i].products[x].itemId] = value!;

                    if (x == 0) {
                      countTotal(value, data.daily[i].products[x].itemPrice, selectedPaymentMethod);
                    }
                  }
                }
              }

              if (text == 'Pasta') {
                String tmpCat = 'Pasta';
                for (int i = 0; i < 5; i++) {
                  for (var product in data.pasta[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }

              if (text == 'Breakfast & Stall') {
                String tmpCat = 'Breakfast & Stall';
                for (int i = 0; i < 5; i++) {
                  for (var product in data.breakfast[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }
            });
          },
        ),
        RoundedCheckboxWithText(
          label: 'Week 2',
          value: isWeek2Selected[text]!,
          onChanged: (bool? value) {
            setState(() {
              isWeek2Selected[text] = value ?? false;
              if (isWeek2Selected[text]! && isWeek1Selected[text]!) {
                isAllSelected[text] = true;
              } else {
                isAllSelected[text] = false;
              }

              if (text == 'Daily Set') {
                String tmpCat = 'Daily Set';
                for (int i = 5; i < 10; i++) {
                  for (int x = 0; x < data.daily[i].products.length; x++) {
                    checkedItems[tmpCat]![data.daily[i].products[x].itemId] = value!;

                    if (x == 0) {
                      countTotal(value, data.daily[i].products[x].itemPrice, selectedPaymentMethod);
                    }
                  }
                }
              }

              if (text == 'Pasta') {
                String tmpCat = 'Pasta';
                for (int i = 5; i < 10; i++) {
                  for (var product in data.pasta[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }

              if (text == 'Breakfast & Stall') {
                String tmpCat = 'Breakfast & Stall';
                for (int i = 5; i < 10; i++) {
                  for (var product in data.breakfast[i].products) {
                    checkedItems[tmpCat]![product.itemId] = value!;
                    countTotal(value, product.itemPrice, selectedPaymentMethod);
                  }
                }
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildMenuButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16)),
        onPressed: () {
          setState(() {
            menuExpandedMap[text] = !menuExpandedMap[text]!;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
            Icon(color: Colors.white, menuExpandedMap[text]! ? Icons.expand_less : Icons.expand_more),
          ],
        ),
      ),
    );
  }
}

class RoundedCheckboxWithText extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RoundedCheckboxWithText({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.white,
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (!states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.blue;
            }),
            value: value,
            onChanged: onChanged,
          ),
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class InputFieldText extends StatelessWidget {
  const InputFieldText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
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
