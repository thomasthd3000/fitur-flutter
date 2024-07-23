import 'package:flutter/material.dart';
import '../data/models/handbook_model.dart';

class ListHandbookWidget extends StatelessWidget {
  const ListHandbookWidget({
    super.key,
    required this.dataHandbookEYES,
  });

  final List<Data> dataHandbookEYES;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      //padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: dataHandbookEYES.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: dataHandbookEYES[index].downloadFlag == true ? const Icon(Icons.file_download) : const Icon(Icons.file_copy),
          onTap: () {},
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              dataHandbookEYES[index].title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          subtitle: dataHandbookEYES[index].downloadFlag == true
              ? Column(
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
                )
              : const SizedBox(),
        );
      },
    );
  }
}
