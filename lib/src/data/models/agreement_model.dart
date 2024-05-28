import 'dart:convert';

class Agreement {
  bool agreeFlag;
  String hstatus;
  String message;

  Agreement({
    required this.agreeFlag,
    required this.hstatus,
    required this.message,
  });

  factory Agreement.fromRawJson(String str) =>
      Agreement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Agreement.fromJson(Map<String, dynamic> json) => Agreement(
        agreeFlag: json["Agree_Flag"],
        hstatus: json["hstatus"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "Agree_Flag": agreeFlag,
        "hstatus": hstatus,
        "message": message,
      };
}
