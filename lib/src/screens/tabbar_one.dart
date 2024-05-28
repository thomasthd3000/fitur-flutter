// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TabBarOne extends StatelessWidget {
  final String? type;

  const TabBarOne({
    Key? key,
    this.type,
  }) : super(key: key);

  // final List<Tab> _allTabs = [
  //   const Tab(text: 'EYES'),
  //   const Tab(text: 'MSHS'),
  // ];

  @override
  Widget build(BuildContext context) {
    String textTab = '';
    if (type == "E") {
      textTab = "EYES Parent and Student Hanbook";
    } else if (type == "M") {
      textTab = "MSHS Parent and Student Hanbook";
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 1,
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
                    tabs: [
                      Tab(
                        text: textTab,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(15),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.file_download),
                    onTap: () {},
                    title: Text("Chat List $index"),
                    subtitle: const Text("Tab bar"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
