// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:visible/src/data/models/handbook_model.dart';
import 'package:visible/src/screens/tabbar_widget_list.dart';

class TabBarTwo extends StatelessWidget {
  final ListHandbook data;

  const TabBarTwo({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Data> dataHandbookEYES = [];
    List<Data> dataHandbookMSHS = [];

    dataHandbookEYES = data.dataEyes;
    dataHandbookMSHS = data.dataMshs;

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            backgroundColor: Colors.blue[400],
            title: const Text(
              "Handbooks Parent",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(AppBar().preferredSize.height - 10),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.grey[200],
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent,
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'EYES',
                      ),
                      Tab(
                        text: 'MSHS',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ListHandbookWidget(dataHandbookEYES: dataHandbookEYES),
              ListHandbookWidget(dataHandbookEYES: dataHandbookMSHS),
            ],
          ),
        ),
      ),
    );
  }
}
