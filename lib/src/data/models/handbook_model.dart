import 'dart:convert';

class ListHandbook {
  List<Data> dataEyes;
  List<Data> dataMshs;
  String type;

  ListHandbook({
    required this.dataEyes,
    required this.dataMshs,
    required this.type,
  });

  factory ListHandbook.fromRawJson(String str) =>
      ListHandbook.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListHandbook.fromJson(Map<String, dynamic> json) => ListHandbook(
        dataEyes:
            List<Data>.from(json["data_eyes"].map((x) => Data.fromJson(x))),
        dataMshs:
            List<Data>.from(json["data_mshs"].map((x) => Data.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data_eyes": List<dynamic>.from(dataEyes.map((x) => x.toJson())),
        "data_mshs": List<dynamic>.from(dataMshs.map((x) => x.toJson())),
        "type": type,
      };
}

class Data {
  String title;
  String pdfLink;
  bool downloadFlag;
  String department;
  String downloadLink;

  Data({
    required this.title,
    required this.pdfLink,
    required this.downloadFlag,
    required this.department,
    required this.downloadLink,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        pdfLink: json["pdf_link"],
        downloadFlag: json["download_flag"],
        department: json["department"],
        downloadLink: json["download_link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "pdf_link": pdfLink,
        "download_flag": downloadFlag,
        "department": department,
        "download_link": downloadLink,
      };
}
