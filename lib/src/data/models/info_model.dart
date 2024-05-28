import 'dart:convert';

class Posts {
  String id;
  String title;
  String shortDesc;
  String grade;
  DateTime publishedAt;
  String mydate;
  String mytime;
  String fulldate;
  String gradeText;

  Posts({
    required this.id,
    required this.title,
    required this.shortDesc,
    required this.grade,
    required this.publishedAt,
    required this.mydate,
    required this.mytime,
    required this.fulldate,
    required this.gradeText,
  });

  factory Posts.fromRawJson(String str) => Posts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        id: json["id"],
        title: json["title"],
        shortDesc: json["short_desc"],
        grade: json["grade"],
        publishedAt: DateTime.parse(json["published_at"]),
        mydate: json["mydate"],
        mytime: json["mytime"],
        fulldate: json["fulldate"],
        gradeText: json["gradeText"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_desc": shortDesc,
        "grade": grade,
        "published_at": publishedAt.toIso8601String(),
        "mydate": mydate,
        "mytime": mytime,
        "fulldate": fulldate,
        "gradeText": gradeText,
      };
}
