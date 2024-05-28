// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TabBarTwo extends StatelessWidget {
  final String? type;

  const TabBarTwo({
    Key? key,
    this.type,
  }) : super(key: key);

  // final List<Tab> _allTabs = [
  //   const Tab(text: 'EYES'),
  //   const Tab(text: 'MSHS'),
  // ];

  @override
  Widget build(BuildContext context) {
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
              ListView.separated(
                //padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.file_open_outlined),
                    onTap: () {},
                    title: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Chat List Chat List Chat List Chat List Chat List $index",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                debugPrint("click button download");
                              },
                              child: const Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListView.separated(
                //padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.file_open_outlined),
                    onTap: () {},
                    title: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Adds 16 pixels of padding on all sides
                      child: Text(
                        "Chat List $index",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                debugPrint("click button download");
                              },
                              child: const Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
